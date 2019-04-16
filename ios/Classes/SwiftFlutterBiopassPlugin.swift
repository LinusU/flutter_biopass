import Flutter
import Foundation

import BioPass
import PromiseKit

extension Promise {
    func flutter(_ result: @escaping FlutterResult) {
        self.done {
            result($0)
        }.catch {
            result(FlutterError(code: "EUNKNOWN", message: $0.localizedDescription, details: nil))
        }
    }
}

public class SwiftFlutterBiopassPlugin: NSObject, FlutterPlugin {
    static var instances = Dictionary<String, BioPass>()

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_biopass", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterBiopassPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
            case "init":
                let id = UUID().uuidString
                let serviceName = (call.arguments as! Dictionary<String, AnyObject>)["serviceName"] as? String
                let sharedAccessGroupName = (call.arguments as! Dictionary<String, AnyObject>)["sharedAccessGroupName"] as? String

                if let serviceName = serviceName {
                    SwiftFlutterBiopassPlugin.instances[id] = BioPass(serviceName)
                } else if let sharedAccessGroupName = sharedAccessGroupName {
                    SwiftFlutterBiopassPlugin.instances[id] = BioPass(withSharedAccessGroup: sharedAccessGroupName)
                } else {
                    SwiftFlutterBiopassPlugin.instances[id] = BioPass()
                }

                result(id)
            case "dispose":
                let id = (call.arguments as! Dictionary<String, AnyObject>)["id"] as! String
                SwiftFlutterBiopassPlugin.instances[id] = nil
                result(nil)
            case "store":
                let id = (call.arguments as! Dictionary<String, AnyObject>)["id"] as! String
                let password = (call.arguments as! Dictionary<String, AnyObject>)["password"] as! String
                SwiftFlutterBiopassPlugin.instances[id]!.store(password).map({ _ -> AnyObject? in nil }).flutter(result)
            case "retreive":
                let id = (call.arguments as! Dictionary<String, AnyObject>)["id"] as! String
                let prompt = (call.arguments as! Dictionary<String, AnyObject>)["prompt"] as! String
                SwiftFlutterBiopassPlugin.instances[id]!.retreive(withPrompt: prompt).flutter(result)
            case "delete":
                let id = (call.arguments as! Dictionary<String, AnyObject>)["id"] as! String
                SwiftFlutterBiopassPlugin.instances[id]!.delete().map({ _ -> AnyObject? in nil }).flutter(result)
            default:
                result(FlutterMethodNotImplemented)
        }
    }
}
