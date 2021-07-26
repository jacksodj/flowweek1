pub struct Canvas {

  pub let width: UInt8
  pub let height: UInt8
  pub let pixels: String

  init(width: UInt8, height: UInt8, pixels: String) {
    self.width = width
    self.height = height
    // The following pixels
    // 123
    // 456
    // 789
    // should be serialized as
    // 123456789
    self.pixels = pixels
  }
}

pub fun serializeStringArray(_ lines: [String]): String {
  var buffer = ""
  for line in lines {
    buffer = buffer.concat(line)
  }

  return buffer
}

pub resource Picture {

  pub let canvas: Canvas
  
  init(canvas: Canvas) {
    self.canvas = canvas
  }
}

pub fun stringify(array: [String]): String {
  let output = stringConcat(left: "", right: array)
  return output

}

pub fun stringConcat(left: String, right: [String]):String {
  let newLeft = left.concat(right.removeFirst())
  if right.length == 0 {
    return newLeft  
  } else {
    let recurrLeft = stringConcat(left: newLeft, right: right)
    return recurrLeft
  }
}

pub fun display(canvas: Canvas) {
  var headfoot =["+","+"]

  var col: Int = 0
  while col < Int(canvas.width) {
    headfoot.insert(at:1, "-")
    col = col + 1
  }

  log(stringify(array: headfoot))
  var row: Int = 0
  var canvasLine: [String] = []
  while row < Int(canvas.height) {
    col = 0
    canvasLine = ["|","|"]
    while col < Int(canvas.width){
      var pos: Int = Int(canvas.width) * row + col
      canvasLine.insert(at:1, canvas.pixels.slice(from: pos, upTo: pos+1))
      col = col + 1
    }
    log(stringify(array: canvasLine))
    row = row + 1
  }
  log(stringify(array: headfoot))
}

pub fun main() {
  let pixelsX = [
    "*   *",
    " * * ",
    "  *  ",
    " * * ",
    "*   *"
  ]
  let canvasX = Canvas(
    width: 5,
    height: 5,
    pixels: serializeStringArray(pixelsX)
  )
  let letterX <- create Picture(canvas: canvasX)
  log(letterX.canvas)

  log("printing framed canvas")
  display(canvas: letterX.canvas)
  
  destroy letterX
}
// {"mode":"full","isActive":false}