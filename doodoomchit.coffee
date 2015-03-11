# Description:
#   두둠칫
#
# Commands:
#   None
#

ddc = "⊂_ヽ \
　 ＼＼ Λ＿Λ \
　　 ＼( 'ㅅ' ) 두둠칫 \
　　　 >　⌒ヽ \
　　　/ 　 へ＼ \
　　 /　　/　＼＼ \
　　 ﾚ　ノ　　 ヽ_つ \
　　/　/두둠칫 \
　 /　/| \
　(　(ヽ \
　|　|、＼ \
　| 丿 ＼ ⌒) \
　| |　　) / \
`ノ )　　Lﾉ"

module.exports = (robot) ->
  robot.hear /두둠칫/, (msg) ->
      msg.send ddc
