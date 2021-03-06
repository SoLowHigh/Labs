# ВЫВОДИТСЯ ПРИ ПАРАМЕТРЕ "HELP"
if [[ $1 = HELP ]] 
then
	echo "Данным скриптом вы можете:"
	echo ""
	echo "[1] Заместить файлы из каталога A в B"
	echo "[2] Добавить в B недостающие файлы из A"
	echo "[3] Удалить файлы из B, которых нет в A"
	echo "[4] Заменить старые файлы из B на новые из A"
	echo ""
	echo "Для этого запустите файл с нужным вам пунктом в качестве параметра"
exit
fi

# ВОЗНИКАЕТ ЛЁГКИЙ АФИГ, ЕСЛИ НЕ ВВОДИТСЯ ПАРАМЕТР ДЛЯ РАБОТЫ
if [[ -z $1 ]]
then
	echo "А что делать-то?"
	echo "Введите HELP параметром,"
	echo "если непонятно"
exit
fi

# ВЫВОДИТСЯ ПРИ ЛЮБОМ ПАРАМЕТРЕ, КРОМЕ "HELP"
echo "Введите резервную директорию B"
echo "(или не вводите, возьму \".\"):"
read dir

# ПРИСВАЕВАЕТСЯ ДИРЕКТОРИЯ ".", ЕСЛИ НЕ ВВОДИТСЯ НИКАКАЯ
if [[ -z $dir ]]
then
	dir="."
fi

# ЗАМЕЩЕНИЕ НЕДОСТАЮЩИХ ФАЙЛОВ
if [[ $1 = 1 ]]
then
	for f in *
	do	# если файл НЕ скрипт и НЕ резервная директория
		if ! [[ $f = HELPasParam2help.sh || $f = $dir ]]
		then
			cp -r "$f" "$dir/"
		fi
	done
exit
fi

# ДОБАВЛЕНИЕ НЕДОСТАЮЩИХ ФАЙЛОВ
if [[ $1 = 2 ]]
then 
	for f in *
	do	# если НЕТ файла в резервной дир. + два предыдущих условия
		if ! [[ -e $dir/$f || $f = HELPasParam2help.sh || $f = $dir ]]
		then
			cp -r "$f" "$dir/"
		fi
	done
exit
fi

# УДАЛЕНИЕ ЛИШНИХ ФАЙЛОВ
if [[ $1 = 3 ]]
then
	sdir=$(realpath .)
	cd $dir
	for f in *
	do	
		# если ЕСТЬ файл в рез. директории..
		if [[ -e $f ]]
		then
			# ..но его НЕТ в исходной
			if ! [[ -e $sdir/$f ]]
			then
				rm -r "$f"
			fi
		fi
	done
exit
fi

# ЗАМЕЩЕНИЕ СТАРЫХ ФАЙЛОВ НОВЫМИ
if [[ $1 = 4 ]]
then 
	for f in *
	do
		# если файл ЕСТЬ в рез. дир.
		if [[ -e $dir/$f ]]
		then
			# копируется НОВЫЙ файл поверх СТАРОГО
			cp -u "$f" "$dir/$f"
		fi
	done
exit
fi
