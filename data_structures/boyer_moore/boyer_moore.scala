import scala.collection.mutable.ArrayBuffer

class Pattern(val pattern: String) {

  val length  = pattern.length

  def shiftBy(badChar: Char, pos: Int): Int = {
    scala.math.max(badCharShift(badChar, pos), goodSuffixShift(pos))
  }

  def badCharShift(badChar: Char, pos: Int): Int = {
    val matches = for (i <- 0.until(pos) if (pattern(i) == badChar)) yield i

    if (matches.isEmpty) pos else (pos - matches.max)
  }

  def goodSuffixShift(pos: Int): Int = {
    val goodSuffix = pattern.slice(pos+1, length-1)
    val matches = for (k <- 0.until(pos) if (pattern.slice(0, k).endsWith(goodSuffix))) yield k

    val max = if (matches.isEmpty) 0 else matches.max

    (length - max - 1)
  }
}

class Search(val text: String) {

  var pattern: Pattern          = null
  var matches: ArrayBuffer[Int] = null

  def search(str: String): ArrayBuffer[Int] = {
    pattern   = new Pattern(str)
    matches   = new ArrayBuffer[Int]
    var shift = pattern.length - 1

    while (shift < text.length) {
      val (mismatchPos, mismatchChr) = checkText(shift)

      if (mismatchPos == -1) {
        matches += shift
        shift   += pattern.length
      } else shift += pattern.shiftBy(mismatchChr, mismatchPos)
    }

    matches
  }

  def checkText(shift: Int): Tuple2[Int, Char] = {

    var k    = 0
    var pLen = pattern.length - 1

    while ((pLen >= k) && (pattern.pattern(pLen - k) == text(shift - k))) k += 1

    if (pLen < k) (-1, "f"(0)) else ((pLen-k), text(shift-k))
  }

  def printMatches(context: Int = 10): Unit = {
    matches.foreach( pos => {
      var matchBeg = pos - pattern.length + 1
      var matchEnd = pos
      matchBeg = scala.math.max(0, (matchBeg - context))
      matchEnd = scala.math.min((text.length-1), (matchEnd + context))

      var matchText = text.slice(matchBeg, matchEnd).replace(pattern.pattern, "\033[31;1m" + pattern.pattern + "\033[0m")

      Console.printf("\033[33;1m%5d:\033[0m ...%s...\n", (pos-pattern.length+1), matchText)
    })
  }
}

val text = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
val bm = new Search( text )

Array("Lorem", "ipsum", "ad", "minim").foreach( str => {
  println("Searching for " + str)
  bm.search(str)
  bm.printMatches()
  println()
})
