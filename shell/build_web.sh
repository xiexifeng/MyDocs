rootName=$1
projectName=$2
branch=$3
user=webBuild
pwd=sa147!123
echo "rootName：$rootName";
echo "projectName：$projectName";
echo "branch：$branch";
rm -rf ${projectName};
git clone -b ${branch} http://${user}:${pwd}@git.pm.emarineonline.com/MarineOnline_Frontend_Library/${projectName}.git
if test -d $pojectName
then
	echo "code clone successed";
else
	echo "code clone failed,will exit";
	exit;
fi
echo "begin build"
v1=`date +%s`
cd ${projectName}
npm config set registry http://nexus.pm.emarineonline.com/repository/npm_group/
yarn config set phantomjs_cdnurl http://cnpmjs.org/downloads
yarn install --production=false 
#echo "install successed";
yarn config set strict-ssl ""
CI="" yarn build
v2=`date +%s`
v3=`expr $v2 - $v1`
echo "build successed,cost time: $v3 s";

rm -rf /home/user/web/${rootName}/*
echo "delete /home/user/web/$rootName success"
cp -rf build/* /home/user/web/${rootName}/
echo "deploy successed";

