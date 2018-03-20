

import Foundation


struct EXHUserInfoRequest:EXHRequestable {
    var apiPath:String?
    var httpType:HttpType
    var pathType :EXHPostServicePath?
    var modelType:Identifiable.Type? {
        return UserInfo.self
    }
    var queryParams:[String:String]?
}


class UserInfo:Identifiable {

    var first_name:String?
    var last_name:String?
    var email:String?
    var phone:String?
    var password:String?
    var signType:String?
    var userType:String?
    var uniqueId:String?
    
    //response coming from server
   
    
    static func parseJSON(data:Any?)->ResponseResult<Any>? {

        //check json data
       guard let jsonData = data as? Data else {return nil}
        
        do {
            let jsonObj = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments)
            
            print(jsonObj)
            
          //  var arrItems = [[String:Any]]()
            if let dictJSONObj = jsonObj as? [String:Any] {
           
                if let results = dictJSONObj["User"] {
                    
                    let userInfo = UserInfo()
                    
                    if let dict = results as? [String:Any] {
                        
                        userInfo.first_name = dict["FirstName"] as? String
                        userInfo.last_name = dict["LastName"] as? String
                        userInfo.email = dict["Email"] as? String
                        userInfo.phone = dict["Phone"] as? String
                        userInfo.password = dict["Password"] as? String
                        userInfo.signType = dict["SignType"] as? String
                        userInfo.userType = dict["UserType"] as? String
                        userInfo.uniqueId = dict["UniqueId"] as? String
                    }
                  
                    return .success(userInfo)
                  
                }
            }
        }  catch {
            
            return .failure(error)
        }
        
        return nil
   }

}
