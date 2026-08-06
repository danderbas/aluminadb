db=$alumardb
lpath="aluminalocal"

bash cleannullvalues_usuarios-clientes.sh
mysql --login-path=$lpath --local-infile=1 $db -vv < loadvalues_usuarios-clientes.mysql

bash cleannullvalues_insumos_tochos.sh
mysql --login-path=$lpath --local-infile=1 $db -vv < loadvalues_insumos_tochos.mysql
bash cleannullvalues_insumos_pinturas.sh
mysql --login-path=$lpath --local-infile=1 $db -vv < loadvalues_insumos_pinturas.mysql

bash cleannullvalues_perfiles-matrices.sh
mysql --login-path=$lpath --local-infile=1 $db -vv < loadvalues_perfiles-matrices.mysql

bash cleannullvalues_pedidos.sh
mysql --login-path=$lpath --local-infile=1 $db -vv < loadvalues_pedidos.mysql

bash cleannullvalues_op_extrusion.sh
mysql --login-path=$lpath --local-infile=1 $db -vv < loadvalues_op_extrusion.mysql
bash cleannullvalues_op_pintura.sh
mysql --login-path=$lpath --local-infile=1 $db -vv < loadvalues_op_pintura.mysql

bash cleannullvalues_produccion_cortetochos.sh
mysql --login-path=$lpath --local-infile=1 $db -vv < loadvalues_produccion_cortetochos.mysql

bash cleannullvalues_produccion_extrusion.sh
mysql --login-path=$lpath --local-infile=1 $db -vv < loadvalues_produccion_extrusion.mysql

bash cleannullvalues_produccion_envejecimiento.sh
mysql --login-path=$lpath --local-infile=1 $db -vv < loadvalues_produccion_envejecimiento.mysql

