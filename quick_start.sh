
DEVERSION=$(curl -s https://api.github.com/repos/datalake/datalake/releases/latest | grep -e "\"tag_name\"" | sed -r 's/.*: "(.*)",/\1/')

echo "开始下载 DataLake ${DEVERSION} 版本在线安装包"

datalake_online_file_name="datalake-${DEVERSION}-online.tar.gz"
download_url="https://github.com/datalake/datalake/releases/download/${DEVERSION}/${datalake_online_file_name}"

echo "下载地址： ${download_url}"

curl -LOk -m 60 -o ${datalake_online_file_name} ${download_url}

if [ ! -f ${datalake_online_file_name} ];then
	echo "下载在线安装包失败，请试试重新执行一次安装命令。"
	exit 1
fi

tar zxvf ${datalake_online_file_name}
if [ $? != 0 ];then
	echo "下载在线安装包失败，请试试重新执行一次安装命令。"
	rm -f ${datalake_online_file_name}
	exit 1
fi
cd datalake-${DEVERSION}-online

/bin/bash install.sh