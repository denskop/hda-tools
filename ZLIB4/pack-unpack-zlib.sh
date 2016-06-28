#!/bin/bash
#
giveMeFile ()
{
	echo "Переместите *.xml.zlib или *.Zml.zlib или *.plist и нажмите Enter"
	read -p "Или нажмите Ctrl + C чтобы выйти : " my_xml
	XML_FILE_NAME=$(basename $my_xml);
	FILE_XML_ZLIB_PATH=$(dirname $my_xml);
	zlib;
}

zlib ()
{
	if [[ "$XML_FILE_NAME" = *.zlib ]]; then 
		#echo "it is zlib" 
	echo "Распаковываю *.zlib -> *.plist";
	FILE_XML_ZLIB=`echo $XML_FILE_NAME|sed 's/ml.zlib//g'`;
	#echo "$FILE_XML_ZLIB"		
		perl "$THIS_SCRIPT_PATH"/zlib.pl inflate $my_xml > "${FILE_XML_ZLIB_PATH}/${FILE_XML_ZLIB}ml.plist";
		giveMeFile;
	exit

	else #echo "it is plist or xml" 
	 echo "Упаковываю в *.Zml.zlib"
	fi
	#echo "$XML_FILE_NAME"
	FILE_PLIST=`echo $XML_FILE_NAME|sed 's/.plist//;s/.xml//;s/.Zml//;s/.zml//;s/.aml//g'` ;
	#	echo "$FILE_PLIST"
		perl "$THIS_SCRIPT_PATH"/zlib.pl deflate $my_xml > "${FILE_XML_ZLIB_PATH}/${FILE_PLIST}.Zml.zlib"
		giveMeFile;
	exit	
}

THIS_SCRIPT_PATH=$(dirname $0);
echo "$THIS_SCRIPT_PATH"
giveMeFile;









