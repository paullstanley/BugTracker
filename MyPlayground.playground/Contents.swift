import Cocoa

let arr = [1,2,2,3,3,3,4]

var containerArr: Set<Int> = []
var dupeCount = 0
var indexcontents = arr[0]
for i in 1..<arr.count {
  if arr[i] == indexcontents {
    dupeCount += 1
    containerArr.insert(arr[i])
  }
  indexcontents = arr[i]
}
print(containerArr)
print(containerArr.count)
print(dupeCount)


