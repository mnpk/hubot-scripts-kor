# Description:
#   두둠칫
#
# Commands:
#   None
#

ddc = "⊂_ヽ \n\
　 ＼＼ Λ＿Λ \n\
　　 ＼( 'ㅅ' ) 두둠칫 \n\
　　　 >　⌒ヽ \n\
　　　/ 　 へ＼ \n\
　　 /　　/　＼＼ \n\
　　 ﾚ　ノ　　 ヽ_つ \n\
　　/　/두둠칫 \n\
　 /　/| \n\
　(　(ヽ \n\
　|　|、＼ \n\
　| 丿 ＼ ⌒) \n\
　| |　　) / \n\
`ノ )　　Lﾉ"

module.exports = (robot) ->
  robot.hear /두둠칫/, (msg) ->
      msg.send ddc
