

import Foundation


class UserInfo:Identifiable {

    var userId:String?
    var firstName:String?
    var email:String?
    var lastName:String?
    
    static func parseJSON(data:Any?)->ResponseResult<Any>? {

        //check json data
       guard let jsonData = data as? Data else {return nil}
        
        do {
            let jsonObj = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments)
            
            print(jsonObj)
            
            var arrItems = [[String:Any]]()
            if let dictJSONObj = jsonObj as? [String:Any] {
           
                if let results = dictJSONObj["results"] {
                    
                    if let dict = results as? [String:Any] {
                        arrItems.append(dict)
                    }
                    else if let arr = results as? [[String:Any]] {
                        arrItems = arr
                    }
                }
            }
           
            
        
        }  catch {
            return .failure(error)
        }
        
        return nil
   }

}
