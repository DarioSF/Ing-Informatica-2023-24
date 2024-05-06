#!/bin/bash

#Análisis y diseño de algoritmos (II-I2ADE - DLSI-UA) 2023-24
#Validación del archivo de la práctica 7 que se pretende entregar
#       USAGE: $0 tar-gz-file [-h] [--debug] [--quiet] [-d dir_home]

# BITS DEL CODIGO DE RETORNO: _ _ _
#                             | | |
#                             | | -> No se admite la entrega ( o fichero inexistente)
#                             | -> No gestiona bien los errores en los argumentos
#                             -> No hace mcp_greedy() (en esta práctica, esto no se permite -entrega no válida-)
export PATH=.:$PATH

#ATENCIÓN USUARIOS DE MAC:
#puede que no tengas la orden 'timeout' en el sistema (lo puedes saber escribiendo 'timeout' en la terminal);
#en tal caso, deja la siguiente variable vacía, es decir: timeout_0=""
#pero ten en cuenta que ya NO se detectará si tu código se cuelga o si produce una violación de segmento
#tendrás que asegurarte tú mism@ de que eso no ocurre (al igual que con la compilación en MAC)

timeout_0="timeout 0.5"
#timeout_0=""  #para el caso de no disponer de la orden 'timeout'


# variables to be assigned in each job
source="mcp_greedy.cc"
exe="mcp_greedy"
err_file="errors_pr7.log"
warn_file="warnigs_pr7.log"
must_be_files="${source} [mM]akefile"
allowed_files="${source} makefile Makefile ${err_file} ${warn_file}"
should_be_func=(mcp_greedy) 

#Control variables
RETURN_CODE=0
allowed_ext=".tar.gz .tgz"
warnings=0
name="<unknown>"
captured=""
msg_timeout=""
check_num=0

filename=""     #file (tgz) to validate
dir_home=$(pwd) #directory where is TEST subdirectory. Assumed current directory
dir_tgz=""      #directory where tgz is
quiet=0
debug=0

#argument management
args=( "$@" )
for ((i=0; i<${#args[@]}; i++)); do
    is_filename=1
    [[ ${args[$i]} == "--debug" ]] && { debug=1; is_filename=0; }
    [[ ${args[$i]} == "--quiet" ]] && { quiet=1; is_filename=0; }
    [[ ${args[$i]} == "-d" ]] && { i=$((i+1)); dir_home=${args[$i]}; is_filename=0; }
    [[ ${args[$i]} == "-h" ]] && { echo "help: $0 tar-gz-file [-h] [--debug] [--quiet] [-d dir_home]";  exit 255; }
    [[ is_filename -eq 1 ]] && filename="${args[$i]}"
done

[[ $quiet -eq 0 ]] && echo "Entrega de la práctica 7"
[[ $quiet -eq 0 ]] && echo "Fichero a validar: ${filename}"

[   -z "$filename" ] && { echo $0: missing tar.gz file; exit 255; }
[ ! -f "$filename" ] && { echo $0: file \'$filename\' not found; exit 255; }



#Create tmp directory
tmp_dir=$(mktemp -d /tmp/validate_dir.XXXXXX)

# Actions at the end
by_the_end() {
    exit_code=$?
    [[ -f ${err_file} ]] && exit_code=1
    [[ -f ${warn_file} ]] && warnings=1
    [[ $exit_code -ne 0 ]] && RETURN_CODE=$((RETURN_CODE |= 1))
    if [[ $quiet -eq 0 ]]; then
        [[ -f ${warn_file} ]] && { echo; cat ${warn_file}; }
        [[ $warnings  -ne 0 ]] && echo -e "\nATENCIÓN: Los avisos mostrados mermarán considerablemente la nota."
        [[ -f ${err_file} ]] && { echo; cat ${err_file}; }
        if [[ $exit_code -eq 0 ]]; then
            echo -e "\nDNI/NIE asociado al archivo comprimido: "$dni
            echo -e "Nombre capturado en la primera línea de ${source}: "$name
            echo -e "Asegúrate de que la captura de DNI/NIE y nombre es correcta."
            echo -e "\nVALIDACIÓN POSITIVA: El trabajo cumple las especificaciones, pero asegúrate de que también compila en los ordenadores del aula."
        else
            echo -e "\nVALIDACIÓN NEGATIVA: Debes corregir los errores antes de entregar."
        fi
#    else
#        echo -n $RETURN_CODE
    fi
    rm -r $tmp_dir
    exit $RETURN_CODE
}


check_err_args() {
    error_message=$($1 2>&1 1>/dev/null)
    ret=$? # 124=timeout; 134=seg-fault; 139=core-dumped
    if [[ ret -eq 124 ]] || [[ ret -eq 134 ]] || [[ ret -eq 139 ]]; then
        echo "Aviso: '$2' produce violación de segmento o 'timeout'" >> ${warn_file}
        warnings=1
    fi
    if [[ -z "$error_message" ]]; then
        echo "Aviso: '$2' no emite mensaje de error (por la salida de error)"  >> ${warn_file}
        warnings=1
    fi 
    [[ warnings -eq 1 ]] &&  RETURN_CODE=$(( RETURN_CODE |= 2 ))
}

check_code() {
    gprof -p -b $1 gmon.out | grep $2
    if [ $? -ne 0 ]; then
        check_call_funct $2
    fi
    check_memory_map --save $1 $2    
}

error_msg(){
    echo -e "\n*** Validación número $3 ***" >> ${err_file}
    echo -e "  Prueba realizada: $2" >> ${err_file}
    echo -e "  $1" >> ${err_file}
    RETURN_CODE=$(( RETURN_CODE |= 1 ))
}

launch() {
    [[ -f tmp_file ]] && rm tmp_file
    captured=$($1 2>tmp_file); ret=$?
    case $ret in
	    124) msg_timeout="tarda demasiado ('timeout').";;
	    134) msg_timeout="produce violación de segmento.";;
	    139) msg_timeout="produce un 'core'.";;
	    *)   [[ -s tmp_file ]] && { msg_timeout="no debe mostrar nada por la salida de error puesto que es correcta."; ret=1; } || ret=0
    esac
    [[ $ret -ne 0 ]] && error_msg "Error: la orden ${msg_timeout}" "$2" $3
    return $ret
}

function validate_n_nums() {
# códigos de error: 
#   1:más elementos que loes especificados $2; 
#   2:alguno de los elementos no son números
captured_array=()
read -a captured_array < <(echo $1)
[[ ${#captured_array[@]} -ne $2 ]] && return 1
for ((i=0; i<${#captured_array[@]}; i++)); do
    [[ ! ${captured_array[i]} =~ ^[0-9]+([.][0-9]+)?$ ]] && return 2
done
return 0
}


#capture signals
trap by_the_end EXIT SIGINT SIGTERM


# Work in tmp dir; capture tgz name and directory it where is
cp "$filename" $tmp_dir
cd "$(dirname "${filename}")"
dir_tgz=$(pwd)
filename="$(basename "${filename}")" #filename=${filename##*/}
cd $tmp_dir



# dni/nie & extension of the file to be delivered
check_num=1
dni=$(echo "$filename" | cut -d "." -f 1)
ext=.$(echo "$filename" | cut -d "." -f 2-3) # | tr -d '\n' | tail -c 2)
if [[ ! " $allowed_ext " =~ " $ext " ]];then
    echo "Error: Las extensiones permitidas son: {"$allowed_ext"}."  >> ${err_file}
    echo -e "\t(extensión capturada: $ext )" >> ${err_file}
    RETURN_CODE=$((RETURN_CODE |= 1))
    exit 1
fi

# unpack tgz
check_num=2
tar -xzvf "$filename" > /dev/null
if [ $? -ne 0 ]; then
    echo "Error: 'tar' falló al desempaquetar ${filename}." >> ${err_file}
    RETURN_CODE=$((RETURN_CODE |= 1))
    exit 1
fi

rm "$filename"
[[ -f ${err_file}  ]] && rm ${err_file}
[[ -f ${warn_file} ]] && rm ${warn_file}


# Verify that only what is requested is delivered
check_num=3
missing=""
for f in ${must_be_files}; do
    if [ ! -f $f ]; then
        missing=${missing}" "${f}
    fi 
done
if [[ ! -z ${missing} ]]; then
    echo "Error: Falta/n archivo/s en la entrega (${missing} )." >> ${err_file}
    RETURN_CODE=$((RETURN_CODE |= 1))
fi


# verify that only what is necessary is delivered
check_num=4
unwanted=""
for f in *; do
    if [[ ! " $allowed_files " =~ " $f " ]];then 
        unwanted=${unwanted}" "${f}
    fi
done
if [[ ! -z ${unwanted} ]]; then
    echo "Error: Se entregan más archivos de los permitidos (${unwanted} )." >> ${err_file}
    RETURN_CODE=$((RETURN_CODE |= 1))
fi


#name="$(echo -e "${name}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')" # All-TRIM
#tr -d "[:space:]" #elimina tb saltos de linea, a diferencia de tr -d "" que elimina solo espacios
# Verify the student's name in the first line of the source (only first line is checked)
check_num=5
[[ ! -f ${source} ]] && { RETURN_CODE=$((RETURN_CODE |= 1)); exit 1; }
name=$(cat ${source} | head -n 1 | tr '*' '/' | xargs)
[[ "$name" =~ ^"//" ]] && name=$(echo ${name} | tr -d '/' | xargs) || name="<unknown>"
[[ -z ${name} ]] && name="<unknown>"
if [[ "$name" == "<unknown>" ]]; then
    echo "Error: No se captura tu nombre en la primera línea del archivo ${source}." >> ${err_file}
    RETURN_CODE=$((RETURN_CODE |= 1))
fi

#compilation
check_num=6
make > /dev/null
if [ $? -ne 0 ]; then
    echo "Error: 'make' ha devuelto error." >> ${err_file}
    RETURN_CODE=$((RETURN_CODE |= 1))
    exit 1
fi


# Verify that the executable file exists
check_num=7
if [ ! -x "$exe" ]; then
    echo "Error: El archivo ${exe} no existe o no es ejecutable." >> ${err_file}
    RETURN_CODE=$((RETURN_CODE |= 1))
    exit 1
fi


# Check that the requested functions are defined
check_num=8
for ((i=0; i<${#should_be_func[@]}; i++)); do
    grep -q ${should_be_func[$i]} $source
    if [ $? -ne 0 ]; then    
        RETURN_CODE=$((RETURN_CODE |= $(echo 2^$((i+2))|bc)))
        if [[ $(( RETURN_CODE & 4 )) -eq 4 ]]; then
            echo "Error: mcp_greedy es obligatoria." >> ${err_file}
            RETURN_CODE=$((RETURN_CODE |= 1))
        else
            warnings=1
            echo "Aviso: ${should_be_func[$i]} no encontrada; se asume que no se ha implementado."  >> ${warn_file}
        fi
    fi
done 

# creating test-maps
test_1=test1.map  #en realidad es 02.map
cat << 'EOF' > $test_1
6 5
1 3 5 1 1
2 4 6 3 1
1 2 9 8 1
9 1 7 1 9
1 3 7 5 1
8 1 2 2 1
EOF

cat << 'EOF' > ${test_1}.sol_greedy
x....
x....
x....
.x...
.x...
.xxxx
14
EOF

test_3=test3.map #en realidad es 03.map
cat << 'EOF' > $test_3
2 1
1
2
EOF

cat << 'EOF' > ${test_3}.sol_greedy
x
x
3
EOF

test_4=test4.map #en realidad es 04.map
cat << 'EOF' > $test_4
1 2
1 2
EOF

cat << 'EOF' > ${test_4}.sol_greedy
xx
3
EOF

test_5=test5.map #en realidad es 04.map
cat << 'EOF' > $test_5
3 3
7 2 0
4 4 4
4 2 1
EOF

cat << 'EOF' > ${test_5}.sol_greedy
xxx
..x
..x
14
EOF


test_6=map_1000x10_1s
echo 1000 10 > $test_6
l="1 1 1 1 1 1 1 1 1 1"
for ((i=0; i<1000; i++)); do
    echo $l >> $test_6
done
    

#### Command line checks:

# Ante cualquier aviso, se considerará que la gestión de argumentos no es robusta
check_num=11
command="$timeout_0 ${exe} -f"
command2show="${exe} -f"
check_err_args "$command" "$command2show"

check_num=12
command="$timeout_0 ${exe} -f $test_1 -f"
command2show="${exe} -f 02.map -f"
check_err_args "$command" "$command2show"

check_num=13
command="$timeout_0 ${exe}"
command2show="${exe}"
check_err_args "$command" "$command2show"

check_num=14
command="$timeout_0 ${exe} -f -// "
command2show="${exe}  -f -//"
check_err_args "$command" "$command2show"

check_num=15
command="$timeout_0 ${exe}  -f $test_1 -t"
command2show="${exe} -f 02.map -t"
check_err_args "$command" "$command2show"

check_num=16
command="$timeout_0 ${exe} -f $test_1 -f inexistentefile -t"
command2show="${exe} -f 02.map -f inexistentefile -t"
check_err_args "$command" "$command2show"


#### checks on solutions:
param_path="--p2D"
# Es importante tener en cuenta que la correcta comprobación de una prueba puede depender de que se haya superado alguna de las comprobaciones previas

#primera línea solo debe contener dos números.
check_num=17
command="$timeout_0 ${exe} -f $test_1"
command2show="${exe} -f 02.map"
launch "$command" "$command2show" $check_num
_captured=$(echo "$captured" | head -n 1)
[[ -z "$captured" ]] && captured="<la captura está vacía>"
validate_n_nums "$_captured" 2
[[ $? -ne 0 ]] && error_msg "salida capturada:\n$captured\n En la primera línea se esperan dos valores numéricos (y nada más)." "$command2show" "$check_num (ERROR en el formato de la salida)"


#segunda línea debe estar vacía
check_num=18
command="$timeout_0 ${exe} -f $test_1"
command2show="${exe} -f 02.map"
launch "$command" "$command2show" $check_num
_captured=$(echo "$captured" | tail -n +2)
[[ -z "$captured" ]] && captured="<la captura está vacía>"
[[ ! -z "$_captured" ]] && error_msg "salida capturada:\n$captured\n En este caso, la salida debe estar compuesta de una única línea." "$command2show" "$check_num (ERROR en el formato de la salida)"


#Con --p2D, en la última línea debe haber un (único) valor numérico
check_num=19
command="$timeout_0 ${exe} -f $test_1 ${param_path}"
command2show="${exe} -f 02.map --p2D"
launch "$command" "$command2show" $check_num
_captured=$(echo "$captured" | tail -n 1)
[[ -z "$captured" ]] && captured="<la captura está vacía>"
validate_n_nums "$_captured" 1  
[[ $? -ne 0 ]] && error_msg "salida capturada:\n$captured\n En la última línea se espera un valor numérico (y nada más)." "$command2show" "$check_num (ERROR en el formato de la salida)"


#Los resultados de la primera línea han de ser correctos
check_num=20
command="$timeout_0 ${exe} -f $test_1"
command2show="${exe} -f 02.map"
launch "$command" "$command2show" $check_num
_captured=$(echo "$captured" | head -n 1)
[[ -z "$captured" ]] && captured="<la captura está vacía>"
validate_n_nums "$_captured" 2
results_array=( 14 15 )
if [[ ! "${captured_array[@]}" == "${results_array[@]}" ]]; then
    error_msg "salida capturada:\n$captured\n Los resultados mostrados no son los esperados." "$command2show" "$check_num (ERROR en el resultado)"
fi


check_num=21
command="$timeout_0 ${exe} ${param_path} -f $test_3"
command2show="${exe} -f 03.map --p2D"
launch "$command" "$command2show" $check_num
_captured=$(echo "$captured"  | tail -n +2 | head -n 3 )
[[ -z "$captured" ]] && captured="<la captura está vacía>"
[[ $_captured != "$(cat ${test_3}.sol_greedy)" ]] && error_msg "salida capturada:\n$captured \n El camino (o su formato) no es correcto" "$command2show" "$check_num (ERROR)"


check_num=22
command="$timeout_0 ${exe} ${param_path} -f $test_4"
command2show="${exe} -f 04.map --p2D"
launch "$command" "$command2show" $check_num
_captured=$(echo "$captured"  | tail -n +2 | head -n 2 )
[[ -z "$captured" ]] && captured="<la captura está vacía>"
[[ $_captured != "$(cat ${test_4}.sol_greedy)" ]] && error_msg "salida capturada:\n$captured \n El camino (o su formato) no es correcto" "$command2show" "$check_num (ERROR)"


check_num=23
command="$timeout_0 ${exe} -f $test_5 ${param_path}"
command2show="${exe} -f $test_5 ${param_path}"
launch "$command" "$command2show" $check_num
_captured=$(echo "$captured"  | tail -n +2 | head -n 4 )
[[ -z "$captured" ]] && captured="<la captura está vacía>"
msg="Con el siguiente mapa, el camino mostrado no es el esperado:\n$(cat ${test_5})"
[[ $_captured != "$(cat ${test_5}.sol_greedy)" ]] && error_msg "salida capturada:\n$captured \n$msg" "$command2show" "$check_num (ERROR)"


check_num=24
command="$timeout_0 ${exe} -f $test_6"
command2show="${exe} -f $test_6"
launch "$command" "$command2show" $check_num
_captured=$(echo "$captured" | head -n 1)
[[ -z "$captured" ]] && captured="<la captura está vacía>"
validate_n_nums "$_captured" 2
results_array=( 1000 1000 )
if [[ ! "${captured_array[@]}" == "${results_array[@]}" ]]; then
    msg="Con un mapa 1000x10 compuesto solo de unos, el resultado debe ser 1000 en ambos sentidos"
    error_msg "salida capturada:\n$captured\n$msg." "$command2show" "$check_num (ERROR en el resultado)"
fi
( [[ -f ${err_file} ]] || [[ $((RETURN_CODE&1)) -eq 1 ]] ) && exit 1;


exit 0

