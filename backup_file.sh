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
		source ${conf_file}
		echo "$?"
		if [ $? -ne "0" ];then
			echo "加载脚本失败 "
			writeLog "加载脚本失败 "
			exit
		fi
	fi
fi



