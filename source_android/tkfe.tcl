# FE.tcl --
#
# GUI File explorer (FE) for ttk package
#
#  Copyright (c) 2020 Vladimir Orlov
# email: vorlov@lissi.ru

package require Tk 8.5.0
package require msgcat
namespace import msgcat::mc
namespace import -force msgcat::mcset

namespace eval FE {

  mcset en "Текущий каталог" "Current directory"
  mcset en "Выбранный каталог" "Selected directory"
  mcset en "Выбранный файл" "Selected file"
  mcset en "Выбранный файл/каталог" "Selected file/directory"
  mcset en "Выберите каталог" "Choose directory"
  mcset en "Выберите папку" "Choose folder"
  mcset en "Выберите файл" "Choose file"
  mcset en "Отмена" "Cancel"
  mcset en "Готово" "Done"
  mcset en "Папки и файлы" "Folders and files"
  mcset en "Размер файла" "File size"
  mcset en "Добавить скрытые папки:" "Add hidden folders:"
  mcset en "Фильтр файлов:" "File filter:"
  mcset en "Инструменты" "Tools"
  mcset en "Удалить файл" "Delete file"
  mcset en "Удалить каталог" "Delete directory"
  mcset en "Создать каталог" "Create directory"
  mcset en "Создать пустой файл" "Create empty file"
  mcset en "Нет доступа" "No access"
  mcset en "Переименовать каталог" "Rename directory"
  mcset en "Переименовать файл" "Rename file"
  mcset en "Введите новое имя папки" "Enter a new folder name"
  mcset en "Введите новое имя файла" "Enter a new file name"
  mcset en "Введите имя новой папки" "Enter a name for new folder"
  mcset en "Введите имя файла" "Enter a new file name"
  mcset en "Сменить язык" "Change language"
  mcset en "Выберите библиотеку PKCS11" "Select PKCS11 library"
  ###################################################################
  mcset ru "Current directory" "Текущий каталог"
  mcset ru "Selected directory" "Выбранный каталог"
  mcset ru "Selected file" "Выбранный файл"
  mcset ru "Selected file/directory" "Выбранный файл/каталог"
  mcset ru "Choose directory" "Выберите каталог"
  mcset ru "Choose folder" "Выберите папку"
  mcset ru "Choose file" "Выберите файл"
  mcset ru "Cancel" "Отмена"
  mcset ru "Done" "Готово"
  mcset ru "Folders and files" "Папки и файлы"
  mcset ru "File size" "Размер файла"
  mcset ru "Add hidden folders:" "Добавить скрытые папки:"
  mcset ru "File filter:" "Фильтр файлов:"
  mcset ru "Tools" "Инструменты"
  mcset ru "Change language" "Сменить язык"
  mcset ru "Select PKCS11 library" "Выберите библиотеку PKCS11"

  ttk::style configure Treeview  -background snow  -padding 0 -arrowsize 20
  ttk::style configure TCheckbutton  -background snow  -padding {1mm 0 0 0}

  image create photo upArrow -data {
    R0lGODlhDgAOAJEAANnZ2YCAgPz8/P///yH5BAEAAAAALAAAAAAOAA4AAAImhI+
  py+1LIsJHiBAh+BgmiEAJQITgW6DgUQIAECH4JN8IPqYuNxUAOw==}
  image create photo downArrow -data {
    R0lGODlhDgAOAJEAANnZ2YCAgPz8/P///yH5BAEAAAAALAAAAAAOAA4AAAInhI+
  py+1I4ocQ/IgDEYIPgYJICUCE4F+YIBolEoKPEJKZmVJK6ZACADs=}

  image create photo ru_24x16 -data {
    R0lGODlhGAAQAIQSAAA4pdUrHqkycnd/uHeAuHiBuXqCutt5edt6eb2Bmtx7et1+fd6Afs3Q49XX5vz8/P39/f7+/v//////////////////////////////////////
    /////////////////yH+EUNyZWF0ZWQgd2l0aCBHSU1QACH5BAEKAB8ALAAAAAAYABAAAAVGoCSOZGmK0amq0OqS6ftCT23feG43fO//wB5gSCwaj8MBcrlUMp9EAnQ6
    EFiv2KzWmgh4v+Cw2HsYm82LsxpcXq/TbjUiBAA7
  }
  image create photo usa_24x16 -data {
    R0lGODlhGAAQAMZ5ADk6azo6azo6bDo7bDs7bDs7bTs8bjw8bD4+b2A2ZLMhNLMhNbIjNmI5Z0RFckVFckZGdEdGcrIrPEdIckdIdLIsPEhJdElKdElKdUlKdkpLdkxM
    dUxNd01OeE5PeE9Qd1BQdlBRd1FRd1FSem1McFJUempPc1ZXe1hYfFhafV9fgF5ggWBhgWFhgWFigWRjhGRkhGVlhWZmhWtsiW1tinlrhXBviXhth3FyjntwiXN0jXp5
    kn16kHt8lH19lIOEmIWFmIeHmoiJnImJnIqKnouLn4uMn4yMn4yMoIyNoY2NnsV+g42NoI2NocZ+g8R/g42OoI2Oo4+PoI+PoY+QoZCQopCRoZGRo5GRpZOSppKTpJKT
    pZSUppSVpZWVp5aWqJaWqZaXqJiZp5mZq5maq5qbq5qbrJycrZydrp2drZ2erp2er56fsKCgstOorNGqrN/LzOPLzeTLzeXMzenR1Ojn6enn6fDn5/Hn5///////////
    /////////////////yH+OUNSRUFUT1I6IGdkLWpwZWcgdjEuMCAodXNpbmcgSUpHIEpQRUcgdjgwKSwgcXVhbGl0eSA9IDcwCgAsAAAAABgAEAAAB6GAJzMtJTQsLh87
    JBIVjY6Pjic+PkQ6P0BBOmJ0nJ2enjA+OzY9OD4zRkNwq6ytrRA2OkMzOzg/MzVOS7u8vbwvOzsyPjo7MT9teMrLzMwXsUEyPZY0ub7XuynFNrE6ODtic3Hj5OXkCDIu
    6TMrKjNAbm/y8/TzrG/3q277/P39casABoRjrmA5bAgTNlvIcGHCh75cSZwo0aDFi5AyaswYCAA7
  }

  image create photo eye_hidden -data {
    R0lGODlhFAAOAMZNADZATVJbZllxkFpxkVlykn+l2IOt5Yys1oOu5YOu55Gx2qOwwoq174q274u38JvB8qnB4arB4KrC4avC4bfL5crKrc/Jp8/Kp8rLrs/KqMvLrs3L
    q8zLr87LrNDLqMnOudDNrtHNr8fPvsjPvsnPu9HOsMjQv9bTudXUu9bUu9zWvNzXvN7Yvt/ZvuDZwODawcHh79Pf7sHk9cHk9sLk9sHl+NXg7tXg78Lm+cLm+sHn/sLn
    /cLo/+ft9u3y+e70/e/0+u/1/ff17fj27vT3+vX3+/z69vz79/38+f38+v39+/79+/79/P//////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////yH+EUNyZWF0ZWQgd2l0aCBHSU1QACH5BAEKAH8ALAAAAAAUAA4AAAe1gDyCg4SFhoUwJCkrKygkMIeDOyYvTDESFD1MLiY6hzIdQ0QKCQ5BTUBF
    Qx0yhTUZSE0KDQ4FPk0/B01KHjODOCVKTTGlAgABCw8INrslOYIYR01NEbUA1wAFDhHTRxyCFUbTENbY2hDTRhqCOCHCxA4D1wQOBsxJIM+CNRaxs7XaGOhScoFGIRkb
    hhQ5YMBBvQNFhGxoZWjHiBZMbEyYcGMJCxGeIvGA8eGEChUnPkASydJQIAA7
  }

  image create photo icontools -data {
    R0lGODlhGAAQAOeYAFVve1ZwfFt1gV53g194hGB5hGB5hWd9h26GknGHknWHkXOMmHSMmHaOmneOmnmQnHqRnXqSnXuSnXySnn2Tn4yaopKfpY6gqvuNAPuPAPuQAJCk
    rpCkr5GkrvuRC/WRKPuRE/uRFZGlr/uSDZilrKeioJOnsZaospapsrGjmJmpspiqtJqstZ2ttKGts56uuKKvtKWvtKCxuaOxuKS0vKW0vKW1vPqmOP+mJ6a1vaW2vf+n
    KKa2vqe2vqe3vq67w7O6vq69w6++xP+wSv+wTa+/xbC/xf+xT7K/xf+xVbHAxrLAxrTBx/+0XLfEybjEyrnFy7rFzLvGzLzGy7vHzL/Izb7JzsHL0MLM0MLM0cTM0cTO
    08fP1cjP08nQ1cvR1MrS1s3S1s3U2NDX29HY3NPY3NPZ3NLa3dTa3Nne4drg49vg493h4t3j5f7dwf3dyd/k5uLm6eTo6uXp6+bp6v3k1v3l1+jq7Ojr7enr7P3n2f3o
    2+rt7urt7/7p2+vu7+zv8O3v8e3w8e/y8/Dy8/Dz9PL09fP19f306/T29/706//17Pb3+P/27vj5+fr6+/r7+/v8/P78+vz9/f39/f7+/f7+/v/+/v//////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////yH+EUNyZWF0ZWQgd2l0aCBHSU1QACwAAAAAGAAQAAAI/gAxCbREEFCcPpPwTLlAQUUagZgsUYII0RKmQU6KFKHSRcsMChAeeKlIcaDASGqEGDkj
    EE4DCBHCmCxZySKmQ0GKRBHIaAEEA0BmUlzDR+AWJUWuCKwioUAABWjMTCwpZgMULh16LFFaZgIBAAEEOIDwpSSmQiZEqN0gwwcWBgMqsIkBAEECOmYp9fnxokYODjyW
    tLDwCBMJAAfu2DSLKRImRCk26FiSBRImRy7yYJpKkaDARk1ulNhgQ4kVRhU5V7TYiMiOER9gkFbyxNDAxasXHdnhIUOdRCw20FDCJFBE1QIpKUqCwwMGOwIJoRA+5omg
    iGYlDWkeQg/FPyekImBqc8ZzSUtuNIDYY1bOCjJI5jDG/sYPwfsWL+EBAyfi4oAAOw==
  }

  image create photo icondirdenied -data {
    R0lGODlhEAAQAMZiAAAAAMYBAv0AAvcFB/sEB/wEBfwEBvkFCfwIDfoQEvgWGPgeIPkkJFhYWM04OPwvIvtxPI2NjJKSkJKSkeN+fZWVk5WVlJmZmZqampubm52dnZ2d
    nqCgoKKioaKioqSkpKWlpKioqKmpqKurq62trLCwsbGxsrKysrOzs7W1tLa2t/+oWLm5uru7u7y8vL29vcDAv8HBwcLCw8PDwsjDwsXFxfq3tvu3tvu4t/u4uMfHxsnJ
    ycrKy8vLzM3Nzc3Nzs/P0NDQ0dPT1NTU1NXV1vzKyv3Ly9fX2NfX2dra29vb293d3t7e397e4N/f3//cqOHh4OLi4efn5+fn6Ofn6ejo6e3t7e7u7u7u8O/v8PHx8vLy
    8PT09PX19ff3+Pz8+vz8+/39+///////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////yH5BAEKAH8ALAAAAAAQABAAAAeqgH9/AA0AgoeIh4QrTwCGggcECAuKWw0NjI4BApwCCoIAYV9al4wPOUZGOAagYWBeWEuYDzZFRTcFoGBdWVVR
    RA0OnQIJoFxXUlBJQz40FAwDEIpWU05KQj01MS0mACuKVExIQTwzLywoId6KTUdAOzIuKSUjHuugAD86MOgkIh8Z7ikCoOLECBAdNFgQiMgRhw0YLkhgmMjRhAoTVzhK
    1BBABG8bOXbcGAgAOw==
  }

  image create photo icondir -data {
    R0lGODlhEAAQAMYAAAAAAFhYWP+oWP/cqPLy8P39+/z8+vHx8vz8+/f3+O7u8N3d3vX19e/v8Ojo6eLi4dXV1vT09O7u7ufn5+Hh4Nra29TU1M3NzcbGxby8u7Cwru3t
    7efn6N/f39vb29PT1MvLzMXFxcHBwbu7u7Gxsufn6d7e39fX2dDQ0crKy8PDwr29vbm5urOzs6ioqN7e4NfX2M/P0MnJycLCw7y8vLW1tLCwsaurq6Kios3NzsfHxsDA
    v62trKmpqKSkpJubm7a2t7KysqWlpKKioZ2dnZWVlKCgoJ2dnpqampmZmZKSkJKSkZWVk42NjP//////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////yH5BAEKAH8ALAAAAAAQABAAAAeYgH9/AAEAgoeIh4QCAwCGiYgABAEBjI6XiQAFBgeUjAMDAo+CmggJCguVoAMBkQgMDQ4PEJSeowAREhMUFRYX
    GBkaAAKKGxwdHh8gISIjJMOKJSYnKCkqKywtLtCkLzAxMjM0NTY3ONyDADk6O9k8PT4/6KQAQEE3QkNERfOKAEZHkCRR0i8SgCVMCIoaBclRk2GOIGXCFAgAOw==
  }
  image create photo icondirup -data {
    R0lGODlhEAAQAKUAABJNbwoSHxVUdIGeuhdYeggeMRlKat3v+BOQtBVWeAcXKBtLav38/VnD2jzX4RVaehtPb3HR4Bmzzg6gxUjf6RKQtRNUdgcYKhJMbeLw+Q6Xvxyi
    wxBTdQYQHSA3TwEDBAAAABFHYJ3e7iK60RWavA9dfgABAc3r9hGXuUPV3iKUsQomO/36/SqYswonOyzH1ReOrIDC21isxRSDnwoZKQgcLQccLP//////////////////
    /////////////////yH5BAEKAD8ALAAAAAAQABAAAAZiwJ9wSCwaj8ghIJAkCgaEQvNnGBwQCUVyMWA0HIiH1gjpRiQTSsVyKWIGmYZEo5k4NpzOkOP5gEIiGiMkJSYg
    h0YcJygpKitNHCyMLS6Qiy8wlUkcMTIjMyCQNDU2iFOnqEEAOw==
  }

  image create photo iconfile -data {
    iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABnUlEQVR42mNkgAJBORNWObMYbyCTnQENsDAx/v9xb/PGq2f2/ESXY4Qx1F0r4jU8ahYwYAEcrAwMnjr/
    tvdXhQVePLHjJ1YDFKzTsvQC+6ZiNYCNgSHAmI3h188fGIYgDLBKy9INwm4AKzPQABNWkFdAhuzorQgJuHxq108UA+RBBuBwAdgQhu8MDN9fMfwHsq/vnZx+8+CMWRgG
    6OAxAAT+/PjC8OvbB4bbu1uzn5xZPA3DAO0A/AaADfn1neHapvLsJ6fmoRogZ4kwINT0HwM/J6rGj0AfrD7NBGT9Z7i6sTT70bEZmAZoQQ0wkv/PwMmKasD33wwM5x5C
    lF/fVJr98Oh0TAM0/SEG6Mn8B8c9MvgBNODSE4QBj46hGSCLZICP/n8GXo7/KAZ8/sHIsOUiRPkNrAZYpGVpQA0IN0OEwen7jAznHzGiGHZzMxYDZEAG+BGOBbABW0qz
    H2MzQJ1IA24BXfD4OJoBksZxSZpB0+YSY8CN9TnJz84smIdiACMzK7eIumc4kGbHp/n/398/39zcsfL/319fQXwAnA23EZaHOEYAAAAASUVORK5CYII=
  }
  image create photo iconfiledenied -data {
    R0lGODlhEAAQAMZNAO0AAPEAAPADA/MSEs8fH/IWFs0uLtgvMOA2NuE3N986ROE9Pp9QYMdMekF52N9ZdOxbXEeD6FCC1VGC1UaE6+5cXkKF9EOG9ESG9EWH9EaI9EeI
    9EiJ9EmJ80mJ9Npmi0qK9J50xkuL9EyL9FGL602M9E6M9E+N9FKP9KN7y9twklaS9FeS9P2Agf+Bgf+CgnWk83al8/+FhXqo832p86mg3OaWloOt856n55K389Wsytas
    yJ6+8qC+8p+/8qC/8te0tO+wt6LD+e2zs6bF+q3H8uC8vOjFxe/IyNbU1OPc3O7o6Pjy8v//////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////yH+EUNyZWF0ZWQgd2l0aCBHSU1QACH5BAEKAH8ALAAAAAAQABAAAAeNgH+Cg4SFhCeIiSw/hoImj5ArRIyGJZaXKEJEPYYjnp8jJBMShiKmp6YR
    DoYgra6uFIYeHjxFtkU8Hh2GOkE7ODfBMxwchRUyLi8tNTQ0MBsbhQABAwUCDz4+ORoahARDTEtKSQcxGecZhAY2SEdGQA0Y8vKFCwgICQohF/z8hQwqIHxIYaGgwUYI
    CQUCADs=
  }

  #Процедура смены языка и синхронный перевод
  proc changelang {w} {
    #Смена языка и синхронный перевод
    #Смена иконки на кнопке
    if  {[msgcat::mclocale] == "ru"} {
      msgcat::mclocale en
      $w.titul.lang configure -image usa_24x16
    } else {
      msgcat::mclocale ru
      $w.titul.lang configure -image ru_24x16
    }
    #Перевод текста
    set r  [$w.tekdir cget -text]
    $w.tekdir configure -text [mc "$r"]
    set r  [$w.titul.lab cget -text]
    $w.titul.lab configure -text [mc "$r"]
    set r  [$w.seldir cget -text]
    $w.seldir configure -text [mc "$r"]
    set r  [$w.buts.cancel cget -text]
    $w.buts.cancel configure -text [mc "$r"]
    set r  [$w.buts.ok cget -text]
    $w.buts.ok configure -text [mc "$r"]
    set r [$w.fr.t heading {#0}   -text]
    $w.fr.t heading {#0} -text [mc "$r"]
    set r [$w.fr.t heading {size}   -text]
    $w.fr.t heading {size} -text [mc "$r"]
    set r  [$w.filter cget -text]
    $w.filter configure -text [mc "$r"]
  }

  proc readName ent {
    global widget
    global yespas
    global pass
    set pass [$ent get]
    $ent delete 0 end
    set yespas "yes"
  }


  #Увеличить/уменьшить картинку (отрицательное значение - уменьшение)
  proc scaleImage {im xfactor {yfactor 0}} {
    set mode -subsample
    if {0} {
      if {abs($xfactor) < 1} {
        set xfactor [expr round(1./$xfactor)]
      } elseif {$xfactor>=0 && $yfactor>=0} {
        set mode -zoom
      }
    }
    if {$xfactor>=0 && $yfactor>=0} {
      set mode -zoom
    } else {
      set xfactor [expr $xfactor * -1]
    }

    if {$yfactor == 0} {set yfactor $xfactor}
    set t [image create photo]
    $t copy $im
    $im blank
    $im copy $t -shrink $mode $xfactor $yfactor
    image delete $t
  }

  #Считываем размеры экрана в пикселях
  set ::scrwidth [winfo screenwidth .]
  set ::scrheight [winfo screenheight .]
  #Считываем размеры экрана в миллиметрах
  set ::scrwidthmm [winfo screenmmwidth .]
  set ::scrheightmm [winfo screenmmheight .]
  #Запоминаем сколько пикселей в 1 мм
  set ::px2mm [winfo fpixels . 1m]
  #Запоминаем сколько целых пикселей в 1 мм
  set aa [expr $::px2mm + 0.5]
  set ::intpx2mm [expr {int($aa)}]
  #Проверяем, что это телефон
  if {$::scrwidth < $::scrheight} {
    ttk::style configure TCombobox  -arrowsize [expr 5 * $::px2mm]
    set ::typetlf 1
  } else {
    ttk::style configure TCombobox  -arrowsize [expr 5 * $::px2mm]
    #Конфигурирование виджета под смартфон
    #Ширина 75 mm
    set ::scrwidth [expr {int(75 * $px2mm)}]
    #Высота 160 mm
    set ::scrheight [expr int(160 * $px2mm)]
  }
  set upz 1
  if { $::px2mm > 15} {
    set upz 6
  } elseif { $::px2mm > 10} {
    set upz 5
  } elseif { $::px2mm > 5} {
    set upz 3
  }
  if {$upz > 1} {
    scaleImage upArrow $upz
    scaleImage downArrow $upz
    scaleImage eye_hidden $upz
    scaleImage icontools $upz
    scaleImage icondirdenied $upz
    scaleImage icondir $upz
    scaleImage icondirup $upz
    scaleImage iconfile $upz
    scaleImage iconfiledenied $upz
    scaleImage usa_24x16 $upz
    scaleImage ru_24x16 $upz

  }

  set ha [image height iconfile]
  #Высота строк в treeview
  ttk::style configure Treeview  -rowheight [expr $ha + 2]

  proc filedel {w file typefb} {
    set answer [tk_messageBox -title "Удаление папки/файла" -icon question -message "Вы действительно\nхотите уничтожить\n$file ?" -type yesno]
    if {$answer != "yes"} {
      return
    }
#    file delete -force "$file"
    file delete -force [lindex $file 0]

    $w.seldir.entdir configure -state normal
    $w.seldir.entdir delete 0 end
    $w.seldir.entdir configure -state readonly
    populateRoots "$w.fr.t" "$::tekPATH" $typefb
  }

  proc showContextMenu {w x y rootx rooty fm typefb} {
    set s {}
    set t {}

    set w "$fm.fr.t"
    foreach i [$w selection] {
      #Это сторока из таблицы
      #Это путь к файлу или каталогу
      lappend s [lindex [$w item $i -value] 0]
      #Это тип субъекта
      lappend t [lindex [$w item $i -value] 1]
    }

    catch {destroy .contextMenu}
    menu .contextMenu -tearoff false
    .contextMenu add separator
    if {$s != ""} {
      if {$t == "denied"} {
        .contextMenu add command -label [mc "Нет доступа"] -command {}
      }
      if {$t == "file"} {
        .contextMenu add command -label [mc "Удалить файл"] \
        -command [list [namespace current]::filedel $fm $s $typefb]
        .contextMenu add separator
        .contextMenu add command -label [mc "Переименовать файл"] \
        -command [list [namespace current]::renameobj "$fm.titul.lab" "file"  $s $fm]
      }
      if {$t == "directory"} {
        .contextMenu add command -label [mc "Удалить каталог"] \
        -command [list [namespace current]::filedel $fm $s $typefb]
        .contextMenu add separator
        .contextMenu add command -label [mc "Переименовать каталог"] \
        -command [list [namespace current]::renameobj "$fm.titul.lab" "dir"  $s $fm]
      }
      .contextMenu add separator
    }
    .contextMenu add command -label [mc {Создать каталог}] \
    -command [list [namespace current]::createdir "dir" $fm.titul.lab $fm $typefb]
    if {$typefb != "dir"} {
      .contextMenu add separator
      .contextMenu add command -label [mc "Создать пустой файл"] \
      -command [list [namespace current]::createdir "file" $fm.titul.lab $fm $typefb]
    }
    .contextMenu add separator

    set wt [image width icontools]
    if {$x > $wt} {
      set wt $x
    }
    set wt [expr $rootx - $x + $wt]
    set ht [image height icontools]
    if {$y > $ht} {
      set ht $y
    }
    set ht [expr $rooty - $y + $ht]

    tk_popup .contextMenu $wt $ht
    .contextMenu configure -activebackground wheat2
    .contextMenu configure -background cyan
  }

  ## Code to do the sorting of the tree contents when clicked on
  proc columnSort {tree col direction } {
    set ncol [list fullpath size]
    # Determine currently sorted column and its sort direction
    foreach c $ncol {
      if {$c == "#0"} {
        set c "fullpath"
      }
      set s [$tree heading $c state]
      if {("selected" in $s || "alternate" in $s) && $col ne $c} {
        # Sorted column has changed
        $tree heading $c -image noArrow state {!selected !alternate !user1}
        set direction [expr {"alternate" in $s}]
      }
    }

    # Build something we can sort
    set data {}
    foreach row [$tree children {}] {
      if {$col == "#0"} {
        lappend data [list [$tree set $row "fullpath"] $row]
      } else {
        lappend data [list [$tree set $row $col] $row]
      }
    }

    set dir [expr {$direction ? "-decreasing" : "-increasing"}]
    #    set r -1
    #Оставляем .. в начале списка
    set r 0
    set data1 [lrange $data 1 end]

    # Now reshuffle the rows into the sorted order

    foreach info [lsort -dictionary -index 0 "$dir" "$data1"] {
      $tree move [lindex $info 1] {} [incr r]
    }

    # Switch the heading so that it will sort in the opposite direction
    $tree heading $col -command [list [namespace current]::columnSort $tree $col [expr {!$direction}]] \
    state [expr {$direction?"!selected alternate":"selected !alternate"}]

    if {[ttk::style theme use] eq "aqua"} {
      # Aqua theme displays native sort arrows when user1 state is set
      $tree heading $col state "user1"
    } else {
      $tree heading $col -image [expr {$direction?"upArrow":"downArrow"}]
    }
  }

  proc   helptools {fromw tow xtow text } {
    set tr [mc $text]
    place forget $fromw
    $fromw configure -text $tr
    place $fromw  -in $tow -relx $xtow -rely 1.0
  }

  proc initfe {typew w initdir typefb otv msk} {
    #Для Win32
    if {0} {
      #Целесообразно делать в программе пользователя
      if {[tk windowingsystem] == "win32"} {
        set initdir [encoding convertfrom cp1251 $initdir ]
        set initdir [string map {"\\" "/"} $initdir]
      }
    }
    catch {destroy $w}
    if {$typew == "frame"} {
      frame $w -bg white
    } else {
      toplevel $w -bd 3  -relief groove -bg white
      if {$typefb == "dir"} {
        wm title $w [mc "Выберите каталог"]
        wm iconphoto $w icondir
      } else {
        wm title $w [mc "Выберите файл"]
        wm iconphoto $w iconfile
      }
      set tw $::scrwidth
      set th [expr $::scrheight - 100]
      wm minsize $w $::scrwidth  [expr $::scrheight - 100]
      set geometr $tw
      append geometr "x"
      append geometr $th
  #Считываем размеры экрана в пикселях
      set rw [winfo screenwidth .]
      set rh [winfo screenheight .]
      if { $rw <= $rh } {
         append geometr "+0+0"
      } else {
#Координаты главного окна
	set rgeom [wm geometry .]
	set rgf [string first "x" $rgeom]
	set rw [string range $rgeom 0 $rgf-1]
	set rg [string first "+" $rgeom]
	set xx [string range $rgeom $rgf+1 $rg-1]
	set rg1 [string range $rgeom $rg+1 end]
	if {$rw <= $tw} {
#Окно fe уже главного окна
    	    append geometr $rg1
        } else {
	    set off [expr ($rw - $tw) / 2]
	    set rg2 [string first "+" $rg1]
	    incr rg
	    incr rg2 -1
	    set offw [string range $rg1 0 $rg2]
	    set offw1 [expr $offw + $off]
	    incr rg2 2
	    set offw2 [string range $rg1 $rg2  end]
	    set offw2 [expr $offw2 + ($xx - $th)/2]
    	    append geometr "+$offw1+$offw2"

        }
      }
      wm geometry $w $geometr
      #Убрать обрамление
      #	wm overrideredirect $w 1
    }
    set fm "$w"
    frame $fm.fr

    if {$typefb != "dir"} {
      ttk::treeview $fm.fr.t -columns {fullpath type size } -displaycolumns {size} \
      -yscroll "$fm.fr.y set" -xscroll "$fm.fr.x set" -pad 0 -padding 0
    } else {
      ttk::treeview $fm.fr.t -columns {fullpath type size } -displaycolumns {} \
      -yscroll "$fm.fr.y set" -xscroll "$fm.fr.x set" -pad 0 -padding 0
    }
    ttk::scrollbar $fm.fr.y -orient vertical -command "$fm.fr.t yview"
    ttk::scrollbar $fm.fr.x -orient horizontal -command "$fm.fr.t xview"
    eval "$fm.fr.t heading {#0} -text {[mc {Папки и файлы}]} -image upArrow -command {[namespace current]::columnSort $fm.fr.t {#0} 0} "
    eval "$fm.fr.t heading size -text {[mc {Размер файла}]} -image upArrow -command {[namespace current]::columnSort $fm.fr.t size 0}"
    if {$typefb != "dir"} {
      $fm.fr.t column size -stretch 1 -width 80 -anchor ne
      $fm.fr.t column "#0" -stretch 1 -width 170 -anchor nw
    } else {
      $fm.fr.t column size -stretch 1 -width 0 -anchor ne
      $fm.fr.t column "#0" -stretch 1 -width 75 -anchor nw
    }

    eval "bind $fm.fr.t <Double-1> {[namespace current]::selectobj $fm.fr.t $typefb 2 $otv}"
    eval "bind $fm.fr.t <ButtonRelease-1> {[namespace current]::selectobj $fm.fr.t $typefb 1 $otv}"
    eval "bind $fm.fr.t <ButtonPress-3> {[namespace current]::showContextMenu %W %x %y %X %Y $w $typefb}"

    frame $fm.buts -bg white
    eval "ttk::button $fm.buts.ok -text [mc {Готово}]  -command {[namespace current]::fereturn $typew $fm $typefb $otv}"
    eval "ttk::button $fm.buts.cancel -text [mc {Отмена}]  -command {[namespace current]::fecancel $typew $fm $typefb $otv}"
    pack $fm.buts.ok -side right
    pack $fm.buts.cancel -side right  -padx 1mm
    pack $fm.buts -side bottom -fill x -padx 1mm -pady 1mm

    frame $fm.titul  -relief flat -bg white
    if {$typefb == "dir"} {
      set ltit [mc "Выберите папку"]
    } else {
      set ltit [mc "Выберите файл"]
    }
    label $fm.titul.lab -text $ltit -relief flat -bg skyblue -justify center
    if {[msgcat::mclocale] == "ru" } {
      eval "button $fm.titul.lang -relief flat -image ru_24x16 -command {[namespace current]::changelang $fm} -bg white"
    } else {
      eval "button $fm.titul.lang -relief flat -image usa_24x16 -command {[namespace current]::changelang $fm} -bg white"
    }
    eval "bind  $fm.titul.lang <Enter> {[namespace current]::helptools $fm.helpview $fm.titul.lab 0.5 {[mc {Сменить язык}]}}"
    eval "bind  $fm.titul.lang <Leave> {place forget $fm.helpview}"

    eval "button $fm.titul.tools -relief flat -image icontools -command {} -bg white "
    eval "bind $fm.titul.tools <ButtonRelease-1> {[namespace current]::showContextMenu %W %x %y %X %Y $fm $typefb}"
    eval "bind  $fm.titul.tools <Enter> {[namespace current]::helptools $fm.helpview $fm.titul.lab 0.0 {[mc {Инструменты}]}}"
    eval "bind  $fm.titul.tools <Leave> {place forget $fm.helpview}"

    pack $fm.titul.tools -side left -anchor nw
    pack $fm.titul.lab -side left -fill x -expand 1
    pack $fm.titul.lang -side right -anchor ne

    labelframe $fm.filter -text [mc "Добавить скрытые папки:"] -bg skyblue -bd 0 -labelanchor w
    if {$msk == "" } {
      set msk "*"
    }

    if {$typefb != "dir"} {
      ttk::combobox $fm.filter.entdir -width 0 -values $msk
      pack $fm.filter.entdir -side left -anchor w -fill both -expand 1
      eval "bind $fm.filter.entdir <<ComboboxSelected>> {[namespace current]::selectobj $fm.fr.t $typefb 3 $otv}"
      eval "bind $fm.filter.entdir <Key-Return> {[namespace current]::selectobj $fm.fr.t $typefb 3 $otv}"
      $fm.filter.entdir delete 0 end
      $fm.filter.entdir insert end [lindex $msk 0]
      $fm.filter.entdir configure -state readonly
      $fm.filter configure -text [mc "Фильтр файлов:"]
    }
    variable [namespace current]::hiddencb
    set [namespace current]::hiddencb 0
    eval "ttk::checkbutton $fm.filter.hiddencb -image eye_hidden -padding {1mm 0 0 0} -variable [namespace current]::hiddencb -command {[namespace current]::selectobj $fm.fr.t $typefb 3 $otv}"
    eval "bind $fm.filter.hiddencb <Enter> {[namespace current]::helptools $fm.helpview $fm.filter 0.20 {[mc {Добавить скрытые папки:}]}}"

    eval "bind $fm.filter.hiddencb <Leave> {place forget $fm.helpview}"
    pack $fm.filter.hiddencb -side right -anchor ne -padx 0 -pady 0

    label $fm.helpview -text "Подсказка" -anchor nw -justify left -bg #ffe0a6

    labelframe $fm.tekdir -text [mc "Текущий каталог"] -bg skyblue -bd 0 -labelanchor n
    entry $fm.tekdir.entdir -relief flat -bg white -highlightcolor blue
    pack $fm.tekdir.entdir -side right -anchor ne -fill x -expand 1
    $fm.tekdir.entdir delete 0 end
    if {$typefb == "dir"} {
      set ltit [mc "Выбранный каталог"]
    } else {
      set ltit [mc "Выбранный файл/каталог"]
    }
    labelframe $fm.seldir -text $ltit -bg skyblue -bd 0 -labelanchor n
    entry $fm.seldir.entdir -relief flat -bg white -highlightthickness 1 -highlightbackground skyblue -highlightcolor blue
    pack $fm.seldir.entdir -side right -anchor ne -fill x -expand 1
    $fm.seldir.entdir delete 0 end
    if {$typefb == "dir"} {
      set ltit [mc "Выберите папку"]
    } else {
      set ltit [mc "Выберите файл"]
    }
    $fm.seldir.entdir configure -state readonly

    ###############=============PACK=============================
    pack $fm.titul -anchor ne -expand 0 -fill x -side top -pady {0 0}
    pack $fm.buts -anchor sw -expand 0 -fill both -side bottom
    pack $fm.filter -anchor ne -expand 0 -fill both -side top
    pack $fm.seldir -anchor se -expand 0 -fill both -side bottom
    pack $fm.tekdir -anchor ne -expand 0 -fill x -side bottom
    pack $fm.fr.y -anchor ne -expand 0 -fill y -side right
    pack $fm.fr.t -anchor center -expand 1 -fill both -side top

    pack $fm.fr -fill both -expand 1 -side top -padx 1mm -anchor nw

    ##################################################

    page_newdir $fm $typefb
    populateRoots "$fm.fr.t" "$initdir" $typefb
    if {$typew != "frame"} {
      tkwait visibility $w
      grab set $w
    }
    }

  proc selectobj {w typefb click otv} {
    if {$click == 3} {
      set w1 [string range $w 0 end-5]
      set tekdir "[$w1.tekdir.entdir get]"
      if {$typefb != "dir"} {
        set mask [$w1.filter.entdir get]
      } else {
        set mask "*"
      }
#      foreach dir [lsort -dictionary "$tekdir"] {}
      set dir "$tekdir"
        populateTree $typefb $mask $w [$w insert {} end -text "$dir" \
        -values [list "$dir" directory]]
#      {}
    }
    set num [$w selection]
    set titem [$w item $num -value]
#puts "titem=$titem"
    if {$click == 2 && [lindex $titem 1] == "directory"} {
      #Выбираем имя главного фрейма/окна
      set tekdir "[lindex $titem 0]"
      set w1 [string range $w 0 end-5]

      $w1.tekdir.entdir configure -state normal
      $w1.tekdir.entdir delete 0 end
      $w1.tekdir.entdir insert end $tekdir
      $w1.tekdir.entdir configure -state readonly
      if {$typefb != "dir"} {
        set mask [$w1.filter.entdir get]
      } else {
        set mask "*"
      }
#puts "tekdir=$tekdir"
#      foreach dir [lsort -dictionary "$tekdir"] {}
      set dir "$tekdir"
#puts "selectobj dir=$dir"
        populateTree $typefb $mask $w [$w insert {} end -text "$dir" \
        -values [list "$dir" directory]]
#      {}
    } elseif {$click == 2 && [lindex $titem 1] == "file"} {
      set fm [string range $w 0 end-5]
      set tekdir "[lindex $titem 0]"
    } elseif {$click == 3 } {
      set tekdir ""
    } else {
      set tekdir "[lindex $titem 0]"
    }
    set w1 [string range $w 0 end-5]
    $w1.seldir.entdir configure -state normal
    $w1.seldir.entdir delete 0 end
    $w1.seldir.entdir insert end "[file tail $tekdir]"
    $w1.seldir.entdir configure -state readonly

    if {$click == 2 && [lindex $titem 1] == "file"} {
      set fm [string range $w 0 end-5]
      set typew window
      #Это очень важно выполнение в другом потоке
      after 10 [namespace current]::fereturn $typew $fm $typefb $otv
    }
  }

  proc fereturn {typew w typefb otv} {
    variable $otv
    set num [$w.fr.t selection]
    set titem [$w.fr.t item $num -value]
    set ret [lindex $titem 0]
    if {$ret == ""} {
      if {$typefb == "dir"} {
        $w.tekdir.entdir configure -state normal
        set ret [$w.tekdir.entdir get]
        $w.tekdir.entdir configure -state readonly
      } else {
        return
      }
    }
    set rettype [lindex $titem 1]
    if {$typefb != "dir" && $rettype != "file"} {
      return
    }

    set $otv $ret
    if {$typew != "frame"} {
      grab release $w
    }
    catch {destroy $w}
    return $otv
  }

  proc fecancel {typew w typefb otv} {
    catch {destroy $w}
    variable $otv
    set $otv ""
    if {$typew != "frame"} {
      grab release $w
    }
    return $otv
  }

  ## Code to populate the roots of the tree (can be more than one on Windows)
  proc populateRoots {tree dir typefb} {
    global env

    set tekdir $dir
    set w1 [string range $tree 0 end-5]
    $w1.tekdir.entdir configure -state normal
    $w1.tekdir.entdir delete 0 end
    $w1.tekdir.entdir insert end $tekdir
    $w1.tekdir.entdir configure -state readonly
    if {$typefb != "dir"} {
      set mask [$w1.filter.entdir get]
    } else {
      set mask "*"
    }
#    foreach dir [lsort -dictionary "$tekdir"] {}
    set dir "$tekdir"
      populateTree $typefb $mask $tree "[$tree insert {} end -text "$dir" \
      -values [list "$dir" directory]]"
#    {}
  }

  ## Code to populate a node of the tree
  proc populateTree {typefb mask tree node} {
    #eye - глаз
    if {[$tree set $node type] ne "directory"} {
      return
    }
    set path "[$tree set $node fullpath]"
    #На первый уровень
    set node ""
    set fm [string range $tree 0 5]
    variable [namespace current]::hiddencb
    set directory_list ""

    set rr [file readable "$path"]
    if {$rr == 0} {
      tk_messageBox -title "Просмотр папки" -icon info -message "Каталог не доступен:\n$path"
      set ::tekPATH $path
      return
    }

    set directory_list [lsort -dictionary [glob -nocomplain -types d -directory "$path" "*"]]
    if {$FE::hiddencb} {
      set directory_list1 [lsort -dictionary [glob -nocomplain -types d -directory "$path" ".*"]]
      set ptr [string first "/.. " $directory_list1]
      if {$ptr != -1} {
        append directory_list [string range $directory_list1 [expr $ptr + 3] end ]
      }
    }
    set ::tekPATH $path
    $tree delete [$tree children $node]
    set id 0
    set levelup [file dir $path ]
    set type [file type $levelup]
    set id [$tree insert $node end -image icondirup -text ".." \
    -values [list $levelup $type]]
    $tree item $id -text ".."
    foreach f $directory_list {
      set type [file type "$f"]
      set rr [file readable "$f"]
      if {$rr == 0} {
        set id [$tree insert $node end -image icondirdenied -text {[file tail "$f"]} \
        -values [list "$f" "denied"]]
      } else {
        set id [$tree insert $node end -image icondir -text {[file tail "$f"]} \
        -values [list "$f" $type]]
      }
      set ee [file tail $f]
      $tree item $id -text "$ee"
    }
    if {$typefb != "dir"} {
      set files_list [lsort -dictionary  [glob -nocomplain -types f -directory "$path" "$mask"] ]
      foreach f $files_list {
        set type [file type $f]
        if {$typefb == "fileopen"} {
          #Можно было бы задать -types {f r}, но тогда бы мы не увидели часть файлов в списке (denied)
          set rr [file readable $f]
        } else {
          set rr [file writable $f]
          #Можно было бы задать -types {f w}
        }
        if {$rr == 0} {
          set id [$tree insert $node end -image iconfiledenied -text [file tail $f] \
          -values [list $f "denied"]]
        } else {
          set id [$tree insert $node end -image iconfile -text [file tail $f] \
          -values [list $f $type]]
        }
        set size [file size $f]
        ## Format the file size nicely
        if {0} {
          if {$size >= 1024*1024*1024} {
            set size [format %.1f\ GB [expr {$size/1024/1024/1024.}]]
          } elseif {$size >= 1024*1024} {
            set size [format %.1f\ MB [expr {$size/1024/1024.}]]
          } elseif {$size >= 1024} {
            set size [format %.1f\ KB [expr {$size/1024.}]]
          } else {
            append size " bytes"
          }
        }
        $tree set $id size $size
      }
    }

    $tree set $node type processedDirectory
  }

  proc page_newdir {fm typefb}  {
    set ::newname  [mc "Введите имя новой папки"]
    ttk::label $fm.lforpas -text [mc "Введите имя новой папки"]  -textvariable ::newname

    #Widget for new Name
    frame $fm.topName -relief flat -bd 3 -bg chocolate
    labelframe $fm.topName.labFrPw -borderwidth 4 -labelanchor nw -relief groove -labelwidget $fm.lforpas -foreground black -height 120 -width 200  -bg #eff0f1
    pack $fm.topName.labFrPw -in $fm.topName  -anchor nw -padx 1mm -pady 1mm -fill both -expand 0
    entry $fm.topName.labFrPw.entryPw -background snow  -highlightbackground gray85 -highlightcolor skyblue -justify left -relief sunken
    pack $fm.topName.labFrPw.entryPw -fill x -expand 1 -padx 1mm -ipady 2 -pady 2mm
    eval "bind $fm.topName.labFrPw.entryPw <Key-Return> {[namespace current]::readName $fm.topName.labFrPw.entryPw}"
    ttk::button $fm.topName.labFrPw.butPw  -command {global yespas;set yespas "no"; } -text [mc "Отмена"]
    eval "ttk::button $fm.topName.labFrPw.butOk  -command {[namespace current]::readName $fm.topName.labFrPw.entryPw} -text [mc Готово]"
    pack $fm.topName.labFrPw.butPw $fm.topName.labFrPw.butOk -pady {0 5} -sid right -padx 5 -pady {0 2mm}
    }

  proc readName ent {
    global widget
    global yespas
    global pass
    set pass [$ent get]
    $ent delete 0 end
    set yespas "yes"
  }

  proc createdir {type w fm typefb} {
    global pass
    global yespas
    if {$type == "dir"} {
      set ::newname  [mc "Введите имя новой папки"]
    } elseif {$type == "file"} {
      set ::newname  [mc "Введите имя файла"]
    } else {
      return
    }
    set r  [$fm.topName.labFrPw.butPw cget -text]
    $fm.topName.labFrPw.butPw configure -text [mc "$r"]
    set r  [$fm.topName.labFrPw.butOk cget -text]
    $fm.topName.labFrPw.butOk configure -text [mc "$r"]
    place $fm.topName -in $w -relx 0.0 -rely 1.0 -relwidth 0.98
    focus $fm.topName.labFrPw.entryPw
    set yespas ""
    vwait yespas
    place forget $fm.topName
    if { $yespas == "no" } {
      set pass ""
      return 0
    }
    set yespas "no"
    set newdir $pass
    set newd [file join $::tekPATH $newdir]
    if {[file exists $newd]} {
#      puts "Такое имя уже есть"
      return
    }
    if {$type == "dir"} {
      file mkdir $newd
      #Доделать
      populateRoots "$fm.fr.t" "$newd" "dir"
    } else {
      set fd [open $newd w]
      chan configure $fd -translation binary
      close $fd
      populateRoots "$fm.fr.t" "$::tekPATH" $type
    }
    set pass ""
    }

  proc renameobj {w type oldname fm} {
    global pass
    global yespas
    if {$type == "dir"} {
      set ::newname  [mc "Введите новое имя папки"]
    } elseif {$type == "file"} {
      set ::newname  [mc "Введите новое имя файла"]
    } else {
      return
    }
    #Перевод текста у кнопок
    set r  [$fm.topName.labFrPw.butPw cget -text]
    $fm.topName.labFrPw.butPw configure -text [mc "$r"]
    set r  [$fm.topName.labFrPw.butOk cget -text]
    $fm.topName.labFrPw.butOk configure -text [mc "$r"]

    place $fm.topName -in $w -relx 0.0 -rely 1.0 -relwidth 0.98

    focus $fm.topName.labFrPw.entryPw
    set yespas ""
    vwait yespas
    place forget $fm.topName
    if { $yespas == "no" } {
      set pass ""
      return 0
    }
    set yespas "no"
    set newdir $pass
    set newd [file join $::tekPATH "$newdir"]
    set oldn [file join $::tekPATH "$oldname"]
puts "\n$newdir\n$oldname\n$newd\n$oldn"

    if {[file exists $newd]} {
      if {$type == "file"} {
        set answer [tk_messageBox -title "Переименование файла" -icon question -message "Файл с таким именем есть:\n$oldname\nПродолжить операцию ?" -type yesno]
        if {$answer != "yes"} {
          return
        }
      }
    }
    file rename -force "[lindex $oldname 0]" "$newd"
#    file rename -force "$oldn" "$newd"
    $fm.seldir.entdir configure -state normal
    $fm.seldir.entdir delete 0 end
    $fm.seldir.entdir configure -state readonly
    populateRoots "$fm.fr.t" "$::tekPATH" $type
    set pass ""
  }
  proc fe_getsavefile {typew w tekdir msk} {
    #Формируем случайную переменную
    set rand [expr int(rand() * 10000)]
    set rr "otv$rand"
    #Ответ будет создан в пространстве имен fileexplorer!!!
    variable $rr
    initfe $typew $w $tekdir filesave $rr $msk
    return "FE::$rr"
  }
  proc fe_getopenfile {typew w tekdir msk} {
    #Формируем случайную переменную
    set rand [expr int(rand() * 10000)]
    set rr "otv$rand"
    #Ответ будет создан в пространстве имен fileexplorer!!!
    variable $rr
    initfe $typew $w $tekdir fileopen $rr $msk
    return "FE::$rr"
  }
  proc fe_choosedir {typew w tekdir} {
    #Формируем случайную переменную
    set rand [expr int(rand() * 10000)]
    set rr "otv$rand"
    #Ответ будет создан в пространстве имен fileexplorer!!!
    variable $rr
    initfe $typew $w $tekdir dir $rr ""
    return "FE::$rr"
  }

  namespace export fe_getsavefile
  namespace export fe_getopenfile
  namespace export fe_choosedir
}

