#!/bin/bash - 
#===============================================================================
#
#          FILE: backup_file.sh
# 
#         USAGE: ./backup_file.sh 
# 
#   DESCRIPTION: 在所监控的配置文件或者配置文件的目录被修改或者被删除
#				 时，回触发脚本去执行备份操作
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 09/20/2015 10:10
#      REVISION:  v0.1
#===============================================================================

#####函数定义部分##############
writeLog(){
	cur_time=$(date +"%Y-%m-%d %H:%M:%S")
	cur_date=$(date +"%Y%m%d")
	log_name=${cur_date}"".log
	echo "${cur_time}|$1" >> ./backup_file.${log_name}
}

###检查配置脚本中配置的参数是否存在错误
###如,配置的目录,文件是否存在
###返回0表示参数配置正确,非0数字表示参数存在错误
check_param(){
	if [ -n "${SOURCE_DIRS}" ];then
		echo "${SOURCE_DIRS}"|while read line
		do
			if [ ! -d "${line}" ];then
				#echo "配置中的目录${line}不存在"
				writeLog "配置中的目录${line}不存在"
				echo "1"
				return
			fi
		done
	fi

	if [ -n "${SOURCE_FILES}" ];then
		echo "${SOURCE_FILES}"|while read line
		do
			if [ ! -d "${line}" ];then
				writeLog "配置中的文件${line}不存在"
				echo "2"
				return
			fi
		done
	fi

	#检查TIMES是否是数字
	s=$(expr ${TIMES} + 0 2>&1 >/dev/null)
	if [ "$?" -ne "0" ];then
		writeLog "TIMES 参数不是数字"
		echo "3"
		return
	fi

	if [ ! -d "${BACKUP_DIR}" ];then
		writeLog "${BACKUP_DIR}目录不存在"
		echo "4"
		return
	fi

echo "0"
}

##############################

######脚本开始###############

#检查入参
if [ $# -ne 1 ];then
	echo "需要指定一个配置脚本作为入参"
	writeLog "需要指定一个配置脚本作为入参"
	exit
fi

conf_file=${1}

if [ ! -f ${conf_file} ];then
	echo "配置脚本不存在"
	writeLog "配置脚本不存在"
	exit
else
	if [ ! -x ${conf_file} ];then
		echo "配置脚本没有可执行权限"
		writeLog "配置脚本没有可执行权限"
		exit
	else
		source ${conf_file} ##bug 1 ,加载失败时脚本不能够停止
		echo "$?"
		if [ $? -ne "0" ];then
			echo "加载脚本失败 "
			writeLog "加载脚本失败 "
			exit
		fi
	fi
fi


#配置参数检查
s=$(check_param)
echo "s:${s}"
