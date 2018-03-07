//: Playground - noun: a place where people can play

import UIKit
extension Array {
    public mutating func shuffleUseSort() -> Array {
        var list = self
        for index in 0..<list.count {
            let newIndex = Int(arc4random_uniform(UInt32(list.count-index))) + index
            if index != newIndex {
                list.swapAt(index, newIndex)
            }
        }
        return list
    }
}

// 测试“随机程度”，对数组排序 1 万次，然后看第一个数的值的分布
func test() {
    var array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    var (a, b, c, d, e, f, g, h, i, j) = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    for _ in 0..<1_0000 {
        switch array.shuffleUseSort()[0] {
        case 1: a += 1
        case 2: b += 1
        case 3: c += 1
        case 4: d += 1
        case 5: e += 1
        case 6: f += 1
        case 7: g += 1
        case 8: h += 1
        case 9: i += 1
        case 10: j += 1
        default: break
        }
    }
    print("第一个数值的分布:\(a, b, c, d, e, f, g, h, i, j)")
}
//test()


// 测试性能，对元素个数为 10 万个的数组排序所需的时间
let interval = NSDate().timeIntervalSince1970
var arr = [Int](repeatElement(100, count: 10_000))
arr.shuffleUseSort()
let interval1 = NSDate().timeIntervalSince1970
print("所需时间:\(interval1 - interval)")

