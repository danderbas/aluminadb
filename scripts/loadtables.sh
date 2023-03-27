CSVFOLDER="$HOME/projects/mr_/alumar_/srv/shared/registro/csv"

loadcsv_perfiles() {
	sed '1d' $CSVFOLDER/perfiles.csv |sed 's/"NULL"/NULL/g'|sed 's/.*/(&)/'|sed 's/.*/INSERT INTO perfiles VALUES &/'|sed 's/$/;/'
}

updatecsv_perfiles() {
	sed '1d' perfiles.csv |sed 's/"NULL"/NULL/g'|awk -F, '{print "update perfiles set descripcion=" $2 ", id_tipo=" $3 ", pesolinealnominal__kg_m=" $4 ", perimetro__mm=" $5 ", area__mm2=" $6 ", codigo_externo=" $7 " where codigo like "$1 ";"}'
}

loadcsv_matrices() {
	sed '1d' $CSVFOLDER/matrices.matrices.csv |sed 's/"NULL"/NULL/g'|sed 's/.*/(&)/'|sed 's/.*/INSERT INTO matrices VALUES &/'|sed 's/$/;/'
}
# currdir=$(pwd); cd ~/projects/alumar_/sistema/odsandcsvs; /Applications/LibreOffice.app/Contents/MacOS/soffice --convert-to csv:"Text - txt - csv (StarCalc)":44,39,0,1,,1031,true,true,true  ~/projects/alumar_/shared.bak/registro/matrices.ods;cd $currdir;

loadcsv_stock_matrices() {
	sed '1d' $CSVFOLDER/matrices.stock_matrices.csv |sed 's/"NULL"/NULL/g'|sed 's/.*/(&)/'|sed 's/.*/INSERT INTO stock_matrices VALUES &/'|sed 's/$/;/'
}

loadcsv_generacion_op_extrusion() {
	cat $CSVFOLDER/op_extrusion.generacion.csv | sed '1d' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO generacion_op_extrusion VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'|sed 's/"NULL"/NULL/g'
}



loadcsv_op_extrusion() {
	cat $CSVFOLDER/op_extrusion.op_extrusion.csv | sed '1d' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO op_extrusion VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'|sed 's/"NULL"/NULL/g'
}

loadcsv_op_extrusion_entrada() {
	cat $CSVFOLDER/op_extrusion.entrada.csv | sed '1d' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO op_extrusion_entrada VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'|sed 's/"NULL"/NULL/g'
}

loadcsv_op_extrusion_matriz() {
	cat $CSVFOLDER/op_extrusion.matriz.csv | sed '1d' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO s_op_extrusion_matriz VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'|sed 's/"NULL"/NULL/g'|sed 's/)/,NULL)/'
}

loadcsv_op_extrusion_matriz_old() {
	cat $CSVFOLDER/op_extrusion.matriz.csv | sed '1d' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO op_extrusion_matriz VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'|sed 's/"NULL"/NULL/g'
}

loadcsv_op_extrusion_objetivo() {
	cat $CSVFOLDER/op_extrusion.objetivo.csv | sed '1d' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO op_extrusion_objetivo VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'|sed 's/\"NULL\"/NULL/g'
}

loadcsv_op_extrusion_parapedido() {
	cat $CSVFOLDER/op_extrusion.parapedido.csv | sed '1d' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO op_extrusion_parapedido VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'|sed 's/"NULL"/NULL/g'
}

loadcsv_op_extrusion_planeamiento() {
	cat $CSVFOLDER/op_extrusion.planeamiento.csv | sed '1d' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO op_extrusion_planeamiento VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'|sed 's/"NULL"/NULL/g'
}

loadallcsv_op_extrusion() {
	loadcsv_generacion_op_extrusion
	loadcsv_op_extrusion
	loadcsv_op_extrusion_entrada
	loadcsv_op_extrusion_matriz
	loadcsv_op_extrusion_objetivo
	loadcsv_op_extrusion_parapedido
	loadcsv_op_extrusion_planeamiento
}
	
loadtailcsv_op_extrusion() {
	if [[ $1 != "" ]]; then
		tailflag="-n $1"
	else
		tailflag=""
	fi
	loadcsv_generacion_op_extrusion|tail $tailflag
	loadcsv_op_extrusion|tail $tailflag
	loadcsv_op_extrusion_entrada|tail $tailflag
	loadcsv_op_extrusion_matriz|tail $tailflag
	loadcsv_op_extrusion_objetivo|tail $tailflag
	loadcsv_op_extrusion_parapedido|tail $tailflag
	loadcsv_op_extrusion_planeamiento|tail $tailflag
}


# extrusion
loadcsv_extrusion() {
	sed '1d' $CSVFOLDER/extrusion.extrusion.csv |sed 's/"NULL"/NULL/g'|sed 's/.*/(&)/'|sed 's/.*/INSERT INTO extrusion VALUES &/'|sed 's/$/;/'
}
# extrusion_stats
loadcsv_extrusion_stats() {
	sed '1d' $CSVFOLDER/extrusion.stats.csv |sed 's/"NULL"/NULL/g'|sed 's/.*/(&)/'|sed 's/.*/INSERT INTO extrusion_stats VALUES &/'|sed 's/$/;/'
}


# extrusion_corte
loadcsv_extrusion_corte() {
	sed '1d' $CSVFOLDER/extrusion.corte.csv |sed 's/"NULL"/NULL/g'|sed 's/.*/(&)/'|sed 's/.*/INSERT INTO extrusion_corte VALUES &/'|sed 's/$/;/'
}
# extrusion_entrada
loadcsv_extrusion_entrada() {
	#sed '1d' $CSVFOLDER/extrusion.tochos.csv |sed 's/"NULL"/NULL/g'|sed 's/.*/(&)/'|sed 's/.*/INSERT INTO extrusion_entrada VALUES &/'|sed 's/$/;/'
	join -t, -1 1 -2 1 <(sort ~/shared.local/registro/csv/extrusion.extrusion.csv) <(sort ~/shared.local/registro/csv/extrusion.tochos.csv)|awk -F, '{print $1 ",NULL," $10 "," $6 "," $7 "," $11 }'|sed '/NULL,NULL/d'|sed 's/.*/(&,NULL)/'|sed 's/.*/INSERT INTO s_extrusion_entrada VALUES &/'|sed 's/$/;/'
	#sed 's/.*/(&)/'|sed 's/.*/INSERT INTO extrusion_entrada VALUES &/'|sed 's/$/;/'
#join -1 1 -2 1 <(sort ~/shared.local/registro/csv/extrusion.extrusion.csv) <(sort ~/shared.local/registro/csv/extrusion.tochos.csv)
# con esto ya tengo mi entrada (parcial al menos, para cuando hay op)
#join -t, -1 1 -2 1 <(sort ~/shared.local/registro/csv/extrusion.extrusion.csv) <(sort ~/shared.local/registro/csv/extrusion.tochos.csv)|awk -F, '{print $1 ",NULL," $10 "," $6 "," $7 "," $11 }'
#primero tendria que eliminar las columnas que no tienen OP
#asi:
#join -t, -1 1 -2 1 <(sort ~/shared.local/registro/csv/extrusion.extrusion.csv) <(sort ~/shared.local/registro/csv/extrusion.tochos.csv)|awk -F, '{print $1 ",NULL," $10 "," $6 "," $7 "," $11 }'|sed '/NULL,NULL/d'

}
# extrusion_matriz
loadcsv_extrusion_matriz() {
	sed '1d' $CSVFOLDER/extrusion.matriz.csv |cut -d, -f1-3|sed 's/"NULL"/NULL/g'|sed 's/.*/(&)/'|sed 's/.*/INSERT INTO s_extrusion_matriz VALUES &/'|sed 's/$/;/'|sed 's/)/,NULL)/'
}
# extrusion_matriz
loadcsv_extrusion_matriz_old() {
	sed '1d' $CSVFOLDER/extrusion.matriz.csv |cut -d, -f1-3|sed 's/"NULL"/NULL/g'|sed 's/.*/(&)/'|sed 's/.*/INSERT INTO extrusion_matriz VALUES &/'|sed 's/$/;/'
}
# extrusion_muestraculote
loadcsv_extrusion_muestraculote() {
	sed '1d' $CSVFOLDER/extrusion.muestra_culote.csv |sed 's/"NULL"/NULL/g'|sed 's/.*/(&)/'|sed 's/.*/INSERT INTO extrusion_muestraculote VALUES &/'|sed 's/$/;/'
}
# extrusion_muestraperfil
loadcsv_extrusion_muestraperfil() {
	sed '1d' $CSVFOLDER/extrusion.muestra_perfil.csv |cut -d, -f1-4|sed 's/"NULL"/NULL/g'|sed 's/.*/(&)/'|sed 's/.*/INSERT INTO extrusion_muestraperfil VALUES &/'|sed 's/$/;/'
}
# extrusion_salida
loadcsv_extrusion_salida() {
	#sed '1d' $CSVFOLDER/extrusion.produccion.csv |cut -d, -f1-3|sed 's/"NULL"/NULL/g'|sed 's/.*/(&,-1)/'|sed 's/.*/INSERT INTO extrusion_salida VALUES &/'|sed 's/$/;/'
	sed '1d' $CSVFOLDER/extrusion.produccion.csv |cut -d, -f1-5|sed 's/"NULL"/NULL/g'|sed 's/.*/(&)/'|sed 's/.*/INSERT INTO extrusion_salida VALUES &/'|sed 's/$/;/'
}

loadallcsv_extrusion() {
	loadcsv_extrusion
	loadcsv_extrusion_corte
	loadcsv_extrusion_entrada
	loadcsv_extrusion_matriz
	loadcsv_extrusion_muestraculote
	loadcsv_extrusion_muestraperfil
	loadcsv_extrusion_salida
}

loadtailcsv_extrusion_tail() {
	if [[ $1 != "" ]]; then
		tailflag="-n $1"
	else
		tailflag=""
	fi

	loadcsv_extrusion|tail $tailflag
	loadcsv_extrusion_corte|tail $tailflag
	loadcsv_extrusion_entrada|tail $tailflag
	loadcsv_extrusion_matriz|tail $tailflag
	loadcsv_extrusion_muestraculote|tail $tailflag
	loadcsv_extrusion_muestraperfil|tail $tailflag
	loadcsv_extrusion_salida|tail $tailflag
}


loadcsv_matrices_nitruracion() {
	sed '1d' $CSVFOLDER/matrices.nitruracion.csv |sed 's/"NULL"/NULL/g'|sed 's/.*/(&)/'|sed 's/.*/INSERT INTO matrices_nitruracion VALUES &/'|sed 's/$/;/'
}

#loadcsv_nitruracion() {
#	sed '1d' $CSVFOLDER/nitruracion.nitruracion.csv |sed 's/"NULL"/NULL/g'|sed 's/.*/(&)/'|sed 's/.*/INSERT INTO nitruracion VALUES &/'|sed 's/$/;/'
#}
#loadcsv_nitruracion_detalle() {
#	sed '1d' $CSVFOLDER/nitruracion.nitruracion_detalle.csv |sed 's/"NULL"/NULL/g'|sed 's/.*/(&)/'|sed 's/.*/INSERT INTO nitruracion_detalle VALUES &/'|sed 's/$/;/'
#}
loadcsv_matrices_mediciondureza() {
	sed '1d' $CSVFOLDER/matrices.mediciondureza.csv |sed 's/"NULL"/NULL/g'|sed 's/.*/(&)/'|sed 's/.*/INSERT INTO matrices_mediciondureza VALUES &/'|sed 's/$/;/'
}
#loadcsv_matrices_mediciondureza() {
#}

	# carga
		# nitruracion
			# sed '1d' ~/projects/alumar_/sistema/odsandcsvs/nitratacion-mejorado.nitratacion.csv |sed 's/"NULL"/NULL/g'|sed 's/.*/(&)/'|sed 's/.*/INSERT INTO nitruracion VALUES &/'|sed 's/$/;/'|pbcopy
		# nitruracion_detalle
			# sed '1d' ~/projects/alumar_/sistema/odsandcsvs/nitratacion-mejorado.nitratacion_detalle.csv |sed 's/"NULL"/NULL/g'|sed 's/.*/(&)/'|sed 's/.*/INSERT INTO nitruracion_detalle VALUES &/'|sed 's/$/;/'|pbcopy
		# matrices_mediciondureza
			# sed '1d' ~/projects/alumar_/sistema/odsandcsvs/nitratacion-mejorado.medicion_dureza.csv |sed 's/"NULL"/NULL/g'|sed 's/.*/(&)/'|sed 's/.*/INSERT INTO matrices_mediciondureza (fecha,cod_matriz,nro_serie_matriz,dureza__rhc) VALUES &/'|sed 's/$/;/'|pbcopy
			# la ultiam vez tuvo errores, qeu por ahora no importan, pero despues si	

loadcsv_delta_canastos() {
	sed '1d' $CSVFOLDER/delta_canastos.csv |sed 's/"NULL"/NULL/g'|sed 's/.*/(&)/'|sed 's/.*/INSERT INTO delta_canastos VALUES &/'|sed 's/$/;/'
}

loadcsv_pedidos() {
	cat $CSVFOLDER/pedidos.pedidos.csv | sed '1d' | sed 's/"NULL"/NULL/g' | sed 's/'\''NULL'\''/NULL/g' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO pedidos VALUES &/'|sed 's/$/;/'
}

update_estados_pedidos() {
	cat $CSVFOLDER/pedidos.pedidos.csv | awk -F, '{print "UPDATE pedidos SET id_estado ="$11" WHERE nro_pedido="$1" AND nro_subpedido="$2";"}' | sed '1d' | sed 's/"NULL"/NULL/g'
}

loadcsv_generacion_pedidos() {
	cat $CSVFOLDER/pedidos.generacion.csv | sed '1d' | sed 's/"NULL"/NULL/g' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO generacion_pedidos VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'
}

loadcsv_pedidos_expedicion() {
	cat $CSVFOLDER/pedidos.entregas.csv | sed '1d' | sed 's/"NULL"/NULL/g' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO pedidos_expedicion VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'
}


loadcsv_cortetochos() {
	cat $CSVFOLDER/cortetochos.cortetochos.csv | sed '1d' | sed 's/"NULL"/NULL/g' | awk -F, '{print $1 "," $2 "," $3 "," $4 "," $5 "," $6 "," $7 "," $8 "," $9 "," $10 "," $11 "," $12 "," $13 "," $14 }'| sed 's/.*/(&)/' | sed 's/.*/INSERT INTO cortetochos VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'
}

loadcsv_cortetochos_merma() {
	#cat $CSVFOLDER/cortetochos.resto_tocho0.csv | sed '1d' | sed 's/"NULL"/NULL/g' | awk -F, '{print $1 "," $2 "," $3 "," $4 "," $5 "," $6 "," $7 "," $8 "," $9 "," $10 "," $12}'| sed 's/.*/(&)/' | sed 's/.*/INSERT INTO cortetochos_merma VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'

	cat $CSVFOLDER/cortetochos.resto_tocho0.csv | sed '1d' | sed 's/"NULL"/NULL/g' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO cortetochos_merma VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'
}


loadcsv_insumos_tocho0_cargas_aluminio() {
	cat $CSVFOLDER/insumos_tocho0.cargas_aluminio.csv | sed '1d' | sed 's/"NULL"/NULL/g' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO cargas_aluminio VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'
}

loadcsv_insumos_tocho0_cargas_aluminio_detalle() {
	cat $CSVFOLDER/insumos_tocho0.cargas_aluminio_packinglist.csv | sed '1d' | sed 's/"NULL"/NULL/g' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO cargas_aluminio_detalle VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'
}

loadcsv_insumos_tocho0_tocho0() {
cat $CSVFOLDER/insumos_tocho0.tocho0.csv | sed '1d' | sed 's/"NULL"/NULL/g' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO tocho0 VALUES &/' | sed 's/$/;/' | sed 's/'\''NULL'\''/NULL/g'
}

loadcsv_generacion_op_pintura() {
	cat $CSVFOLDER/op_pintura.generacion.csv | sed '1d' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO generacion_op_pintura VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'|sed 's/"NULL"/NULL/g'
}

loadcsv_op_pintura() {
	cat $CSVFOLDER/op_pintura.op_pintura.csv | sed '1d' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO op_pintura VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'|sed 's/"NULL"/NULL/g'
}

loadcsv_op_pintura_parapedido() {
	cat $CSVFOLDER/op_pintura.parapedido.csv | sed '1d' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO op_pintura_parapedido VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'|sed 's/"NULL"/NULL/g'
}

loadcsv_op_pintura_planeamiento() {
	cat $CSVFOLDER/op_pintura.planeamiento.csv | sed '1d' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO op_pintura_planeamiento VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'|sed 's/"NULL"/NULL/g'
}

loadcsv_matrices_correccion() {
	sed '1d' $CSVFOLDER/matrices.correcciones.csv |sed 's/"NULL"/NULL/g'|sed 's/.*/(&)/'|sed 's/.*/INSERT INTO matrices_correccion VALUES &/'|sed 's/$/;/'
}

loadcsv_envejecimiento() {
	cat $CSVFOLDER/envejecimiento.envejecimiento.csv | sed '1d' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO envejecimiento VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'|sed 's/"NULL"/NULL/g'
}

loadcsv_envejecimiento_canastos() {
	cat $CSVFOLDER/envejecimiento.canastos.csv | sed '1d' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO envejecimiento_canastos VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'|sed 's/"NULL"/NULL/g'
}

loadcsv_envejecimiento_canastos_detalle() {
	cat $CSVFOLDER/envejecimiento.contenido.csv | sed '1d' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO envejecimiento_canastos_detalle VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'|sed 's/"NULL"/NULL/g'
}

loadcsv_rrhh() {
	sed '1d' $CSVFOLDER/rrhh.csv |sed 's/"NULL"/NULL/g'|sed 's/.*/(&)/'|sed 's/.*/INSERT INTO rrhh VALUES &/'|sed 's/$/;/'
}

loadcsv_insumos_pinturas_colores_codigos() {
	cat $CSVFOLDER/insumos_pinturas.colores_codigos.csv | sed '1d' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO colores_codigos VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'|sed 's/"NULL"/NULL/g'
}

loadcsv_insumos_pinturas_cargas_pinturas() {
	cat $CSVFOLDER/insumos_pinturas.cargas_pinturas.csv | sed '1d' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO cargas_pinturas VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'|sed 's/"NULL"/NULL/g'
}

loadcsv_insumos_pinturas_cargas_pinturas_detalle() {
	cat $CSVFOLDER/insumos_pinturas.cargas_pinturas_detalle.csv | sed '1d' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO cargas_pinturas_detalle VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'|sed 's/"NULL"/NULL/g'
}

loadcsv_insumos_pinturas_pinturas() {
	cat $CSVFOLDER/insumos_pinturas.pinturas.csv | sed '1d' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO pinturas VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'|sed 's/"NULL"/NULL/g'
}

loadcsv_d_stock_pinturas() {
	cat $CSVFOLDER/insumos_pinturas.salidas.csv | sed '1d' | sed 's/.*/(DEFAULT,&)/' | sed 's/.*/INSERT INTO d_stock_pinturas VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'|sed 's/"NULL"/NULL/g'
}

loadcsv_s_op_pintura_parapedido() {
	loadcsv_op_pintura_parapedido |sed 's/op_p/s_op_p/g'|sed 's/)/,0)/g'
}

loadcsv_s_op_extrusion_parapedido() {
	loadcsv_op_extrusion_parapedido |sed 's/ op_/ s_op_/'|sed 's/)/,0)/'
}

loadcsv_d_stock_perfiles() {
	cat $CSVFOLDER/d_stock_perfiles.csv | sed '1d' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO d_stock_perfiles VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'|sed 's/"NULL"/NULL/g'
}

loadcsv_d_stock_perfiles_mov() {
	#cat $CSVFOLDER/d_stock_perfiles_mov.csv | sed '1d' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO d_stock_perfiles_mov VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'|sed 's/"NULL"/NULL/g'|sed 's/)/,0)/'|sed 's/(/(DEFAULT,/'
	cat $CSVFOLDER/d_stock_perfiles_mov.csv | sed '1d' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO d_stock_perfiles_mov VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'|sed 's/"NULL"/NULL/g'
}

loadcsv_insumos_pinturas_salidas() {
	cat $CSVFOLDER/insumos_pinturas.salidas.csv | sed '1d' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO d_stock_pinturas VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'|sed 's/"NULL"/NULL/g'|sed 's/(/(DEFAULT,/'
}

loadcsv_s_envejecimiento_canastos_detalle() {
	cat $CSVFOLDER/envejecimiento.contenido.csv | sed '1d' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO s_envejecimiento_canastos_detalle VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'|sed 's/"NULL"/NULL/g'|sed 's/)/,NULL)/'
}

loadcsv_pintura() {
	cat $CSVFOLDER/pintura.csv | sed '1d' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO s_pintura VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'|sed 's/"NULL"/NULL/g'|sed 's/)/,NULL)/'
}

loadcsv_pintura_old() {
	cat $CSVFOLDER/pintura.csv | sed '1d' | sed 's/.*/(&)/' | sed 's/.*/INSERT INTO pintura VALUES &/'|sed 's/$/;/'|sed 's/'\''NULL'\''/NULL/g'|sed 's/"NULL"/NULL/g'
}
loadcsv_extrusion_entrada_old() {
	sed '1d' $CSVFOLDER/extrusion.tochos.csv |sed 's/"NULL"/NULL/g'|sed 's/.*/(&)/'|sed 's/.*/INSERT INTO extrusion_entrada VALUES &/'|sed 's/$/;/'
}

loadcsv() {
	filename=$1
	tablename=$2

	sed '1d' $filename |sed 's/"NULL"/NULL/g'|sed "s/'NULL'/NULL/g" |sed 's/.*/(&)/'|sed 's/.*/INSERT INTO _tablename_ VALUES &/'|sed "s/_tablename_/$2/"|sed 's/$/;/'
}
