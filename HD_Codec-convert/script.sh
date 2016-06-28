#!/bin/bash
#
# объявление переменных
THIS_SCRIPT_PATH=/Users/MrDee/Downloads/HD_Codec-convert
echo "Расположение файла скрипта - $THIS_SCRIPT_PATH";
# Проверка на наличие 2-convert_hex_to_dec.rb
if ! [ -f $THIS_SCRIPT_PATH/2-convert_hex_to_dec.rb ] ; then
echo "Дополнительный скрипт 2-convert_hex_to_dec.rb не найден";
exit
else echo "2-convert_hex_to_dec.rb найден"
fi
		if ! [ -d $THIS_SCRIPT_PATH/1-codecgraph ] ; then 
		echo "Каталог 1-codecgraph не обнаружен";
		exit
		else echo "Каталог 1-codecgraph найден"
		fi
			read -p "Перетащите в окно терминала свой дамп с линукса и нажмите ENTER: " n
			if [ $n ]; then
				
			CODEC_FILE_NAME=$(basename ${n});
			FOLDER_PATH=$(dirname ${n});
			
			
			echo "Путь к файлу кодека - ${n}";
			echo "Имя файла кодека - $CODEC_FILE_NAME";
			
			mkdir /Users/MrDee/Desktop/"$CODEC_FILE_NAME"_converts/;
			
			touch /Users/MrDee/Desktop/"$CODEC_FILE_NAME"_converts/pin-complex.txt;
			
			cd /Users/MrDee/Desktop/"$CODEC_FILE_NAME"_converts/;
									
			cp ${n} /Users/MrDee/Desktop/"$CODEC_FILE_NAME"_converts/;
			
			$THIS_SCRIPT_PATH/1-codecgraph/codecgraph ${n};
			$THIS_SCRIPT_PATH/2-convert_hex_to_dec.rb ${n} > "$CODEC_FILE_NAME"_dec.txt
			$THIS_SCRIPT_PATH/2-convert_hex_to_dec.rb "$CODEC_FILE_NAME".svg > "$CODEC_FILE_NAME"_dec.svg
			
			ADDRESS=$(sed -n '/Address:/{p;}' ${n});
			CODEC=$(sed -n '/Codec:/{p;}' ${n});
			VENDOR=$(sed -n '/Vendor Id:/{p;}' ${n});
			VNDR_DEC=$(sed -n '/Vendor Id:/{p;}' ${CODEC_FILE_NAME}_dec.txt);
			PIN_COMPLEX=$(sed -n '/Pin Complex/{p;}' ${n});
			
			echo "$ADDRESS" > /Users/MrDee/Desktop/"$CODEC_FILE_NAME"_converts/pin-complex.txt;
			echo "$CODEC" >> /Users/MrDee/Desktop/"$CODEC_FILE_NAME"_converts/pin-complex.txt;
			echo "$VENDOR" >> /Users/MrDee/Desktop/"$CODEC_FILE_NAME"_converts/pin-complex.txt;
			echo "Dec $VNDR_DEC" >> /Users/MrDee/Desktop/"$CODEC_FILE_NAME"_converts/pin-complex.txt;
			echo "$PIN_COMPLEX" >> /Users/MrDee/Desktop/"$CODEC_FILE_NAME"_converts/pin-complex.txt;
			
			echo "Данные распологаются на рабочем столе, в каталоге: "$CODEC_FILE_NAME"_converts";
			
			echo "$ADDRESS"
			echo "$VENDOR"
			echo "Dec $VNDR_DEC"
			echo "$PIN_COMPLEX"
			exit
		fi