import strutils, math, lists, sdl2, sdl2.mixer

# sdl init
sdl2.init(INIT_EVERYTHING)

proc playAwesomeSound =
  #var sound : ChunkPtr
  var sound2 : MusicPtr

  var channel : cint
  var audio_rate : cint
  var audio_format : uint16
  var audio_buffers : cint    = 4096
  var audio_channels : cint   = 2

  if mixer.openAudio(audio_rate, audio_format, audio_channels, audio_buffers) != 0:
      echo("There was a problem")

  #sound = mixer.loadWAV("airhorn.wav")
  sound2 = mixer.loadMUS("airhorn.ogg")
  if isNil(sound2):
      echo("Unable to load sound file")

  #channel = mixer.playChannel(-1, sound, 0); #wav
  channel = mixer.playMusic(sound2, 1); #ogg/flac
  if channel == -1:
      echo("Unable to play sound")


# check array passed in
proc isSorted(arr: openArray[string]): bool =
  assert len(arr) >= 2
  var prevVal = arr[0]
  for curIdx in 1..high(arr):
    if parseInt(arr[curIdx]) < parseInt(prevVal):
      return false
    else:
      prevVal = arr[curIdx]
  # It's sorted, EHRMAGERD!
  return true

# shuffle array passed in
proc shuffle(arr: var openArray[string]) =
  var resultArr : string = ""

  var resultIndex = 0
  
  while len(arr) > resultIndex:
    var rando = random(len(arr))
    #echo "checking arr[rando]: ", arr[rando]
    if arr[rando] != "pancakes":
      resultArr = resultArr & arr[rando] & " "
      inc(resultIndex)
      arr[rando] = "pancakes"

  #echo "ResultArray is ", resultArr

  # We're shuffled, set arr to resultArr
  var newArr = resultArr.split(" ")
  for idx in 0..high(arr):
    arr[idx] = newArr[idx]


## Main():
echo "Please enter a space-delimited number list: "

let numbers = stdin.readLine()
var seq2sort = numbers.split(" ")

echo seq2sort

randomize()

var animChar = initDoublyLinkedRing[string]()
animChar.append("\\")
animChar.append("|")
animChar.append("/")
animChar.append("-")
var curAnimChar = animChar.head
var numTries = 0
while true:
  # SHUFFLE IT!!
  shuffle(seq2sort)
  inc(numTries)
  #echo seq2sort
  if ((numTries mod 5000) == 0):
    stdout.write "\b", curAnimChar.value
    curAnimChar = curAnimChar.next


  if isSorted(seq2sort):
    playAwesomeSound()
    echo seq2sort
    echo "Only took ", numTries, " tries!!"
    break

