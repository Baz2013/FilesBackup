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

###������ýű������õĲ����Ƿ���ڴ���
###��,���õ�Ŀ¼,�ļ��Ƿ����
###����0��ʾ����������ȷ,��0���ֱ�ʾ�������ڴ���
check_param(){
	if [ -n "${SOURCE_DIRS}" ];then
		echo "${SOURCE_DIRS}"|while read line
		do
			if [ ! -d "${line}" ];then
				#echo "�����е�Ŀ¼${line}������"
				writeLog "�����е�Ŀ¼${line}������"
				echo "1"
				return
			fi
		done
	fi

	if [ -n "${SOURCE_FILES}" ];then
		echo "${SOURCE_FILES}"|while read line
		do
			if [ ! -d "${line}" ];then
				writeLog "�����е��ļ�${line}������"
				echo "2"
				return
			fi
		done
	fi

	#���TIMES�Ƿ�������
	s=$(expr ${TIMES} + 0 2>&1 >/dev/null)
	if [ "$?" -ne "0" ];then
		writeLog "TIMES ������������"
		echo "3"
		return
	fi

	if [ ! -d "${BACKUP_DIR}" ];then
		writeLog "${BACKUP_DIR}Ŀ¼������"
		echo "4"
		return
	fi

echo "0"
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
		source ${conf_file} ##bug 1 ,����ʧ��ʱ�ű����ܹ�ֹͣ
		echo "$?"
		if [ $? -ne "0" ];then
			echo "���ؽű�ʧ�� "
			writeLog "���ؽű�ʧ�� "
			exit
		fi
	fi
fi


#���ò������
s=$(check_param)
echo "s:${s}"
