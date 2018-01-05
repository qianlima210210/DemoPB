
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let lib = getLibrary()
        do {
            let jsonStr = try lib.jsonString()
            print("生成的Json为：\n\(jsonStr)")
            print("Json的长度为：\(jsonStr.lengthOfBytes(using: .utf8)) bytes")
            
            // 生成Protobuf二进制
            let protoData: Data = try lib.serializedData()
            print("生成的二进制大小为：\(protoData.count) bytes")
            
            //保存到偏好
            let ud = UserDefaults.standard
            ud.set(protoData, forKey: "PB")
            
        } catch  {
            
            print(error)
        }
        
        
    }

    func getLibrary() -> MyLibrary {
        var bookInfo = BookInfo()
        bookInfo.id = 100
        bookInfo.title = "swift book"
        bookInfo.author = "Apple Inc"
        
        var lib = MyLibrary()
        lib.id = 1000
        lib.name = "新华书店"
        lib.books = [bookInfo]
        lib.keys = ["kind":"国营", "createTime":"2001.10,01"]
        
        return lib
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let ud = UserDefaults.standard
        let readData =  ud.value(forKey: "PB")
        
        if let readData = readData as? Data{
            do {
                
                let readLibrary = try MyLibrary(serializedData: readData)
                print("读取demoData文件JSON为：\n \(try readLibrary.jsonString())")
                print(readLibrary.bookCount())
                
            } catch  {
                
            }
        }
    }
    
    
}



















