let
    Origen = Excel.CurrentWorkbook(){[Name="Demo_PQ"]}[Content],
    #"Tipo cambiado" = Table.TransformColumnTypes(Origen,{{"Categoría", type text}, {"Monto", Int64.Type}}),
    #"Filas agrupadas" = Table.Group(#"Tipo cambiado", {"Categoría"}, {{"Suma_Monto", each List.Sum([Monto]), type nullable number}})
in
    #"Filas agrupadas"