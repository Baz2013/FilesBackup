#!/bin/bash - 
#===============================================================================
#
#          FILE: backup_file.sh
# 
#         USAGE: ./backup_file.sh 
# 
#   DESCRIPTION: ������ص������ļ����������ļ���Ŀ¼���޸Ļ��߱�ɾ��
#				 ʱ���ش����ű�ȥִ�б��ݲ���
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

#####�������岿��##############
writeLog(){
	cur_time=$(date +"%Y-%m-%d %H:%M:%S")
	cur_date=$(date +"%Y%m%d")
	log_name=${cur_date}"".log
	echo "${cur_time}|$1" >> ./backup_file.${log_name}
}



##############################

######�ű���ʼ###############

#������
if [ $# -ne 1 ];then
	echo "��Ҫָ��һ�����ýű���Ϊ���"
	writeLog "��Ҫָ��һ�����ýű���Ϊ���"
	exit
fi

conf_file=${1}

if [ ! -f ${conf_file} ];then
	echo "���ýű�������"
	writeLog "���ýű�������"
	exit
else
	if [ ! -x ${conf_file} ];then
		echo "���ýű�û�п�ִ��Ȩ��"
		writeLog "���ýű�û�п�ִ��Ȩ��"
		exit
	else
		source ${conf_file}
		echo "$?"
		if [ $? -ne "0" ];then
			echo "���ؽű�ʧ�� "
			writeLog "���ؽű�ʧ�� "
			exit
		fi
	fi
fi



