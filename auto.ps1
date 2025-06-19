$IOTD_NAME = 'Image of the day: '
$SHARE_LIST = '<ul class="share"><li>'
$WALL_PERM = 'Download this image. ' +
	'Use of this image is restricted to wallpaper only.'
$IMG_UNAVAIL = 'This image is not available to download as wallpaper.'

$res = Invoke-WebRequest "https://bing.com"
$iSplit = $res.Content -split '<div class="musCardCont">'
$mscard = ($iSplit[1] -split '<div class="headline">')[0]
$iquery = (($mscard -split 'search\?q=')[1] -split '&amp;')[0]
$imdate =  (($mscard -split '&quot;')[1] -split '_')[0] + '01'
$titled = ((($mscard -split $IOTD_NAME)[1] -split '>')[1] -split '<')[0]
$copyrt = (($mscard -split 'id="copyright">')[1] -split '<')[0]
$permis = ((($mscard -split $SHARE_LIST)[1] -split 'title="')[1] -split '"')[0]

# PRINT IMAGE DATA
"`n"
$imdate
$titled
$copyrt
if ( $permis -eq $WALL_PERM )
{
	$srckey = ($mscard -split 'th\?id=OHR.')[1] -split '_'
	$source = $srckey[0] + '_' + $srckey[1]
	$source
} elseif ( $permis -eq $IMG_UNAVAIL )
{
	$IMG_UNAVAIL
	"Open bing.com in your browser, hold down Ctrl + Shift and hit"
	"key 'I' to go to Developer Tools. In Developer Tools click the"
	"Console tab and execute the following JavaScript:"
	'document.getElementById("img_cont").getAttribute("style").split("url")[1]'
	'and either a bing.com query or blob URL will be shown as the image source.'
}
$iquery
"`n"

# The endgame is not to print image data to console, but to record the data
# for the app's use. To save cloud costs, the script would be developed to
# write to JSON or other NoSQL database rather than to say automate data entry
# into a Doctrine-like controller. Oh, but wait, Doctrine ORM is database 
# agnostic? So the object mapping doesn't have to be to SQL? Anyway, I'm sure
# the analogous data system in ASP.NET can do all the same.
