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
  set ::FE::folder(details) 0
  set ::FE::folder(foldersfirst) 0
#  set ::FE::folder(reverse) 0
  set ::FE::folder(column) "#0"
  set ::FE::folder(direction) 0
  set ::FE::folder(sepfolders) 0
  ###################################################################
  mcset ru "No access" "Нет доступа"
  mcset ru "Create directory" "Создать каталог"
  mcset ru "Rename directory" "Переименовать каталог"
  mcset ru "Create an empty file" "Создать пустой файл"
  mcset ru "Delete file" "Удалить файл"
  mcset ru "Rename file" "Переименовать файл"
  mcset ru "Delete directory" "Удалить каталог"
  mcset ru "Enter a new folder name" "Введите новое имя папки"
  mcset ru "Enter a new file name" "Введите новое имя файла"
  mcset ru "Enter a name for new folder" "Введите имя новой папки"
  mcset ru "Enter a new file name" "Введите имя файла"
  mcset ru "Detailed View" "Расширенный список"
  mcset ru "Short View" "Только имена"
  mcset ru "Sorting" "Сортировка"
  mcset ru "Data composition" "Состав данных"
  mcset ru "Current directory" "Текущий каталог"
  mcset ru "Go up" "Перейти вверх"
  mcset ru "Selected directory" "Выбранный каталог"
  mcset ru "Selected file" "Выбранный файл"
  mcset ru "Selected file/directory" "Выбранный файл/каталог"
  mcset ru "Choose directory" "Выберите каталог"
  mcset ru "Choose folder" "Выберите папку"
  mcset ru "Choose file" "Выберите файл"
  mcset ru "Cancel" "Отмена"
  mcset ru "Done" "Готово"
  mcset ru "Folders and files" "Папки и файлы"
  mcset ru "Folders" "Папки"
  mcset ru "Files" "Файлы"
  mcset ru "File" "Размер"
  mcset ru "Permissions" "Права"
  mcset ru "Size" "Размер"
  mcset ru "Date" "Дата"
  mcset ru "Add hidden folders" "Добавить скрытые папки"
  mcset ru "Hide hidden folders" "Убрать скрытые папки"
  mcset ru "File filter:" "Фильтр файлов:"
  mcset ru "Tools" "Инструменты"
  mcset ru "Change language" "Сменить язык"
  mcset ru "Select PKCS11 library" "Выберите библиотеку PKCS11"
  mcset ru "Detailed View" "Расширенный список"
  mcset ru "Short View" "Только имена"

  ttk::style configure Treeview  -background snow  -padding 0
#   -arrowsize 20
  ttk::style configure TCheckbutton  -background snow  -padding {1mm 0 0 0}

##############Image fsdialog#################################
# Images for the configuration menu

image create photo fe_blank16 -height 16 -width 16
option add *TkFDialog*Menu.Image fe_blank16

image create photo fe_tick16_old -data {
R0lGODlhEAAQAMIAAExOTFRSVPz+/AQCBP///////////////yH5BAEKAAQALAAAAAAQABAA
AAM4CAHcvkEAQqu18uqat+4eFoTEwE3eYFLCWK2lelqyChMtbd84+sqX3IXH8pFwrmNPyRI4
n9CoIAEAOw==}

image create photo fe_tick16 -data {
iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAACXBIWXMAAA7EAAAO
xAGVKw4bAAAAB3RJTUUH4wIBDAIJ3IjUywAAAB1pVFh0Q29tbWVudAAAAAAAQ3Jl
YXRlZCB3aXRoIEdJTVBkLmUHAAAAg0lEQVQoz2N8+eFTxZkfdz79ZyAEFLgZekw5
GBN3v7Ll++alwMnNzY1fw9b7X7c++ct05/N/YlQzMDB4K3I/+M7MwsDAAFHttesr
HtXb3KAmMjGQCEY1DA4NLJhxScAGRW6Grfe/EqN017PfKjwMjC/ffSw5+fXBd2aC
GlR4GIrlPwEARYApx4EpM+MAAAAASUVORK5CYII=
}
image create photo fe_unchecked_tick16  -data {
iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAACXBIWXMAAA7EAAAO
xAGVKw4bAAAAB3RJTUUH4wIBDAwy8wAQYQAAAB1pVFh0Q29tbWVudAAAAAAAQ3Jl
YXRlZCB3aXRoIEdJTVBkLmUHAAAAdUlEQVQoz2N8++nTjsc/3v38z0AICLAweMpy
MC698kqK8ZumCCc3Nzd+DVfffL314S/Tu1//iVHNwMCgLcL98R8zEwMDAzGq4YCJ
gUQwqmGoahBgYbj25isxSu98+C3IxsD45v3HbQ+/fvzHTFCDEBuDIesnAE3cJiD1
JFxnAAAAAElFTkSuQmCC
}


image create photo fe_radio16_old -data {
R0lGODlhEAAQAMIAAJyZi////83OxQAAAP///////////////yH5BAEKAAEALAAAAAAQABAA
AAMtGLrc/jCAOaNsAGYn3A5DuHTMFp4KuZjnkGJK6waq8qEvzGlNzQlAn2VILC4SADs=}

image create photo fe_radio16 -data {
iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAACXBIWXMAAA7EAAAO
xAGVKw4bAAACYUlEQVQ4jZWUPU8UURSGn3MvO7NAyFCgC7uJFCTESjuDigSDLAUE
t9YfYCig5TfYQoF/QOoNipEFIuIXsdPGhMSGuAuLFEwIsDPrzLFYIBA+Vk9zi3vP
c+99875HVJXLSkD687sewEqu1Ve49LBcBOrLlwcSIhMxZKOYJIA1VAwUqqpTq7nU
8pWg3rmdlmSss1V0OJtxtSflmHSjBaB0GLFWDuNCMZAEMl8x8uTjaNveOVDv3E5L
E/q1LWm6Jm+3JLq9GiA6usdKbV33I55/36vuHMY/D5A7x7CGY2Iy1tm2JtM1c99L
OFZ4txmw8Ctgcz8CoKPZMpRxeZh2mbnnJcY++13bB/FLYPTkRX358oAgi1N3W6Xb
s7z4sc/8RoUwPquDY2CkM8mzm82s+xETX3ZV0cHVXGrZACREJrIZV7s9y/vNgDcb
wTkIQBjD/EbAh62Abs+SzbjqGBkHMAISQ7Yn5RiApVJIEF9uiSBSFoshAD0px0TK
kIA09Od3vUhJphstCmwdaXJVbe5HKJButEQxyf78rmfqdv1jmZVcq28NldJhhADt
zbZuU0ezRah5yxoqK7lW3yiogcJauSbvYMbBNXIpxLXCYMYBYK0cxlZYOGJAVXWq
UAxk3Y/oa3cZ7nRxL/i0a2D4hsuDdpd1/w+FYiBhrNNwytmP8r9fXW8yQyeGLAUU
igGlg5r46SZL9siQYaSMffKr24fx26XH10bPgE4i0mi6Jm/Vici3vepO5WxEzodW
9WVVdeTK0Iq8rog8vTC0p6svXx5wjIxHytDpMWKFhTDW6bpj5Nzmfwy2v4HoOusK
Vn8dAAAAAElFTkSuQmCC
}

image create photo fe_radio16_unchecked  -data {
iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAACXBIWXMAAA7EAAAO
xAGVKw4bAAABxElEQVQ4jZ2UT28SQRiHf+87A4FdC0hiG6glHLyV1rPRXv0cnhWb
mH6OxgTRePRzeMZ48iBtjyYEzZJqwp8tu0tgZ14vYFp0BfqcJ89MJnl+JCJIovFl
UGE12wMA1rr7vFb8nnSWlkUfOp3M5GrrmEWOQXTX1TQFgCCWNEQGlqiR2bpqPKtW
J4mit1/7+ymyH8sO52sFdgspvnHJcGZxPrSBF9rRTPjpi4fFi79E79uDGsO0jrZ1
vpS9KVjGiyxaP+PRTPjxQkYigteff2TdO5lvR/d0aZVkQS+yaP0y3ngcPXj16H7E
AJBxsie7Dq98yXVKWUbZoULGyZ4AAAMgzagf5JSztmXOQU45ilEHQNxsX1aJxM2l
aVMPcmkCk7jN9mWVlVEVR3G8sWWOqzhWRlXW/5QVaKNMNzTQtxUExmqjTJfrhzsd
EQr8aXIqSfhTgRUE9cOdDgOQ2KJ55ptwU9GZb0JjqQlAGAAmYXTqhTLsRXZtSS+y
8EIZTsLoFLiWyLyzT0+2db5820QWLKLddSi/X1D/jnZkx15g/cRoF/yZEchLgIqu
lhkABDGlAOlD0Ejnxm/+OyPLvDvv79k4rgCrh+03NU/rBj9b11QAAAAASUVORK5C
YII=
}

# Images for ttk::getOpenFile, ttk::getSaveFile, ttk::getAppendFile

image create photo fe_next -data {
R0lGODlhFgAWAMYAADt1BDpzBFiJKb7ZpGaVOTx2A8HcqbfVm3ShSjt0BDp1BDx3Bb/apYe7
V7DSkIOtWzt0A8Dbpr/apL7ao7zZoXu0RXy0R6bMgo23Zz12CbzZoH+2Sn61SX21R3qzRHiy
QnaxPnOvOnCuNpjFb5e/cUV8ELnXnHiyQXaxP3WwPXCtNm2sMmqqLWaoKIm8WJ3FeEuBGLXV
l2+tNGGlIWanJ2urLWutLmqtK2irJ2SpIl+lHJ/GeFaKIjt1A6jNhU+aB06aBk+cBlKhCFWl
CViqDF6uEmCvFWGtFl2qE3e2Op3HdVWLIjt2BKPLflSjCFipClyvDF6zDWC2Dl+0DYTER5zK
cEqDFjt3A1eoClywDGG3DmW9EGfBEWnCE5XTWZjJZ0R9D6TLfqbPf6nUgazYgq/cg2nDEXPM
GqPfaY7DWj53CTlzBD13Ba7bg3HGH6fecn+0SqbWdmufOjhwBKTPelqNKTNmAk6DHi9dAzdu
A////////////////////////yH5BAEKAH8ALAAAAAAWABYAAAfGgH+Cg4SFhoeIiYgAio0B
Ao2JAQMEBZGGAQYHCAmNCgGgoAsMDQ4PEIoBEasREhMUFRYXGBmSGhsbHB0eHyAhIiMkJYgB
JifHKCkhKissLS4vMIcBMTItMzM0NTY3ODk6Jzs9mD4/QEBBQkNERUZHSElKTJhN50FOT1BR
UlJTVFVXptUDIgRLFi1buHTx8gUMsSZNwogZQ6aMmTNo0qhJtCYUKDZt3LyB0+mSoABk4siZ
Y3JQADp17LR0eQfPzEF5burcKSgQADs=}

image create photo fe_nextbw -data {
R0lGODlhFgAWAOcAAAAAAAEBAQICAgMDAwQEBAUFBQYGBgcHBwgICAkJCQoKCgsLCwwMDA0N
DQ4ODg8PDxAQEBERERISEhMTExQUFBUVFRYWFhcXFxgYGBkZGRoaGhsbGxwcHB0dHR4eHh8f
HyAgICEhISIiIiMjIyQkJCUlJSYmJicnJygoKCkpKSoqKisrKywsLC0tLS4uLi8vLzAwMDEx
MTIyMjMzMzQ0NDU1NTY2Njc3Nzg4ODk5OTo6Ojs7Ozw8PD09PT4+Pj8/P0BAQEFBQUJCQkND
Q0REREVFRUZGRkdHR0hISElJSUpKSktLS0xMTE1NTU5OTk9PT1BQUFFRUVJSUlNTU1RUVFVV
VVZWVldXV1hYWFlZWVpaWltbW1xcXF1dXV5eXl9fX2BgYGFhYWJiYmNjY2RkZGVlZWZmZmdn
Z2hoaGlpaWpqamtra2xsbG1tbW5ubm9vb3BwcHFxcXJycnNzc3R0dHV1dXZ2dnd3d3h4eHl5
eXp6ent7e3x8fH19fX5+fn9/f4CAgIGBgYKCgoODg4SEhIWFhYaGhoeHh4iIiImJiYqKiouL
i4yMjI2NjY6Ojo+Pj5CQkJGRkZKSkpOTk5SUlJWVlZaWlpeXl5iYmJmZmZqampubm5ycnJ2d
nZ6enp+fn6CgoKGhoaKioqOjo6SkpKWlpaampqenp6ioqKmpqaqqqqurq6ysrK2tra6urq+v
r7CwsLGxsbKysrOzs7S0tLW1tba2tre3t7i4uLm5ubq6uru7u7y8vL29vb6+vr+/v8DAwMHB
wcLCwsPDw8TExMXFxcbGxsfHx8jIyMnJycrKysvLy8zMzM3Nzc7Ozs/Pz9DQ0NHR0dLS0tPT
09TU1NXV1dbW1tfX19jY2NnZ2dra2tvb29zc3N3d3d7e3t/f3+Dg4OHh4eLi4uPj4+Tk5OXl
5ebm5ufn5+jo6Onp6erq6uvr6+zs7O3t7e7u7u/v7/Dw8PHx8fLy8vPz8/T09PX19fb29vf3
9/j4+Pn5+fr6+vv7+/z8/P39/f7+/v///yH5BAEKAP8ALAAAAAAWABYAAAjUAP8JHEiwoMGD
CBMivKKwYZU3DRNWWcaHYcSCVZwVS2SloZUqIEFiYQYK2KWOEpupbLZsmTJLl3CFwiJRWaZM
mDBVoiQJkiNXqr4grHKMklFJkSA1WpTIUChYZQ5WIdbIkCBBhRItUoSoECBKsSwSrJJrjhw5
dPDsAUTIUCFBlcIarGLrLB09fwgdSpQI0ShZNOfWlYPHDyFFjyRRkvVKqFRbkHP1CkaMUidg
p7JIDAkyyzBNwTChvPivSrBehKaQHlgFl5wlq1mfKRJ7YJTauHMLDAgAOw==}

image create photo fe_previous -data {
R0lGODlhFgAWAOcAADp0BFSIJTx1Bzp0A2KSNLrWnz93Czt1BHGeRbXUmL/apTx0BH6qVa/R
joS5UrzZoEF7CzpzBD13CIu2Y6TLf3iyQniyQbnXnbzZob7ao7/apMDbpj92CkR7D5S8bJbD
a22sMW+tNHKvOXaxPnqzRH21R361SX+2SrvYn0mAFprDdIe6VWOmI2aoKGqqLW2sMnCtNnOv
OnWwPXaxP7jWmj52CTt1A1SIIJvEdHWxPlqhF16jHGGlIWSnJWmrK2uvLGqwKGevI2uvKXKy
NrTVlT11CDt3A1SKIJrEcVOdDVWeEFSeD1ekD1enC1mrCluuC1ywDFqqC6rThEmCFZXAbE6a
BlKgB1enCV+0DWK4DmS7D2O7D1+zDajUfkJ5DYy5YYa7U1elDFqsC2jBEWvGEmrFEmfBEWO6
D6rXfzx1CDx2B4GwU5TGY2GxFGC2Dq7dgLLhhLXmhrTlha/dg63Zgjx2CDpyA3WmRZ3Ob2m5
HK3bgEF9CTtzBDduA2aYNqHQdazYgTNlAleLJaPOeS1ZA0yBGzx0Bv//////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
/////////////////////////////////yH5BAEKAP8ALAAAAAAWABYAAAjgAP8JHEiwoMGD
CBMq/AdgYcIAAhwaHECggAGJBA8gSKDgIsZ/Cxg0cPAAQoSTJw8klDCBQgULFzBk0LChJgeE
HTx8ABFCxIgKJEqYOIHipsEUKlawaOHiBYwYMmZYsECjhkEbOHLo2MGjh48fQIIEETKESBGD
RpDASKJkCZMmTp5AgfIkipSzBgFQIVHFypUnWLJo2ZKFSxe8Br18ARNGDBYtY8iUMXMGTZqE
atawaePmDZw4cuDMoVNHoZ07ePLo2YPyJJ+Fffz8AVT6o8BAggbVtv2PUCFDvAn2CU7cdkAA
Ow==}

image create photo fe_previousbw -data {
R0lGODlhFgAWAOcAAAAAAAEBAQICAgMDAwQEBAUFBQYGBgcHBwgICAkJCQoKCgsLCwwMDA0N
DQ4ODg8PDxAQEBERERISEhMTExQUFBUVFRYWFhcXFxgYGBkZGRoaGhsbGxwcHB0dHR4eHh8f
HyAgICEhISIiIiMjIyQkJCUlJSYmJicnJygoKCkpKSoqKisrKywsLC0tLS4uLi8vLzAwMDEx
MTIyMjMzMzQ0NDU1NTY2Njc3Nzg4ODk5OTo6Ojs7Ozw8PD09PT4+Pj8/P0BAQEFBQUJCQkND
Q0REREVFRUZGRkdHR0hISElJSUpKSktLS0xMTE1NTU5OTk9PT1BQUFFRUVJSUlNTU1RUVFVV
VVZWVldXV1hYWFlZWVpaWltbW1xcXF1dXV5eXl9fX2BgYGFhYWJiYmNjY2RkZGVlZWZmZmdn
Z2hoaGlpaWpqamtra2xsbG1tbW5ubm9vb3BwcHFxcXJycnNzc3R0dHV1dXZ2dnd3d3h4eHl5
eXp6ent7e3x8fH19fX5+fn9/f4CAgIGBgYKCgoODg4SEhIWFhYaGhoeHh4iIiImJiYqKiouL
i4yMjI2NjY6Ojo+Pj5CQkJGRkZKSkpOTk5SUlJWVlZaWlpeXl5iYmJmZmZqampubm5ycnJ2d
nZ6enp+fn6CgoKGhoaKioqOjo6SkpKWlpaampqenp6ioqKmpqaqqqqurq6ysrK2tra6urq+v
r7CwsLGxsbKysrOzs7S0tLW1tba2tre3t7i4uLm5ubq6uru7u7y8vL29vb6+vr+/v8DAwMHB
wcLCwsPDw8TExMXFxcbGxsfHx8jIyMnJycrKysvLy8zMzM3Nzc7Ozs/Pz9DQ0NHR0dLS0tPT
09TU1NXV1dbW1tfX19jY2NnZ2dra2tvb29zc3N3d3d7e3t/f3+Dg4OHh4eLi4uPj4+Tk5OXl
5ebm5ufn5+jo6Onp6erq6uvr6+zs7O3t7e7u7u/v7/Dw8PHx8fLy8vPz8/T09PX19fb29vf3
9/j4+Pn5+fr6+vv7+/z8/P39/f7+/v///yH5BAEKAP8ALAAAAAAWABYAAAjXAP8JHEiwoMGD
CBMq/GdlYcI2VxwatJLnmBaJBK8YIsbsIkaGk351UtalikmTERFm+WSLEqVjypYta0YzC0Iv
p1YtavRIEqVKmDBlSmbT4BhXnwYZSrQTUiSflIwVzehKEp8/ggglYsRIkaJFkYhhMYjFVSM7
ePDw6QNoECFCgwD5GjsxVSU5d/oMQrSz0aJDvega5BLqE59AiBpJsmRJUqNfKQ9iucTqUCJi
yJgtQ1ZMmOCDVBjRejTMy8mTC6P4uRXsM8YlcG65xiikTOSPA6Pg3s1bYEAAOw==}

image create photo fe_up -data {
R0lGODlhFgAWAOcAADx2Azx2BFWLIlWNIjx1A0uBGJzFdZrFckuDF0V8EJzDdnKvOm+tNZbB
bUR7Dz52CZa/cIW5UlqhGFaeEXmzQ467ZD14CIy2ZZTCaWOmI16jHFmgFlSdDoO4UIKyVTt1
Azp2BIKsWaLKfWysMWaoKGGlIVyiGlSeD0+bCI2+X3anSDt2BHShSa3RjXexQG+tNGusLWir
J2GoHFOhCVGgB1ahDpXDamiaOWSUN7XVmIS4UXm1QXe1O3O0NG6zLFyqEVeoClenCVamCV6o
F5zIcluOKViKKLvXoL/bpb7bo73coH27QXm8OmWzGVywDFyvDKrVganTgKjRgKDLeU+FHzt1
BDpzBD14BcDeooLBRXK7KmC2DmG4DmK4DmG3DqzZgj55BcLhpYfHSma6FGW9EGe/EGfAEWa/
EK/cg8TjpnzDOGnDEWvHEmzIE2vGErDfhMbkqXTBKW/MFHHQFW3KE7HghGy9Hma+EGrEEm3J
E27LFGzHE7HfhMXjqa/aha7bg7Deg6/dg///////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
/////////////////////////////////yH5BAEKAP8ALAAAAAAWABYAAAjWAP8JHEiwoMGD
CBMqXMiw4UEAARwWLGDgAAGJAhMoWMCggQOJDyBEkDCBQgULDQFcwJBBwwYOHTx8WAgihIgR
JEqYOIEihYoVCQGwaOHiBYwYMmbQqGHjxsWDOHLo2MGjh48fQIIIGUKkyEEjR5AkUbKESRMn
Tp5AiSJlCpWCVazIvYIli5YtXLp4+QJGrhUQCK2EETOGTBkzZ9BYYWgljRoya9i0cfNm8UIr
cOKccSNnDp06lhVitnMHTx49e/iETmilj58/gPjU4RNodWC/uOVi3L07IAA7}

image create photo fe_upbw -data {
R0lGODlhFgAWAOcAAAAAAAEBAQICAgMDAwQEBAUFBQYGBgcHBwgICAkJCQoKCgsLCwwMDA0N
DQ4ODg8PDxAQEBERERISEhMTExQUFBUVFRYWFhcXFxgYGBkZGRoaGhsbGxwcHB0dHR4eHh8f
HyAgICEhISIiIiMjIyQkJCUlJSYmJicnJygoKCkpKSoqKisrKywsLC0tLS4uLi8vLzAwMDEx
MTIyMjMzMzQ0NDU1NTY2Njc3Nzg4ODk5OTo6Ojs7Ozw8PD09PT4+Pj8/P0BAQEFBQUJCQkND
Q0REREVFRUZGRkdHR0hISElJSUpKSktLS0xMTE1NTU5OTk9PT1BQUFFRUVJSUlNTU1RUVFVV
VVZWVldXV1hYWFlZWVpaWltbW1xcXF1dXV5eXl9fX2BgYGFhYWJiYmNjY2RkZGVlZWZmZmdn
Z2hoaGlpaWpqamtra2xsbG1tbW5ubm9vb3BwcHFxcXJycnNzc3R0dHV1dXZ2dnd3d3h4eHl5
eXp6ent7e3x8fH19fX5+fn9/f4CAgIGBgYKCgoODg4SEhIWFhYaGhoeHh4iIiImJiYqKiouL
i4yMjI2NjY6Ojo+Pj5CQkJGRkZKSkpOTk5SUlJWVlZaWlpeXl5iYmJmZmZqampubm5ycnJ2d
nZ6enp+fn6CgoKGhoaKioqOjo6SkpKWlpaampqenp6ioqKmpqaqqqqurq6ysrK2tra6urq+v
r7CwsLGxsbKysrOzs7S0tLW1tba2tre3t7i4uLm5ubq6uru7u7y8vL29vb6+vr+/v8DAwMHB
wcLCwsPDw8TExMXFxcbGxsfHx8jIyMnJycrKysvLy8zMzM3Nzc7Ozs/Pz9DQ0NHR0dLS0tPT
09TU1NXV1dbW1tfX19jY2NnZ2dra2tvb29zc3N3d3d7e3t/f3+Dg4OHh4eLi4uPj4+Tk5OXl
5ebm5ufn5+jo6Onp6erq6uvr6+zs7O3t7e7u7u/v7/Dw8PHx8fLy8vPz8/T09PX19fb29vf3
9/j4+Pn5+fr6+vv7+/z8/P39/f7+/v///yH5BAEKAP8ALAAAAAAWABYAAAjPAP8JHEiwoMGD
CBMqXMiw4cErWBwWLPPK1RWJAr+4etRIlReJWVR54oOn0qgsDa+AUjXoz547nDJdVHjFUq1F
hgT5wUOHVKOZDxP5mtRIEaJBeO7oWQUIaME9xDpZoiTpUSA/ffgEijXnIBxkzMJqyqSIkFlf
vXbVSlPwSpW3WZyBqpRo0SJFwbS8reKUYJVophw9iiQpErEqDKtI8/SI0iVMlowhXliFWqZI
ljZ5ynRsssLKkyBVyqTpUufE04YNM3asdTHPCffK3ouxdu2AADs=}

image create photo fe_gohome -data {
R0lGODlhFgAWAMYAAKQAAPR1deU5OeInJ+xGRvFMTPBRUfJVVeAmJvNbW/JeXntMSohaWN4m
JvNkZJldW4SFgpubmsCKitwmJvRsbPRmZp11c4+Qjbi5uMLCwbq6ucShodwlJfNjY6ONi5+g
nr+/vt7e3d3d3dfX18m1tZwICKefnaOjotra2urq6unp6efn59zQ0IQiIaGgnqKjodjY2Obm
5uTk5OPj4+Le3tvc21VXU3d4enZ5fXV1dXV2dvPz8+7u7n6Ae3+BfICCfeXl5XZ5fHmZw3eY
wnV4fPLy8u3t7YSGgYWHguLi4nV4e1+Gt0p2rnJ1evHx8ezs7IaIg4qIZYmIcODg4HF4gTRl
pG52gfDw8Ovr64eJhIiJfvn5+bGztri8wbq7vLm9waSkpO/v74iKhd7e3qKioqOjo2VnY5eZ
lJiZlpmalpmal/j4+P//////////////////////////////////////////////////////
/////////////////////////yH5BAEKAH8ALAAAAAAWABYAAAf+gH+Cg4QAAISIiYUBAYeK
j38AjIyOkIsCjAONloOSBAWZmpWPkgYHjZIIopCSCQqNCwySDauJkg4OjQ8QERKSE7WdARQV
jRYXGBkaG5IcwZEBHY0eHyAhISIjJCUBHJvCjSYnKCnlKiorLNzfgpItLi8wMSv0MTIyMzTc
o5E1Nv//0N3AkQOHjh38/tjgYaOHjx8/YgAJIiTHECJFbCSyYcTGkY9IZCRRsiQHkyZONCKy
8cQGFChRpCSZQqVKjipWrqgkZAOLjSxZtPiYsoVLFy9fwITZOchGChtioooZs4VMmatlRDAV
ZOOKmTNo0qjZwaOs2TVbFQJcyxYgp7cEcDkFAgA7}

image create photo fe_gohomebw -data {
R0lGODlhFgAWAOcAAAAAAAEBAQICAgMDAwQEBAUFBQYGBgcHBwgICAkJCQoKCgsLCwwMDA0N
DQ4ODg8PDxAQEBERERISEhMTExQUFBUVFRYWFhcXFxgYGBkZGRoaGhsbGxwcHB0dHR4eHh8f
HyAgICEhISIiIiMjIyQkJCUlJSYmJicnJygoKCkpKSoqKisrKywsLC0tLS4uLi8vLzAwMDEx
MTIyMjMzMzQ0NDU1NTY2Njc3Nzg4ODk5OTo6Ojs7Ozw8PD09PT4+Pj8/P0BAQEFBQUJCQkND
Q0REREVFRUZGRkdHR0hISElJSUpKSktLS0xMTE1NTU5OTk9PT1BQUFFRUVJSUlNTU1RUVFVV
VVZWVldXV1hYWFlZWVpaWltbW1xcXF1dXV5eXl9fX2BgYGFhYWJiYmNjY2RkZGVlZWZmZmdn
Z2hoaGlpaWpqamtra2xsbG1tbW5ubm9vb3BwcHFxcXJycnNzc3R0dHV1dXZ2dnd3d3h4eHl5
eXp6ent7e3x8fH19fX5+fn9/f4CAgIGBgYKCgoODg4SEhIWFhYaGhoeHh4iIiImJiYqKiouL
i4yMjI2NjY6Ojo+Pj5CQkJGRkZKSkpOTk5SUlJWVlZaWlpeXl5iYmJmZmZqampubm5ycnJ2d
nZ6enp+fn6CgoKGhoaKioqOjo6SkpKWlpaampqenp6ioqKmpqaqqqqurq6ysrK2tra6urq+v
r7CwsLGxsbKysrOzs7S0tLW1tba2tre3t7i4uLm5ubq6uru7u7y8vL29vb6+vr+/v8DAwMHB
wcLCwsPDw8TExMXFxcbGxsfHx8jIyMnJycrKysvLy8zMzM3Nzc7Ozs/Pz9DQ0NHR0dLS0tPT
09TU1NXV1dbW1tfX19jY2NnZ2dra2tvb29zc3N3d3d7e3t/f3+Dg4OHh4eLi4uPj4+Tk5OXl
5ebm5ufn5+jo6Onp6erq6uvr6+zs7O3t7e7u7u/v7/Dw8PHx8fLy8vPz8/T09PX19fb29vf3
9/j4+Pn5+fr6+vv7+/z8/P39/f7+/v///yH5BAEKAP8ALAAAAAAWABYAAAj+AP8JHEgwRgyC
CBMW3LTpoMKH/2IwZOgQ4kI2DL80tDhQ4p0+GTVWfCgREKGGEruIhCgRkaKGWc6kXJlQoiNH
Dd0Q0qRJIheaHTdRgtQQ0CNcwXKtkrgFaMRNOGNM+uSrm9Vru2hs2rIxaMNQorSpG5su3blp
WrsKlPgDlChs5s7JNUeO3LhvWkdG3Falb1+zd/DUETxP778q7qr4+QMIkLlyeCjVkXRHXpWE
VdpVIcS5EDlxd/7UcUMn3mWEVdhVMWSIUCFx4Ox0qdOFDrzTBKusq3Ko9x9w+WTt0sWL1Dvc
A6uoq4KoOSJv+USNmj6qG3KBVeCVuYQpU6Z57sIPi8d3/bDf8+j9clzPnmNAADs=}

image create photo fe_reload -data {
R0lGODlhFgAWAOcAADtqqDtrqDdnpTVmpThopjpqpzdopjpqqHeaxaC726zG4q7I46jC3p25
2X6hyk16sDZnpTdnpjRlpFqDt7fN5bDI4qC82q3G4bfN5rrP5rvR57vQ57vR6K/H4W+VwThp
pnOYxUZ0rkVyrJ+52Ux4sDlppjdmpU56sYWmzbbN5bXM5abC4LHK5KO/3X+iy8PW6kNxrDtq
p1N+sz5tq0BvqzZnpDpppzprqH+kzLHJ45a325G02bTM5cja7EBuqjtrpzVlpE56tGKNw0x4
r6fA3a/J43Sfz83d7j1sqD9uq2yWyjpqqT5tqbTJ4pS22nKfz9Xi8DdopabA3cna7M3d7dTi
8Nzn8zZnpjRlpTlppzhopzZmpTVlpdrl8eDp8+Dp9OHq9Nnk8FV+szVmpOLr9aC+3qG+3dvm
8n+gx0FwrOPs9Zu63L3S6Nzm8lB8smWOxEd2sDxsqDRmpOTs9crb7K7I4sHV6oKjyzdopz5u
qz1sqUd0ruXt9sDS5tjj8dHf7qrG4sDU6bjN5YSkzGqQv1B7sj1rqEBuqVeBtZOy1sXV6Dlo
pjtppoelysjY6bDJ5LPK5KrE4Zq42j9vqURxqjxpo2qOvJSx07LJ4rbN5qK+3XKXwy9ZjzNl
pDFbkTZlojZno0FuqDdnpDZmpDRfl///////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
/////////////////////////////////yH5BAEKAP8ALAAAAAAWABYAAAj+AP8JHEiwoMGD
CBMWBBBAwAACBQwYHGCwwAEECRQsYNDAwQMIAyNIKFhgAoUKFi5gyKBhA4cOHj5EABGioIgR
JCKUMAHhBIoUKlawaOHiBQyCMWTEmEGjxkAbN3Dk0LGDRw8fBH8ACSLEhsEPQ4gUMXIECUEb
SZT8W3KQSRMnT6B4HShAYRQpU6hUsXJFIUEsEm5k0WLgChaCA7YoXszF78ABXbx8ARNGjMIx
BIGQKWPmDBqJBW8ITAMAsZo1bNq4yWLQwBs4EuIQlDOHTh07Vu7gASlwQB49MPYUlMOnj58/
gAIJGkSokKFDiFwkIlAQgqJFjBo5osBDxSMWkBYmRJI0yeAYSgMrWbqEiU2mHJo2leBksJNB
T59AhRI1ipTj/wD6FRAAOw==}

image create photo fe_folder_new -data {
R0lGODlhEAAQAMYAAG1va2dpZc7OzsrEuW1pXvyxPsDAv5aXlZuYkOOrVb6cZODCkfvSkNyy
bMuYSfywPsnJyaamptm5hv3nw/765/740f3urPzJZvuyQGF6mjRlpDtnoFJwlNvFnv766P77
5P32u/3xkfzkddSsW2R4jMbY677S6MjMy+64Y/zTk/740/32vP3zo/zue/zoYPq+SNCgVK7H
44yx2I+w05yxwebFif3vrv3xkvzufPzrYfzfUe2+YV9hXdCyfvzLavzld/zoYfzgUfvDRNu6
gVVXU5OwzeGwYs2yf+a7Zvq9SeW6YNCxeem1ZT5onpWwy5Gw0J2xwOOxX7PF2ERrm4+x0p6x
vomu1qbC4Dlnoq3H44uw14qv14iu1oWr1YCo03qk0nOgz26dzpi53Fh2m5u73XCeznCdz26c
zm2czmybzmubzWqazmmZzWiZzZS226mrqYmv12uazWqazWiYzWaYzGWYzWWXzGSWzGOVzJq6
3lNxlkVdeT5giT9ghv///////yH5BAEKAH8ALAAAAAAQABAAAAfNgH8Ag4MBAX+IiYgAAo2O
AwSIBYoABgeXlwgJCgsMDQ4PghARpKUSExQVFhcYfwEGGRqyGxwdHh8gISIjJAEQGiUmJico
KSorLC0uLzCvGjEyMjM0NTY3ODk6Oxw8v9DRMj0+P0BBQkMaRAbP4EVGR0hJSktMTUTe4E5P
MlBRNDJSpqhjBy4alSozrFxJBwFLFi0ytGzh0sXLFzBhxKQzMIZMGTNhzqBJo2YNmzZu0r2B
oyaOHDZz6NSxcwdPHj17+MjayZNnH0VAgyIKBAA7}

image create photo fe_configure -data {
R0lGODlhFgAWAMYAAH9/f+rp6Pn5+NjY1/j39vPy8YKXsjRlpOzq6P///050pHx8fLu7u+3r
6szMzK+vr2WErOjn5Orq6q2trePj4vr6+Xl4dNzc3JmZmejn5vLx7+3r6evp5/r6+oeHh8/N
yvj49/n59/n49/7+/p6enrW1tfb29Z+fnvj4+Ofm5LvByEVxqfT09J2wyt/f31l9q6enpiBK
h1R8rqSttvv7+3WQrqS60JCmvqexvcHBwePi4dPf6qKuvJ22zmN7lYScttfi7Y2YpZ240mB3
kZmtw9/n8IGTqVhthFtxiYaGhqG0yO7z9mB2j+Tj4V9fXpGmvvD095eltgAAALDG2+3y9oGK
lWyFocDR4v//////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
/////////////////////////yH5BAEKAH8ALAAAAAAWABYAAAfygH+CggAAg4eIiX8AAQID
hoqRhAQFj5EGB5EACAKQiAcJCpl/C4WCDA2diaAODxCEERIAExQIFRarFw+jfxgZGhsIHMOq
gwcdB7yCHh8gAiECwyKQByPKhySFACUCwiYnByjXkgACKSorLOOSiy0HLi8w7Icx9QcsMjM0
npIxNTY3YhzAkUPHCH6J/O3g0cNHDAAjhh2MFOMHkCA+hAyJsWiEsImIYhApYuSIkBpIOHaU
mISekiVGmJxMeQhiEycgYzyBEkUmSpWCpAgdKvRPjClUqswEGpToUKNWhFx5QjORUymDYlix
4lAS0ZD15hUVFAgAOw==}

image create photo fe_folder -data {
R0lGODlhEAAQAKUAAG1va2dpZc7OzsbGxWNlYcDAv5aXlVVXU8nJyaampqenp6ioqGF6mjRl
pEZtnMbY677S6K7H44yx2F9hXYmu1qbC4Dlnoq3H44uw14qv14iu1oWr1YCo03qk0nOgz26d
zpi53Fh2m5u73XCeznCdz26czm2czmybzmubzWqazmmZzWiZzZS226mrqYmv12uazWqazWiY
zWaYzGWYzWWXzGSWzGOVzJq63lNxlkVdeT5giT9ghv///////////////yH5BAEKAD8ALAAA
AAAQABAAAAaGwB9gOAwEfsgkEiBoOgcEZRJQMFivhoNWu0QkvmCwYnFABgqMhnrNVjsCiMYD
Qq/bH41zIyLp+/8RDRNxfH+GgQcFe4aHDQeEjICOioWRFBWOCBYXGBIYGRobHB0eHyCTISIj
JB8lJicoKSorLI4tLigvMCoxMjM0NTY3ODk6bcdqO1LLy0EAOw==}

image create photo fe_file -data {
R0lGODlhEAAQAIQAAJmZmYGBgf///+zs7Orq6uvr6+3t7fDw8MTExMXFxcbGxsfHx+7u7u3t
5e3t5u/v78jIyPHx8fLy8pWVlf//////////////////////////////////////////////
/yH5BAEKAB8ALAAAAAAQABAAAAVuIBCMZDl+aCCsbLsGqTAQRGEPg3EI8KcSiERCQVQsdr3f
DWcwMJCxwrBIPPKiBaahMXhefYIClcFweJOynJPxaEPBg+JiAam/VTmyO8L/qgxGdHV8En4C
TWwPBwcREoVoLpE9EyaVARMomZqbmiEAOw==}

# Images for ttk::chooseDirectory

image create photo fe_dirclose -data {
R0lGODlhCQAJAKUAAFRWUlVXU1pcWP///1lbV2BiXt/i3Obo5O3u6/P08vj4911fW2NlYeHk
3+bp5Ovt6u/x7vDx72ZoZAAAAGNmYWpsZ93g2t7h2+Di3WdpZG1vatjb1dfb1Njb1Nfb09XZ
0WpsaHBybW1wa3N1cP//////////////////////////////////////////////////////
/////////////////////////////////////////////////////////yH5BAEKAD8ALAAA
AAAJAAkAAAY4QEBgSBwKBsjkgFAYGA6IhGKwYAwajgckMihIBpNweECpDCwXDOYyyGgGG07H
8xmAQsqkaMTv94MAOw==}

image create photo fe_diropen -data {
R0lGODlhCQAJAKUAAFRWUlVXU1pcWP///1lbV2BiXt/i3Obo5AAAAPP08vj4911fW2NlYeHk
3+bp5O/x7vDx72ZoZGNmYWpsZ93g2t7h2+Di3WdpZG1vatjb1dfb1Nfb09XZ0WpsaHBybW1w
a3N1cP//////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////yH5BAEKAD8ALAAA
AAAJAAkAAAY4QEBgSBwKBsjkgFAYGA6IhGKwYAwaDsQDMihEBohweCCZDCgVhKUyuGAGGQ1i
wxl0PMrkB8Tv94MAOw==}
##############End Image fsdialog#################################

  image create photo fe_upArrow -data {
    R0lGODlhDgAOAJEAANnZ2YCAgPz8/P///yH5BAEAAAAALAAAAAAOAA4AAAImhI+
  py+1LIsJHiBAh+BgmiEAJQITgW6DgUQIAECH4JN8IPqYuNxUAOw==}
  image create photo fe_downArrow -data {
    R0lGODlhDgAOAJEAANnZ2YCAgPz8/P///yH5BAEAAAAALAAAAAAOAA4AAAInhI+
  py+1I4ocQ/IgDEYIPgYJICUCE4F+YIBolEoKPEJKZmVJK6ZACADs=}

  image create photo fe_ru_24x16 -data {
    R0lGODlhGAAQAIQSAAA4pdUrHqkycnd/uHeAuHiBuXqCutt5edt6eb2Bmtx7et1+fd6Afs3Q49XX5vz8/P39/f7+/v//////////////////////////////////////
    /////////////////yH+EUNyZWF0ZWQgd2l0aCBHSU1QACH5BAEKAB8ALAAAAAAYABAAAAVGoCSOZGmK0amq0OqS6ftCT23feG43fO//wB5gSCwaj8MBcrlUMp9EAnQ6
    EFiv2KzWmgh4v+Cw2HsYm82LsxpcXq/TbjUiBAA7
  }
  image create photo fe_usa_24x16 -data {
    R0lGODlhGAAQAMZ5ADk6azo6azo6bDo7bDs7bDs7bTs8bjw8bD4+b2A2ZLMhNLMhNbIjNmI5Z0RFckVFckZGdEdGcrIrPEdIckdIdLIsPEhJdElKdElKdUlKdkpLdkxM
    dUxNd01OeE5PeE9Qd1BQdlBRd1FRd1FSem1McFJUempPc1ZXe1hYfFhafV9fgF5ggWBhgWFhgWFigWRjhGRkhGVlhWZmhWtsiW1tinlrhXBviXhth3FyjntwiXN0jXp5
    kn16kHt8lH19lIOEmIWFmIeHmoiJnImJnIqKnouLn4uMn4yMn4yMoIyNoY2NnsV+g42NoI2NocZ+g8R/g42OoI2Oo4+PoI+PoY+QoZCQopCRoZGRo5GRpZOSppKTpJKT
    pZSUppSVpZWVp5aWqJaWqZaXqJiZp5mZq5maq5qbq5qbrJycrZydrp2drZ2erp2er56fsKCgstOorNGqrN/LzOPLzeTLzeXMzenR1Ojn6enn6fDn5/Hn5///////////
    /////////////////yH+OUNSRUFUT1I6IGdkLWpwZWcgdjEuMCAodXNpbmcgSUpHIEpQRUcgdjgwKSwgcXVhbGl0eSA9IDcwCgAsAAAAABgAEAAAB6GAJzMtJTQsLh87
    JBIVjY6Pjic+PkQ6P0BBOmJ0nJ2enjA+OzY9OD4zRkNwq6ytrRA2OkMzOzg/MzVOS7u8vbwvOzsyPjo7MT9teMrLzMwXsUEyPZY0ub7XuynFNrE6ODtic3Hj5OXkCDIu
    6TMrKjNAbm/y8/TzrG/3q277/P39casABoRjrmA5bAgTNlvIcGHCh75cSZwo0aDFi5AyaswYCAA7
  }

  image create photo fe_eye_hidden -data {
R0lGODlhFgAWAKUlADZATVJbZlpxkVlykn+l2IOt5YOu5YOu55Gx2qOwwoq174u3
8JvB8qnB4arC4avC4bfL5cjPvsjQv9XUu+DawcHh79Pf7sHl+NXg7tXg78Lm+sHn
/sLn/cLo/+ft9u3y+ff17fj27vT3+vX3+/z69v//////////////////////////
////////////////////////////////////////////////////////////////
/////////////////yH+EUNyZWF0ZWQgd2l0aCBHSU1QACwAAAAAFgAWAAAG1kCO
cEgsGo/IpHLZaTo7HI10ynlan5eKhMKlSCqX63OjxXgsEAgG5K1sxJoKBYR5MBie
0ejDrmisGhAUIR4OCgcIHiUjFh4hXn9NGhYYJCIVBwYEAwkQFQwVIyQYFlUcciQl
Hg0HBAEAAAIECg2KoxVRESAlJRkMCgSwsLMMGbwgEhqnFKmrra8AAQQHtSUkFLgd
k5WXmZsDBAYGodfZkluErAoFBYe1j8mAcnR2CwsMD2vYkVdaFGdpGrURg0XLBC4T
voQh+CTKFClVriyZSLGixYtHggAAOw==
  }
  image create photo eye_nohidden -data {
R0lGODlhFgAWAMZpAP4AAP8AAP4BAv0DBP4DBI0kLIMnL5UiKYslLP4GB/8GBv0IB/4JCvwLCvwNDvsQEvoRE/kWGPkXGfgbHvYhJPYiJfQrMPMsMVJbZvMuM5hHWvMv
NPE1O/E3PPA6P+8+RO4/RcFQaO1GTexHTsRTb1lykrxXcvRMQ9NUaepPV/NUSvZdYPVmasJ0gLF4nsSInn+l2IOt5YOu5YOu55Gx2oq07oq17+ihjou38OenlM+wv5vB
8s23xqnB4arC4avC4c67zf+ysszA0s3A0/i1uMvF2LfL5cvG2cjPvsnM38jQv8jQ5MjR5dXUu8fW6sbZ7sXb8cLd6sLe7MXe9ODawcHg7sHh78Th99Pf7sPj+sHl+NXg
7tXg78Lm+sHn/sLn/cLo/+ft9vjz6/j07Pf17fj27vT3+vX3+/z69v//////////////////////////////////////////////////////////////////////////
/////////////////yH+EUNyZWF0ZWQgd2l0aCBHSU1QACH5BAEKAH8ALAAAAAAWABYAAAf+gF+Cg4SFhEsWHoaLhUkUARyMkkUTARtOYJmaYF9dnp9fYEMRAR1Qm5pa
VkpUrVRKVjwPASBTqGBeq1thWEZGW2Q5DQEjV7ddVlRkWz87O2FnRAwBJ1FdqF1GVGVhPjYzNGFBCgErYq/XmV1YW2hmVjMyMCUtBAEoVWdoW1ihX8lo0oTpMQMGBgMA
AoSo0SNMmn1WOiEhkyYNlx02YBQIEOAADBs7uFQko6TLPyoBB84wwREBBhgzGj6kEhHMunZmqpAIIEBDCRgyZFjRRzOUOlZjWAQY4CJGjG8Ny6DDJkVFgAQvduDAseMH
MJrpNmVJEWDBDV6+sIR5ZeUWmCsxIgI40LGqSasmsLS4nfIhAAQgnD6BcvuEQwAJQiQxyhBgwhHFjAJUSAKZ0QUmlRkFAgA7
  }

  image create photo fe_icontools -data {
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

  image create photo fe_icondirdenied_OLD -data {
    R0lGODlhEAAQAMZiAAAAAMYBAv0AAvcFB/sEB/wEBfwEBvkFCfwIDfoQEvgWGPgeIPkkJFhYWM04OPwvIvtxPI2NjJKSkJKSkeN+fZWVk5WVlJmZmZqampubm52dnZ2d
    nqCgoKKioaKioqSkpKWlpKioqKmpqKurq62trLCwsbGxsrKysrOzs7W1tLa2t/+oWLm5uru7u7y8vL29vcDAv8HBwcLCw8PDwsjDwsXFxfq3tvu3tvu4t/u4uMfHxsnJ
    ycrKy8vLzM3Nzc3Nzs/P0NDQ0dPT1NTU1NXV1vzKyv3Ly9fX2NfX2dra29vb293d3t7e397e4N/f3//cqOHh4OLi4efn5+fn6Ofn6ejo6e3t7e7u7u7u8O/v8PHx8vLy
    8PT09PX19ff3+Pz8+vz8+/39+///////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////yH5BAEKAH8ALAAAAAAQABAAAAeqgH9/AA0AgoeIh4QrTwCGggcECAuKWw0NjI4BApwCCoIAYV9al4wPOUZGOAagYWBeWEuYDzZFRTcFoGBdWVVR
    RA0OnQIJoFxXUlBJQz40FAwDEIpWU05KQj01MS0mACuKVExIQTwzLywoId6KTUdAOzIuKSUjHuugAD86MOgkIh8Z7ikCoOLECBAdNFgQiMgRhw0YLkhgmMjRhAoTVzhK
    1BBABG8bOXbcGAgAOw==
  }
  image create photo fe_icondirdenied -data {
iVBORw0KGgoAAAANSUhEUgAAABQAAAARCAYAAADdRIy+AAABi2lDQ1BHSU1QIGJ1aWx0LWluIHNSR0IAACiRfZE9SMNAHMVfU7UilQ52EOmQoTpZKCriqFUoQoVQK7Tq
YHLpFzRpSFJcHAXXgoMfi1UHF2ddHVwFQfADxNHJSdFFSvxfUmgR68FxP97de9y9A4RGhWlWTxzQdNtMJxNiNrcqBl7RhwhCiEOQmWXMSVIKXcfXPXx8vYvxrO7n/hyD
at5igE8knmWGaRNvEE9v2gbnfeIwK8kq8TnxuEkXJH7kuuLxG+eiywLPDJuZ9DxxmFgsdrDSwaxkasRTxFFV0ylfyHqsct7irFVqrHVP/sJgXl9Z5jrNCJJYxBIkiFBQ
QxkV2IjRqpNiIU37iS7+EdcvkUshVxmMHAuoQoPs+sH/4He3VmFywksKJoDeF8f5GAUCu0Cz7jjfx47TPAH8z8CV3vZXG8DMJ+n1thY9AkLbwMV1W1P2gMsdYPjJkE3Z
lfw0hUIBeD+jb8oBQ7fAwJrXW2sfpw9AhrpK3QAHh8BYkbLXu7y7v7O3f8+0+vsBZvhyovthgiQAAAAJcEhZcwAALiMAAC4jAXilP3YAAAAddEVYdERlc2NyaXB0aW9u
AENyZWF0ZWQgd2l0aCBHSU1QA65fWgAAA11JREFUOI11lL2LnVUQh5+Zc96vvXf33k1MSJYQVIQgokQLm4BpNJBCOy1Ey9joH5Pa0hSCVoaAQSQQEcQPsIoYYgjEwCaS
vdm79/N933NmLK6t00z5Y37Pw8i3N7/zu3fv0vcZMyfGCIC7A87L517g0uVLiCoQUFcEcByjJ3jJqusIdYkA8ftbt7l//wGgmBkqESfj7qgqv/36O29ffhdxI4oiDgAC
BFVYtDRNRe4THoSYsoAUxFhgZuCKeUJFUFWeTluuXv2cdj1lPBwyn82oqwYU+rRiPag4tbvLlQ8/AkvEGCNlWVIU5eZM180WQ1UZH9/jjzt/0q0OiYWisaTtEl1O1HXN
wg1ZzPnk/Y/JKRMlCgTDJOMIovZfh5BJHDzdZ7upKIqCHiNlSKFie+c4i+khp/MApCDNjDhqiEEcxRDPeAZRRURwd5zMcBAgdSCChIpV29E0FWk5p0odT7aVfrVkNQxs
C0R3ARQhbNi5IKJABldyzpQayFlI5uwMR9hyRtOtOX92j8nIeTTJrPyIYFtETFAvUAKOgQPGJsCNLGBELBuhLMjtmjonPnjnLaqjZzx/5yG88TqDgwPYG6JmCcTIOSMi
FEWx0UJAVbG6I7eB5wplQUfnysUL5zlz50vGHOOvN1/j8f49ll9fZ8sMFRFENlTNMin1pNRjvgkKCwih4O88ZdAox4vAqbmz2474YTXj2u2feTbaY3nvFyZ5TZQAGgNu
gqujGlAc0Q2gptzGOoFBwXL6DM8NJ83Ic+FRkVhuDVgeO439dI9Dgdj3mdQboIAgslHGDHLOdNZSEwgtVDtjUqyo9wr2D4RXzo15dXyCSnsGJ19itgzEGGpCKDBz3ASV
SFBB1Mk54wNlvWgZhyGraeK9ixcob37FKD7h7De3+KeekJjji5p84wuiYAgG5lg2Eoa7EwiIO/W6JZclk3ZFrmqWtTLaMR7IkjPLh+xOW5rtksfVDtXEiOvllNQtAMGz
k20jNRZAjHnXUeqcciuSrWXSHRL7OeNim7AVSH1B2UXwx5SuxE8/u8Lh4RFlWeImwKa7EAKizlQiZ1LFZHnAsGrYH0W6H68x8gFH3tM2W/iBcfLEPrMgiG8e3/+PQdJE
RCErC+t5ev0G+IJgEdGMZSVQYS+e5l9h+80+zAmm+gAAAABJRU5ErkJggg==
  }
  image create photo fe_icondir -data {
    iVBORw0KGgoAAAANSUhEUgAAABIAAAAQCAYAAAAbBi9cAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4wYXCDgNebfI9AAAAgZJ
    REFUOMuNkz9PFUEUxX/3zuxbQAlSkGhhaWEwRhNbY6Extmhi7Kz5CH4P/RZY2FnYEG20sKOSaExEBNTn44+P3Tdzr8U8Hw8k4G0mszvn5PzO7MrrO/PcfLXCSfPm3pXr
    9bnwLtQS8SMvFZqttCwAbxeuznY/9BfcCQcnisL3SDPzE4/mF8/f7cxViEp5bg6tE6ciK0/XiADd1f7Da08uPtOACoK7I5WgAFGQCZE4HQ6Fsex4MthLuHkxcqeuJlVj
    LSK1IB1BRJApxRsjnlXcIXrA1BGHrJABQkkYAVK3az64gHcEiQEUpFLUgQ5IE1B1jIRkcBfwDA4SO2AQt148eD59+fYNjb8LvgqFCeRIqYfqc8j9lv7Hl0gUos7N3a8v
    LY6dEP53rPeN9v3SAVqZ3eFWjokwFgMbWw0VGTfKuPdAAhBOSZYYadgGP2S0A/KjiD2AnIDnBmLFUH7hB7dmwAbwtRhJOAZr1ApIGqZNwC4iERgQsQxs4qwNseQELB8Z
    iifE+5AFHCJmwHfUNgDFVE8xy6g5WAJaDMXxv2hdaDYhhvIRov/6+BANIDlYhpRHNUSJWjaxLSVbUbkabo7j5Uc1QV2LLghEJ2TDg2KND+L+6pfl9fWlW4PeLm030/40
    9rcb0p7R9MCahJ6pqCedaiZQz1R0ZiOdWSVMKe3nwafBjj3+A1B95HRZw8dhAAAAAElFTkSuQmCC
  }
  image create photo fe_icondirup -data {
    R0lGODlhEAAQAKUAABJNbwoSHxVUdIGeuhdYeggeMRlKat3v+BOQtBVWeAcXKBtLav38/VnD2jzX4RVaehtPb3HR4Bmzzg6gxUjf6RKQtRNUdgcYKhJMbeLw+Q6Xvxyi
    wxBTdQYQHSA3TwEDBAAAABFHYJ3e7iK60RWavA9dfgABAc3r9hGXuUPV3iKUsQomO/36/SqYswonOyzH1ReOrIDC21isxRSDnwoZKQgcLQccLP//////////////////
    /////////////////yH5BAEKAD8ALAAAAAAQABAAAAZiwJ9wSCwaj8ghIJAkCgaEQvNnGBwQCUVyMWA0HIiH1gjpRiQTSsVyKWIGmYZEo5k4NpzOkOP5gEIiGiMkJSYg
    h0YcJygpKitNHCyMLS6Qiy8wlUkcMTIjMyCQNDU2iFOnqEEAOw==
  }

  image create photo fe_iconfile -data {
    R0lGODlhEAAQAKU7AACFvQCGvQCGvwCHvQCHvwCQyACU0gCU1ACU1wCW1ACW1wCY2ACZ1wCb1QCb3QCc1gCc2ACc2gCd2wCe1gCe2ACg1wCo6ACp7ACu7gCu8ACv7wCv
    8gCw8ACw8zep2Dqp2C+35DG55jO86DO86kPC8nC31HC31nO31Ha31na51nO61nO613O62UHH92682Xa61na62UTH93m62TrR/3nH5oXO7YfY94XZ+Yfb+4rb+4re++/w
    8e/w8e/w8e/w8e/w8SH+SUNvcHlyaWdodCBJTkNPUlMgR21iSCAod3d3Lmljb25leHBlcmllbmNlLmNvbSkgLSBVbmxpY2Vuc2VkIHByZXZpZXcgaW1hZ2UAIfkEAQoA
    PwAsAAAAABAAEAAABo3A369BgRiND6FSSYnpnrEOJbRUTjiZbLYjAlV/kxZu3MpwZiPqMjzGtTgczEIQWGO1nE3EoACsYzmBgTQnMB8DdngWBgcHCYhWYmM2KyYqLB6Q
    Qmw4Ny4lKpeZdhwaEoyNjppggDUnL7AvhqtXF6ipqksUJCkoMri5ShUOBwgICsjIDARLBQAE0NHSQkEAOw==
  }
  image create photo fe_iconfiledenied -data {
    R0lGODlhEAAQAMZNAO0AAPEAAPADA/MSEs8fH/IWFs0uLtgvMOA2NuE3N986ROE9Pp9QYMdMekF52N9ZdOxbXEeD6FCC1VGC1UaE6+5cXkKF9EOG9ESG9EWH9EaI9EeI
    9EiJ9EmJ80mJ9Npmi0qK9J50xkuL9EyL9FGL602M9E6M9E+N9FKP9KN7y9twklaS9FeS9P2Agf+Bgf+CgnWk83al8/+FhXqo832p86mg3OaWloOt856n55K389Wsytas
    yJ6+8qC+8p+/8qC/8te0tO+wt6LD+e2zs6bF+q3H8uC8vOjFxe/IyNbU1OPc3O7o6Pjy8v//////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////yH+EUNyZWF0ZWQgd2l0aCBHSU1QACH5BAEKAH8ALAAAAAAQABAAAAeNgH+Cg4SFhCeIiSw/hoImj5ArRIyGJZaXKEJEPYYjnp8jJBMShiKmp6YR
    DoYgra6uFIYeHjxFtkU8Hh2GOkE7ODfBMxwchRUyLi8tNTQ0MBsbhQABAwUCDz4+ORoahARDTEtKSQcxGecZhAY2SEdGQA0Y8vKFCwgICQohF/z8hQwqIHxIYaGgwUYI
    CQUCADs=
  }
  image create photo fe_addfile -data {
R0lGODlhFgAWAKUwAHS37nK48H256oe4342325K33JK41pa40ni/+Hq/95+5znzB+H/C+IHC+LS6tLe6r4XE+IbF+IjG+IjG+ca7oYrH+Y3J+dW9io/K+ZDK+ZHL+eO+
bfS/NvXANZbN+fbAM/jAM/vAKPrALfvAK/vALZfO+ZjO+aHS+q7Y+7Xc+7fd+7jd+8ro/Mvo/M7q/eH1/v//////////////////////////////////////////////
/////////////////yH+EUNyZWF0ZWQgd2l0aCBHSU1QACH5BAEKAD8ALAAAAAAWABYAAAZ+wJ9wSCwai5mkUqk5IpdKTMrkHEKjLlap+rsmMa5Xy1P1ZsAvMflozqBW
K9XJ2YbS68o7PqPH99sSf1ATFQ0AgkoWAQUHG4hJEAYcHySVRl4YCQMXlZ0kT1cLDiOenURmEwQdpZ+nXggPIaytQmYMAhQipaBXEQognlxVtD9BADs=
}
  image create photo fe_adddir -data {
R0lGODlhFgAWAMZeAAqERACIRQqFRQuJRwyJSAyKSAWNSQCRSgqOSw+OSwWSTQiSTRKSTwKXUgaWUCeNSAuWURSXUxacVhecVhecVziUWxKgWRigWhqgWjiYThakXByk
XS+fVRulXhylXh2lXkKaYhaqYR6pYTuhZEGiZ0SjaDGsXkKmajSsX1CqWtGPAF6qec6RHc6SH9uYAJWoSYivVNWcJ9mcHYm0VuWhAN7BRe3CNuDFRuDFSezDO+7FPP3E
LOzHSv7FLf7GMO7JSu/JSf7HMf7INfrJOv7KOffLV/7LPv7MQ/rNSPzNSP7OR/nOXP/PTP/RUMXZzP/SVf7TXP/TWcbbzP/UXf/VXv/WYv/WZv/XZ9vo39vq4PD08fD1
8vH18v3+/f//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////yH+EUNyZWF0ZWQgd2l0aCBHSU1QACH5BAEKAH8ALAAAAAAWABYAAAfhgH+Cg4SFhoeIiYqLgjSOj46Mfy6UlZaMKpmamjJLV5+gV1aDLC2mpy0x
RVWsra6CUFSys7JTtre4U4JRvL2+v7+CT8PExcbGgk3Ky8zNzYJM0dLT1NSCStjZ2tpIPzxASUqCR+Tl5uU4MBwNGS81gkbx8vPxNykXExAMCA+CRP8AAxIZMqMDBhJY
FCQgIOCPkIcQIwrRgcLDiRVbQFQYAOCPjyAgQ4rMEUJDFi5dtDgJ0PHPjh4wY8a0YeKDhRJaDhgg0HKRiA8YRkhZsFCSoA0YJDhgkKCAUUEYKERgMCgQADs=
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
  set ::typetlf 0
  if {$::scrwidth < $::scrheight} {
    ttk::style configure TCombobox -arrowsize [expr 5 * $::px2mm]
    set ::typetlf 1
  } else {
    #Конфигурирование виджета под смартфон
    #Ширина 75 mm
    set ::scrwidth [expr {int(75 * $px2mm)}]
    #Высота 160 mm
    set ::scrheight [expr int(160 * $px2mm)]
  }
  set upz 1
  if { $::px2mm > 15} {
    set upz 4
  } elseif { $::px2mm > 10} {
    set upz 3
  } elseif { $::px2mm > 5} {
    set upz 2
  }
#Масштабируем иконки с учетом разрешения
  if {$upz > 1} {
    foreach nn [image names] {
	if {[string range $nn 0 2] == "fe_"} {
	    scaleImage $nn $upz
	}
    }
  }

  set ha [image height fe_iconfile]
  #Высота строк в treeview
  ttk::style configure Treeview  -rowheight [expr $ha + 2]

  proc filedel {w file typefb} {
    set answer [tk_messageBox -title "Удаление папки/файла" -icon question -message "Вы действительно\nхотите уничтожить\n$file ?" -type yesno -parent $w]
    if {$answer != "yes"} {
      return
    }
#    file delete -force "$file"
    file delete -force [lindex $file 0]
    set FE::folder(initialfile) ""
    populateRoots "$w.files.t" "$::tekPATH" $typefb
#Или goupdate
  }

  proc showContextMenu {w x y rootx rooty fm typefb} {
    set s {}
    set t {}

    set w "$fm.files.t"
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
        .contextMenu add command -label [mc "No access"] -command {}
      }
      if {$t == "file"} {
        .contextMenu add command -label [mc "Delete file"] \
        -command [list [namespace current]::filedel $fm $s $typefb]
        .contextMenu add separator
        .contextMenu add command -label [mc "Rename file"] \
        -command [list [namespace current]::renameobj "$fm.tekfolder" $typefb  $s $fm]
      }
      if {$t == "directory"} {
        .contextMenu add command -label [mc "Delete directory"] \
        -command [list [namespace current]::filedel $fm $s $typefb]
        .contextMenu add separator
        .contextMenu add command -label [mc "Rename directory"] \
        -command [list [namespace current]::renameobj "$fm.tekfolder" $typefb  $s $fm]
      }
      .contextMenu add separator
    }
    .contextMenu add command -label [mc "Create directory"] \
    -command [list [namespace current]::createdir "dir"  $fm.tekfolder $fm $typefb]
    if {$typefb != "dir"} {
      .contextMenu add separator
      .contextMenu add command -label [mc "Create an empty file"] \
      -command [list [namespace current]::createdir "file"  $fm.tekfolder $fm $typefb]
    }
    .contextMenu add separator

    set wt [image width fe_icontools]
    if {$x > $wt} {
      set wt $x
    }
    set wt [expr $rootx - $x + $wt]
    set ht [image height fe_icontools]
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
    set ::FE::folder(column) $col
    set ::FE::folder(direction) $direction
    set ncol [list fullpath size]
    # Build something we can sort
    set data {}
    set listfile [list]
    set listdir [list]
#puts "columnSort: tree=$tree"
    set w1 [winfo toplevel $tree]
    foreach row [$tree children {}] {
      if {"$w1.dirs.t" == $tree} {
	    set type "directory"
      } else { 
	    set type [$tree set $row "type"]
      }
      if {$col == "#0"} {
        lappend data [list [$tree set $row "fullpath"] $row]
        if {$type == "file"} {
    	    lappend listfile [list [$tree set $row "fullpath"] $row]
        } else {
    	    lappend listdir [list [$tree set $row "fullpath"] $row]
        }
      } else {
        lappend data [list [$tree set $row $col] $row]
	if {$col == "date"} {
    	    if {$type == "file"} {
    		lappend listfile [list [$tree set $row "dateorig"] $row]
    	    } else {
    		lappend listdir [list [$tree set $row "dateorig"] $row]
    	    }
	} else {
    	    if {$type == "file"} {
    		lappend listfile [list [$tree set $row $col] $row]
    	    } else {
    		lappend listdir [list [$tree set $row $col] $row]
    	    }
        }
      }
    }

    set dir [expr {$direction ? "-decreasing" : "-increasing"}]
    #Оставляем .. в начале списка
    set r 0
    set data1 [lrange $data 0 end]
    set listdir1 [lrange $listdir 0 end]

    # Now reshuffle the rows into the sorted order
    if {$::FE::folder(foldersfirst)} {
#puts "listdir1=$listdir1"
	foreach info [lsort -dictionary -index 0 "$dir" "$listdir1"] {
    	    $tree move [lindex $info 1] {} [incr r]
	}
#puts "listfile=$listfile"
	foreach info [lsort -dictionary -index 0 "$dir" "$listfile"] {
    	    $tree move [lindex $info 1] {} [incr r]
	}
    } else {
#puts "NotFirst listfile=$listfile"
	foreach info [lsort -dictionary -index 0 "$dir" "$listfile"] {
    	    $tree move [lindex $info 1] {} [incr r]
	}
#puts "NotFirst listdir1=$listdir1"
	foreach info [lsort -dictionary -index 0 "$dir" "$listdir1"] {
    	    $tree move [lindex $info 1] {} [incr r]
	}
    
    }

    # Switch the heading so that it will sort in the opposite direction
    $tree heading $col -command [list [namespace current]::columnSort $tree $col [expr {!$direction}]] \
    state [expr {$direction?"!selected alternate":"selected !alternate"}]

    if {[ttk::style theme use] eq "aqua"} {
      # Aqua theme displays native sort arrows when user1 state is set
      $tree heading $col state "user1"
    } else {
      $tree heading $col -image [expr {$direction?"fe_upArrow":"fe_downArrow"}]
    }
  }

  proc   helptools {fromw tow xtow text anchor} {
    catch {destroy $fromw}
    label $fromw -text "Help" -anchor nw -justify left -bg #ffe0a6
    set tr [mc $text]
    place forget $fromw
    $fromw configure -text $tr
    raise $tow
    place $fromw  -in $tow -relx $xtow -rely 1.0 -anchor $anchor
  }

  proc initfe {typefb otv args} {
# 1: the configuration specs
#
    catch {unset FE::data}

    set specs {
	{-typew "" "" "window"}
	{-widget "" "" ""}
	{-defaultextension "" "" ""}
	{-filetypes "" "" ""}
	{-initialdir "" "" ""}
	{-initialfile "" "" ""}
	{-parent "" "" "."}
	{-title "" "" ""}
	{-sepfolders "" "" -1}
	{-foldersfirst "" "" -1}
	{-sort "" "" "#0"}
	{-reverse "" "" 0}
	{-details "" "" -1}
	{-hidden "" "" -1}
	{-width "" "" -10}
	{-height "" "" -10}
	{-x "" "" 5}
	{-y "" "" 5}
	{-relwidth "" "" 1.0}
	{-relheight "" "" 1.0}
    }
#place $w -in [winfo parent $w] -x 5 -y 5 -relwidth 1.0 -relheight 1.0 -width -10 -height -80

    tclParseConfigSpec FE::data $specs "" [lindex $args 0]
#    parray FE::data

    if {$FE::data(-widget) == ""} {
	set rand [expr int(rand() * 10000)]
	set FE::data(-widget) ".fe$rand"
    }
    set w $FE::data(-widget)
    catch {destroy $w}
    set typew $FE::data(-typew)
    set initdir $FE::data(-initialdir)
    if {![file readable "$initdir"]} {
        tk_messageBox -title "Просмотр папки" -icon info -message "Каталог не доступен (initfe):\n$initdir\nПереходим в домашний каталог" -parent .
	set initdir $::env(HOME)
        if {[tk windowingsystem] == "win32"} {
    	    set initdir [encoding convertfrom cp1251 $initdir ]
    	    set initdir [string map {"\\" "/"} $initdir]
        }
    }

    set msk $FE::data(-filetypes)
    set FE::folder(typew) $typew
    set FE::folder(w) $w
    set FE::folder(initialfile) ""
    if {$typefb == "dir"} {
	set FE::folder(sepfolders) 0
    } else {
	if {$FE::data(-sepfolders) == -1} { 
	    if { ![info exists FE::folder(sepfolders)]} {
		set FE::folder(sepfolders) 0
	    }
	} else {
	    set FE::folder(sepfolders) $FE::data(-sepfolders)
	}
	if {$FE::data(-details) == -1} {
	    if {![info exists FE::folder(details)]} {
		set FE::folder(details) 0
	    }
	} else {
	    set FE::folder(details) $FE::data(-details)
	}
    }
    set FE::folder(foldersfirst) $FE::data(-foldersfirst)
    set FE::folder(hissencb) $FE::data(-hidden)
#parray FE::folder
    if {$FE::folder(history) == ""} {
	lappend FE::folder(history) $initdir
	set FE::folder(histpos) 0
    }
    set wres [wm resizable .]
    if {$typew == "frame"} {

#Главное окно неизменяемое на время работы проводника
	frame $w -bg #d9D9D9
	all_busy_hold [winfo parent $w]
	destroy $w
	frame $w -bg #d9D9D9
    } else {
      if {$FE::folder(sepfolders)} {
        set tw [expr {$::scrwidth + 100}] 
      } else {
        set tw $::scrwidth
      }
      set tw $::scrwidth

      set th [expr $::scrheight - 100]
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
    	    append geometr +$rg1
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
      toplevel $w -bd 2  -relief groove -bg #d9d9d9
      wm geometry $w $geometr
      if {$FE::data(-width) > 0 && $FE::data(-height) > 0} {
    	    set geom $FE::data(-width)
    	    append geom "x"
    	    append geom $FE::data(-height)
    	    wm geometry $w $geom
      }
#Окно не может перекрываться (yes)
      wm attributes $w -topmost yes   ;# stays on top - needed for Linux
      if {$typefb == "dir"} {
        if {$FE::data(-title) != ""} {
    	    wm title $w [mc "$FE::data(-title)"]
        } else {
    	    wm title $w [mc "Choose directory"]
        }
        wm iconphoto $w fe_icondir
      } else {
        if {$FE::data(-title) != ""} {
    	    wm title $w [mc "$FE::data(-title)"]
        } else {
    	    wm title $w [mc "Choose file"]
	}
        wm iconphoto $w fe_iconfile
      }
    }
    set fm "$w"
    set f3 [panedwindow $w.f3 -orient horizontal -sashwidth 2mm]
#  -background red

	array set fontinfo [font actual [[label $f3.dummy] cget -font]]
	set font [list $fontinfo(-family) -14]
	destroy $f3.dummy
	$f3 add [ttk::frame $fm.dirs]
#	 -weight 1
    set data(dirArea) [ttk::treeview $fm.dirs.t -columns {fullpath} -displaycolumns {} -xscrollcommand [list [namespace current]::hidescroll $fm.dirs.x]]
    eval "$fm.dirs.t heading {#0} -text {[mc {Folders}]} -image fe_downArrow -command {[namespace current]::columnSort $fm.dirs.t {#0} 1} "
    if {$::typetlf} {
	$fm.dirs.t column "#0" -stretch 1 -width 200 -anchor w
    } else {
	$fm.dirs.t column "#0" -stretch 1 -width 150 -anchor w
    }
	ttk::scrollbar $fm.dirs.y -command [list $fm.dirs.t yview]
	ttk::scrollbar $fm.dirs.x -orient horizontal -command [list $fm.dirs.t xview]
    $fm.dirs.t configure -xscroll [list [namespace current]::hidescroll $fm.dirs.x ]
    $fm.dirs.t configure -yscroll [list [namespace current]::hidescroll $fm.dirs.y ]

	grid $fm.dirs.t $fm.dirs.y -sticky ns
	grid $fm.dirs.x -sticky we
	grid $fm.dirs.t -sticky news -padx {2 0} -pady {0 0}
	grid columnconfigure $fm.dirs 0 -weight 1
	grid rowconfigure $fm.dirs 0 -weight 1
    eval "bind $fm.dirs.t <Double-1> {[namespace current]::selectdir $fm.dirs.t $typew $typefb 2 $otv}"
    eval "bind $fm.dirs.t <ButtonRelease-1> {[namespace current]::selectdir $fm.dirs.t $typew $typefb 1 $otv}"
    eval "bind $fm.dirs.t <ButtonPress-3> {[namespace current]::showContextMenu %W %x %y %X %Y $w $typefb}"

	$f3 add [ttk::frame $fm.files]
#	 -weight 1
    set FE::folder(panedwindow) $f3
    set FE::folder(panedir) $fm.dirs
    set FE::folder(panefile) $fm.files
#    eval "$FE::folder(panedwindow) forget 0"
    $f3 forget $fm.dirs

    ttk::scrollbar $fm.files.y -orient vertical -command "$fm.files.t yview"
    ttk::scrollbar $fm.files.x -orient horizontal -command "$fm.files.t xview"
    if {$typefb != "dir"} {
      ttk::treeview $fm.files.t -columns {fullpath type size date dateorig permissions} -displaycolumns {size date permissions} 
    } else {
      ttk::treeview $fm.files.t -columns {fullpath type size permissions} -displaycolumns {permissions} 
    }
    $fm.files.t configure -xscroll [list [namespace current]::hidescroll $fm.files.x ]
    $fm.files.t configure -yscroll [list [namespace current]::hidescroll $fm.files.y ]
    
    set ::FE::folder(displaycolumns) [$fm.files.t cget -displaycolumns]
    set ::FE::folder(width0) [$fm.files.t column "#0" -width]

    eval "$fm.files.t heading {#0} -text {[mc {Folders and files}]} -image fe_upArrow -command {[namespace current]::columnSort $fm.files.t {#0} 0} "
    if {$typefb == "dir"} {
	$fm.files.t heading "#0" -text  [mc {Folders}]
    }

    if {$typefb != "dir"} {
      eval "$fm.files.t heading size -text {[mc {Size}]} -image fe_upArrow -command {[namespace current]::columnSort $fm.files.t size 0}"
      eval "$fm.files.t heading date -text {[mc {Date}]} -image fe_upArrow -command {[namespace current]::columnSort $fm.files.t date 0}"
      eval "$fm.files.t heading permissions -text {[mc {Permissions}]} -image fe_upArrow -command {[namespace current]::columnSort $fm.files.t permissions 0}"
      $fm.files.t column date -stretch 0 -width 80 -anchor e
      $fm.files.t column size -stretch 0 -width 80 -anchor e
      $fm.files.t column "#0" -stretch 0 -width 170 -anchor w
    } else {
      $fm.files.t column size -stretch 1 -width 0 -anchor e
      $fm.files.t column "#0" -stretch 1 -width 75 -anchor w
    }

    eval "bind $fm.files.t <Double-1> {[namespace current]::selectobj $fm.files.t $typew $typefb 2 $otv}"
    eval "bind $fm.files.t <ButtonRelease-1> {[namespace current]::selectobj $fm.files.t $typew $typefb 1 $otv}"
    eval "bind $fm.files.t <ButtonPress-3> {[namespace current]::showContextMenu %W %x %y %X %Y $w $typefb}"

    frame $fm.buts  -bg #d9d9d9
    eval "ttk::button $fm.buts.ok -text [mc {Done}]  -command {[namespace current]::fereturn $typew $fm $typefb $otv}"
    eval "ttk::button $fm.buts.cancel -text [mc {Cancel}]  -command {[namespace current]::fecancel $typew $fm $typefb $otv}"
    pack $fm.buts.ok -side right
    pack $fm.buts.cancel -side right  -padx 1mm


    pack $fm.buts -side bottom -fill x -padx 1mm -pady 1mm
    pack [ttk::separator $fm.sepbut] -side bottom -fill x -expand 0 -pady 0

    frame $fm.titul  -relief flat -bg white
    if {$FE::data(-title) != ""} {
    	set ltit [mc "$FE::data(-title)"]
    } else {
	if {$typefb == "dir"} {
    	    set ltit [mc "Choose folder"]
	} else {
    	    set ltit [mc "Choose file"]
	}
    }
    if {$typew == "frame"} {
	label $fm.titul.labzag -text $ltit -relief flat -bg skyblue -justify center
	pack $fm.titul.labzag -side top -fill x -expand 1
    }
#   label $fm.titul.lab  -relief flat -bg skyblue -justify center
    

	# f1: the toolbar
	#
    set win $w
    set dataName [winfo name $win]

	set f1 [ttk::frame $fm.titul.tools -class Toolbar]
	set data(bgLabel) [ttk::label $f1.bg -style Toolbutton]
	set data(upBtn) [ttk::button $f1.up -style Toolbutton]
	set FE::folder(upBtn) $data(upBtn)
	eval "$data(upBtn) configure -image {fe_up disabled fe_upbw} -command {[namespace current]::goup $fm $typefb}"
	eval "bind $data(upBtn) <Enter> {[namespace current]::helptools $fm.helpview $data(upBtn) 0.0  {[mc {Go up}]} nw}"
	eval "bind $data(upBtn) <Leave> {place forget $fm.helpview}"

	set data(prevBtn) [ttk::button $f1.prev -style Toolbutton]
	eval "$data(prevBtn) configure -image {fe_previous disabled fe_previousbw} -command {[namespace current]::goprev $fm $typefb}"
	set FE::folder(prevBtn) $data(prevBtn)
	set data(nextBtn) [ttk::button $f1.next -style Toolbutton]
	eval "$data(nextBtn) configure -image {fe_next disabled fe_nextbw} -command {[namespace current]::gonext $fm $typefb}"
	set FE::folder(nextBtn) $data(nextBtn)
	set data(homeBtn) [ttk::button $f1.home -style Toolbutton]
	eval "$data(homeBtn) configure -image {fe_gohome disabled fe_gohomebw} -command {[namespace current]::gohome $fm $typefb}"
	set data(reloadBtn) [ttk::button $f1.reload -style Toolbutton]
	eval "$data(reloadBtn) configure -image fe_reload -command {[namespace current]::goupdate $fm $typefb}"
	set data(newBtn) [ttk::button $f1.new -style Toolbutton]
	eval "$data(newBtn) configure -image fe_adddir -command {[namespace current]::createdir dir $fm.tekfolder $fm $typefb}"
	eval "bind $data(newBtn) <Enter> {[namespace current]::helptools $fm.helpview $data(newBtn) 1.0  {[mc {Create directory}]} ne}"
	eval "bind $data(newBtn) <Leave> {place forget $fm.helpview}"
    if {$typefb != "dir"} {
	set data(newfileBtn) [ttk::button $f1.newfile -style Toolbutton]
	eval "$data(newfileBtn) configure -image fe_addfile -command {[namespace current]::createdir file $fm.tekfolder $fm $typefb}"
	eval "bind  $data(newfileBtn) <Enter> {[namespace current]::helptools $fm.helpview $data(newfileBtn) 1.0 {[mc {Create an empty file}]} ne}"
	eval "bind  $data(newfileBtn) <Leave> {place forget $fm.helpview}"
    }
    set data(hiddenBtn) [ttk::checkbutton $f1.hiddencb -style Toolbutton]
    set FE::folder(hiddenBtn) $data(hiddenBtn)

    set ::FE::folder(hiddencb) 0
    eval "$data(hiddenBtn) configure -image fe_eye_hidden -padding {1mm 0 0 0} -variable FE::folder(hiddencb) -command {[namespace current]::gohidden $fm $typew $typefb $otv}"

    eval "bind $f1.hiddencb <Enter> {[namespace current]::gohelphidden  $fm $f1 } "

    eval "bind $f1.hiddencb <Leave> {place forget $fm.helpview}"

	set data(cfgBtn) [ttk::menubutton $f1.cfg -style Toolbutton]
	set data(cfgMenu) [menu $data(cfgBtn).menu -tearoff 0]
	$data(cfgBtn) configure -image fe_configure \
		-menu $data(cfgMenu)

	set data(sortMenu) [menu $data(cfgMenu).sort -tearoff 0]
	set data(treeMenu) [menu $data(cfgMenu).tree -tearoff 0]
	set image [option get $data(cfgMenu) image Image]
	set image fe_blank16
	set selimage [option get $data(cfgMenu) selectImage Image]

	set msg " "
	eval [subst "$data(cfgMenu) add checkbutton -label \"[::msgcat::mc {Folders First}]\" \
		-image  fe_unchecked_tick16 -selectimage fe_tick16 -compound left \
		-variable ::FE::folder(foldersfirst) -indicatoron 0 \
		-command {[namespace current]::columnSort $fm.files.t \$FE::folder(column) \$FE::folder(direction)}"]


	$data(cfgMenu) add cascade -label " [::msgcat::mc {Data composition}]" \
	  -menu $data(treeMenu) -image $image -compound left
	foreach hcol  [$fm.files.t cget -displaycolumns] {
	    $data(treeMenu) add checkbutton -label [::msgcat::mc "$hcol"] \
	        -compound left -image fe_unchecked_tick16 -selectimage fe_tick16 \
		-variable ::FE::folder(tree$hcol) -indicatoron 0 
#Состав расширенного просмотра
	    set ::FE::folder(tree$hcol) 1
	}

	set cmd [subst "$fm.files.t configure -displaycolumns {}; $fm.files.t column {#0} -stretch 1"]
	eval [subst "$data(cfgMenu) add radiobutton -label {[::msgcat::mc {Short View}]} \
	        -compound left \
		-image fe_radio16_unchecked -selectimage fe_radio16 \
		-variable ::FE::folder(details) -value 0 -indicatoron 0 \
		-command {$cmd}"]

	set cmd [subst "$fm.files.t configure -displaycolumns {$::FE::folder(displaycolumns)}; $fm.files.t column {#0} -stretch 0 -width $::FE::folder(width0)"]
	eval [subst "$data(cfgMenu) add radiobutton -label {[::msgcat::mc {Detailed View}]} \
	        -compound left \
		-image fe_radio16_unchecked -selectimage fe_radio16 \
		-variable ::FE::folder(details) -value 1 -indicatoron 0 \
		-command {[namespace current]::detailedview $fm.files.t}"]
	$data(cfgMenu) add separator
	eval [subst "$data(cfgMenu) add checkbutton -label {[::msgcat::mc {Separate Folders}]} \
		-image  fe_unchecked_tick16 -selectimage fe_tick16 -compound left \
		-variable ::FE::folder(sepfolders) -indicatoron 0 \
		-command {[namespace current]::gosepfolders $fm $typew $typefb}"]

	$data(prevBtn) state disabled
	$data(nextBtn) state disabled
	if {![info exists ::env(HOME)]} {
		$data(homeBtn) state disabled
	}

	place $data(bgLabel) -relheight 1 -relwidth 1

	pack $data(upBtn) -side left -fill y
	pack $data(prevBtn) -side left -fill y
	pack $data(nextBtn) -side left -fill y
	pack $data(homeBtn) -side left -fill y
	pack $f1.hiddencb -side left -fill y
	pack $data(cfgBtn) -side left -fill y
	pack $data(newBtn) -side left -fill y
	if {$typefb != "dir"} {
	    pack $data(newfileBtn) -side left -fill y
	}
	pack $data(reloadBtn) -side left -fill y

	set data(lang) [ttk::label $f1.lang -style Toolbutton]

    if {[string range [msgcat::mclocale] 0 1] == "ru" } {
	$data(lang) configure -image  fe_ru_24x16
    } else {
	$data(lang) configure -image fe_usa_24x16
    }

	pack $data(lang) -side right -anchor e -pady {2 0} -fill x -expand 0

    pack $fm.titul.tools -side left -anchor nw -fill x -expand 1

    labelframe $fm.filter  -bd 0 -labelanchor w

#Текущий каталог 
    set ftd [ttk::frame $fm.tekfolder]
    label $fm.tekfolder.lab -text "[mc {Current directory}]:" -bd 0 -anchor nw

    set dirlist [lindex $FE::folder(history) 0]
    foreach d $FE::folder(history) {
        if {[lsearch -exact $dirlist $d] == -1} {
    	    lappend dirlist $d
        }
    }
    if {![info exists initdir]} {
	if {[info exists ::env(HOME)] && ![string equal $::env(HOME) /]} {
	    lappend dirlist $::env(HOME)
	}
    } else {
	lappend dirlist $initdir
    }

    ttk::combobox $fm.tekfolder.ldir -width 0 -values $dirlist -textvariable FE::folder(tek)
    eval "bind $fm.tekfolder.ldir <<ComboboxSelected>> {[namespace current]::selectobj $fm.files.t $typew $typefb 3 $otv}"
    eval "bind $fm.tekfolder.ldir <Key-Return> {[namespace current]::selectobj $fm.files.t $typew $typefb 3 $otv}"
   $fm.tekfolder.ldir delete 0 end
   $fm.tekfolder.ldir insert end [lindex $dirlist end]
    pack $fm.tekfolder.lab -side left -fill none
    pack $fm.tekfolder.ldir -side left -fill x -expand 1
    
#Установка фильтра
    if {$typefb != "dir"} {
	set msk1 [list]
	foreach line $msk {
	    foreach {a b} $line {
		set lb ""
		foreach bb $b {
		    if {[string range $bb 0 0] == "\."} {
			append lb "*$bb "
		    } else {
			append lb "$bb "
		    }
		}
		lappend msk1 "$a ($lb)"
	    }
	}
	if {[llength $msk1] == 0} {
	    lappend msk1 "*"
	}
	
      ttk::combobox $fm.filter.entdir -width 0 -values $msk1 -textvariable FE::folder(filter)
      pack $fm.filter.entdir -side left -anchor w -fill both -expand 1
      eval "bind $fm.filter.entdir <<ComboboxSelected>> {[namespace current]::selectobj $fm.files.t $typew $typefb 3 $otv}"
      eval "bind $fm.filter.entdir <Key-Return> {[namespace current]::selectobj $fm.files.t $typew $typefb 3 $otv}"
      $fm.filter.entdir delete 0 end
      $fm.filter.entdir insert end [lindex $msk1 0]
      $fm.filter configure -text [mc "File filter:"]
    }

    if {$typefb == "dir"} {
      set ltit [mc "Selected directory"]
    } else {
      set ltit [mc "Selected file/directory"]
    }
    labelframe $fm.seldir -text $ltit -bd 0 -labelanchor n
    entry $fm.seldir.entdir -relief sunken -bg white -highlightthickness 0 -highlightbackground skyblue -highlightcolor blue -readonlybackground white
    pack $fm.seldir.entdir -side right -anchor ne -fill x -expand 1
    $fm.seldir.entdir configure -textvariable FE::folder(initialfile)
    if {$typefb != "filesave"} {
	$fm.seldir.entdir configure -state readonly
    }

    ###############=============PACK=============================
    pack $fm.titul -anchor ne -expand 0 -fill x -side top -pady {0 0}
    pack $fm.buts -anchor sw -expand 0 -fill both -side bottom
    pack $fm.tekfolder -anchor ne -expand 0 -fill x -side top
    pack $fm.seldir -anchor se -expand 0 -fill both -side bottom
    pack [ttk::separator $fm.sepbut0] -side bottom -fill x -expand 0 -pady 0
    pack $fm.filter -anchor ne -expand 0 -fill both -side bottom
    grid $fm.files.t $fm.files.y -sticky ns
    grid $fm.files.x -sticky we
    grid columnconfigure $fm.files 0 -weight 1
    grid rowconfigure $fm.files 0 -weight 1
    
    grid $fm.files.t -sticky news -padx {2 0} -pady {0 0}
#При использовании panedwindow добавляемые в панель компоненты (в данном случае $fm.fr и $fm.dirs) укаковывать (pack, greid, place) отдельно не надо
#    pack $fm.fr -fill both -expand 1 -side right -padx 0 -anchor nw
#    pack $fm.dirs -fill both -expand 1 -side left -padx 4 -anchor nw

    pack $f3 -side top -fill both -expand 1 -padx {2 2} -pady {2 2}

    ##################################################

    page_newdir $fm $typefb
#puts "initfe: FE::folder(sepfolders)=$FE::folder(sepfolders) initdir=$initdir"
    set FE::folder(tek) $initdir
    lappend FE::folder(history) $FE::folder(tek)
    incr [namespace current]::folder(histpos)
    if {$FE::folder(sepfolders)} {
	gosepfolders $fm $typew $typefb
    } else {
	populateRoots "$fm.files.t" "$initdir" $typefb
    }
    if {$typew != "frame"} {
      tkwait visibility $w
#puts "initfe: tk busy hold $w"
      tk busy hold [winfo parent $w]
#puts "initfe: tk busy hold1 $w"
    }
    if {!$FE::folder(details) } {  
	$fm.files.t configure -displaycolumns {}; $fm.files.t column {#0} -stretch 1
    }
    if {$typew == "frame"} {
#Настройка внешнего вида фрейма с проводником
	$w configure -relief groove -borderwidth 3 -highlightbackground sienna \
	    -highlightcolor chocolate  -highlightthickness 3
#Размещение фреймаа с проводником по одноиу из методов pack/grid/place
	place $w -in [winfo parent $w] -x $FE::data(-x) -y $FE::data(-y) -relwidth $FE::data(-relwidth) -relheight $FE::data(-relheight) -width $FE::data(-width) -height $FE::data(-height)

    }
    if {$typefb == "filesave"} {
	set FE::folder(initialfile) $FE::data(-initialfile)
    }
  }

  proc datefmt {str} {
	clock format $str -format {%d-%m-%Y %H:%M}
  }
  proc modefmt {type mode} {
	switch $type {
		file {set rc -}
		default {set rc [string index $type 0]}
	}
	binary scan [binary format I $mode] B* bits
	foreach b [split [string range $bits end-8 end] ""] \
		c {r w x r w x r w x} {
		if {$b} {append rc $c} else {append rc -}
	}
	set rc
  }
  proc detailedview {w} {
#w = $fm.files.t
    set dcol ""
    foreach col $FE::folder(displaycolumns) {
	if {[subst $[subst FE::folder\(tree$col\)]]}  {
	    append dcol " $col"
	}
    }
    puts $dcol 
    $w configure -displaycolumns "$dcol"
    if {$dcol != ""} { 
	$w column {#0} -stretch 0 -width $::FE::folder(width0)
    } else {
	$w column {#0} -stretch 1
    }
  }
  proc gosepfolders {w typew typefb} {
#puts "gosepfolders ::FE::folder(sepfolders)=$::FE::folder(sepfolders)"
    if {$typefb == "dir"} {
	$w.files.t heading "#0" -text  [mc {Folders}]
	return
    }
    if {$typew == "frame"} { 
	set w1 $w
    } else {
	set w1 [winfo toplevel $w]
    }
    if {!$::FE::folder(sepfolders)} {
#	eval "$FE::folder(panedwindow) forget 0"
	eval "$FE::folder(panedwindow) forget $FE::folder(panedir)"
	$w1.files.t heading "#0" -text "[mc {Folders and files}]"
    } else {
#	eval "$FE::folder(panedwindow) insert 0 $FE::folder(panedir)"
	eval "$FE::folder(panedwindow) add $FE::folder(panedir) -before $FE::folder(panefile)"
	$w1.files.t heading "#0" -text  [mc {Files}]
    }
    goupdate $w $typefb
  }
 
  proc goup {w typefb} {
    set tdir $FE::folder(tek)
    if {$tdir == [file dirname $tdir ]} {
	return
    }
    set tdir [file dirname $tdir ]
    set rr [file readable "$tdir"]
    if {$rr == 0} {
      tk_messageBox -title "Просмотр папки" -icon info -message "Каталог не доступен (goup):\n$tdir" -parent $w
      return
    }
    if {$typefb != "filesave"} {
	set FE::folder(initialfile) ""
    }

    populateRoots "$w.files.t" "$tdir" $typefb
    set FE::folder(tek) $tdir
    lappend FE::folder(history) $FE::folder(tek)
    incr FE::folder(histpos)
    $FE::folder(prevBtn) state !disabled
  }

  proc gohome {w typefb} {
    set tdir $::env(HOME)
    if {[tk windowingsystem] == "win32"} {
#Перекодируем путь из кодировки ОС
#Для MS Win это скорей всего cp1251
	set tdir [encoding convertfrom cp1251 $tdir ]
#Заменяем обратную косую в пути на нормальную косую
	set tdir [string map {"\\" "/"} $tdir]
    }
    if {$tdir ==  $FE::folder(tek)} {
	return
    } 
    set FE::folder(prev) $FE::folder(tek)
    $FE::folder(prevBtn) state !disabled

    set rr [file readable "$tdir"]
    if {$rr == 0} {
      tk_messageBox -title "Просмотр папки" -icon info -message "Каталог не доступен (gohome):\n$tdir" -parent $w
      return
    }
    if {$typefb != "filesave"} {
	set FE::folder(initialfile) ""
    }

    populateRoots "$w.files.t" "$tdir" $typefb
    set FE::folder(tek) $tdir
    lappend FE::folder(history) $FE::folder(tek)
    incr FE::folder(histpos)
  }

  proc goupdate {w typefb} {
    set tdir [lindex $FE::folder(history) $FE::folder(histpos)]
    if {$typefb != "filesave"} {
	set FE::folder(initialfile) ""
    }
    populateRoots "$w.files.t" "$tdir" $typefb
    set FE::folder(tek) $tdir
    [namespace current]::columnSort $w.files.t $::FE::folder(column) $::FE::folder(direction)
  }

  proc goprev {w typefb} {
    incr FE::folder(histpos) -1
    set tdir [lindex $FE::folder(history) $FE::folder(histpos)]
    if {$typefb != "filesave"} {
	set FE::folder(initialfile) ""
    }
    populateRoots "$w.files.t" "$tdir" $typefb
    set FE::folder(tek) $tdir
    $FE::folder(nextBtn) state !disabled
    if {$FE::folder(histpos) == 0} {
	$FE::folder(prevBtn) state disabled
    }
  }

  proc goreverse {fm typefb} {
#puts "goreverse fm=$fm typefb=$typefb ::FE::folder(reverse)=$::FE::folder(reverse)"
    set col $::FE::folder(column) 
    set direction [expr {$::FE::folder(direction) ? 0 : 1}]
    set ::FE::folder(direction) $direction
    
    [namespace current]::columnSort $fm.files.t $col $direction
  }

  proc gohidden {fm typew typefb otv} {
    [namespace current]::selectobj $fm.files.t $typew $typefb 3 $otv
    place forget $fm.helpview; 
    if {$FE::folder(hiddencb)} {
	$FE::folder(hiddenBtn) configure -image eye_nohidden
    } else { 
	$FE::folder(hiddenBtn) configure -image fe_eye_hidden
    }
  }
  proc gohelphidden {fm f1} {
    if {$::FE::folder(hiddencb)} {
	[namespace current]::helptools $fm.helpview $f1.hiddencb 1.0 "[mc {Hide hidden folders}]" ne 
    } else {
	[namespace current]::helptools $fm.helpview $f1.hiddencb 1.0 "[mc {Add hidden folders}]" ne
    } 
  }
  
  proc gonext {w typefb} {
    incr FE::folder(histpos)
    set tdir [lindex $FE::folder(history) $FE::folder(histpos)]
    if {$typefb != "filesave"} {
	set FE::folder(initialfile) ""
    }
    populateRoots "$w.files.t" "$tdir" $typefb
    set FE::folder(tek) $tdir
    $FE::folder(prevBtn) state !disabled
    if {$FE::folder(histpos) >= [llength $FE::folder(history)] - 1} {
	$FE::folder(nextBtn) state disabled
    }
  }

  proc selectobj {w typew typefb click otv} {
    if {$FE::folder(typew) == "frame"} { 
	set w1 $FE::folder(w)
    } else {
	set w1 [winfo toplevel $w]
    }
    if {$click == 3} {
      set tekdir $FE::folder(tek)
      if {$typefb != "dir"} {
        set mask [$w1.filter.entdir get]
      } else {
        set mask "*"
      }
      set dir "$tekdir"
        populateTree $typefb $mask $w [$w insert {} end -text "$dir" \
        -values [list "$dir" directory]]
      lappend FE::folder(history) $FE::folder(tek)
      if {[incr FE::folder(histpos)]} {
	    $FE::folder(prevBtn) state !disabled
      }
    }
    set num [$w selection]
    set titem [$w item $num -value]
#puts "titem=$titem num=$num w=$w full=[$w item $num]"
    if {$click == 2 && [lindex $titem 1] == "directory"} {
      #Выбираем имя главного фрейма/окна
      set tekdir "[lindex $titem 0]"
      set FE::folder(tek) $tekdir
      if {$typefb != "dir"} {
        set mask [$w1.filter.entdir get]
      } else {
        set mask "*"
      }
#puts "tekdir=$tekdir"
      set dir "$tekdir"
#puts "selectobj dir=$dir"
      populateTree $typefb $mask $w [$w insert {} end -text "$dir" -values [list "$dir" directory]]
      set FE::folder(history) [lrange $FE::folder(history) 0 $FE::folder(histpos)]
      lappend FE::folder(history) $FE::folder(tek)
      set ldir [lindex $FE::folder(history) 0]
      foreach d $FE::folder(history) {
        if {[lsearch -exact $ldir $d] == -1} {
    	    lappend ldir $d
        }
      }
      $w1.tekfolder.ldir configure -value $ldir
	if {[incr FE::folder(histpos)]} {
		$FE::folder(prevBtn) state !disabled
#		set data(selectFile) ""
	}
	$FE::folder(nextBtn) state disabled
    } elseif {$click == 2 && [lindex $titem 1] == "file"} {
      set fm [winfo toplevel $w]
      set tekdir "[lindex $titem 0]"
      set FE::folder(tek) $tekdir
    } elseif {$click == 3 } {
      set tekdir ""
    } else {
      set tekdir "[lindex $titem 0]"
    }
    set FE::folder(initialfile) "[file tail $tekdir]"
#uts "W1=$w1 W=$w"

    if {$click == 2 && [lindex $titem 1] == "file"} {
	if {$FE::folder(typew) == "frame"} { 
	    set fm $FE::folder(w)
	} else {
	    set fm [winfo toplevel $w]
	}
#      set fm [winfo toplevel $w]
#puts "selectobg: fm=$fm w=$w"
      #Это очень важно выполнение в другом потоке
      after 10 [namespace current]::fereturn $typew $fm $typefb $otv
#after 100
    }
  }

  proc selectdir {w typew typefb click otv} {
    if {!$FE::folder(sepfolders)} {
	return
    }
    if {$FE::folder(typew) == "frame"} { 
	set w1 $FE::folder(w)
    } else {
	set w1 [winfo toplevel $w]
    }
    set num [$w selection]
    set titem [$w item $num -value]
#puts "selectdir titem=$titem num=$num w=$w full=[$w item $num]"
    if {$click == 2 && [lindex $titem 1] == "directory"} {
      #Выбираем имя главного фрейма/окна
      set tekdir "[lindex $titem 0]"
      set FE::folder(tek) $tekdir
      if {$typefb != "dir"} {
        set mask [$w1.filter.entdir get]
      } else {
        set mask "*"
      }
#puts "tekdir=$tekdir"
      set dir "$tekdir"
#puts "selectdir dir=$dir"
      populateTree $typefb $mask $w1.files.t [$w1.files.t insert {} end -text "$dir" -values [list "$dir" directory]]
      set FE::folder(history) [lrange $FE::folder(history) 0 $FE::folder(histpos)]
      lappend FE::folder(history) $FE::folder(tek)
      set ldir [lindex $FE::folder(history) 0]
      foreach d $FE::folder(history) {
        if {[lsearch -exact $ldir $d] == -1} {
    	    lappend ldir $d
        }
      }
      $w1.tekfolder.ldir configure -value $ldir
	if {[incr FE::folder(histpos)]} {
		$FE::folder(prevBtn) state !disabled
	}
	$FE::folder(nextBtn) state disabled
    } else {
      set tekdir "[lindex $titem 0]"
    }
    if {$typefb == "dir"} {
	$w1.seldir.entdir configure -state normal
	$w1.seldir.entdir delete 0 end
	$w1.seldir.entdir insert end "[file tail $tekdir]"
        $w1.seldir.entdir configure -state readonly

    }
  }

  proc fereturn {typew w typefb otv} {
    variable $otv
    set num [$w.files.t selection]
    set titem [$w.files.t item $num -value]
    set ret [lindex $titem 0]
    if {$ret == ""} {
      if {$typefb == "dir"} {
        $w.tekfolder.ldir configure -state normal
        set ret [$w.tekfolder.ldir get]
        $w.tekfolder.ldir configure -state readonly
      } elseif {$typefb == "filesave"} {
        if {$FE::folder(initialfile) == ""} {
    	    return
        }
        set ret [file join  $FE::folder(tek) $FE::folder(initialfile)]
      } else {
        return
      }
    }

    set $otv $ret
    if {$typew != "frame"} {
	tk busy forget [winfo parent $w]
    }
    catch {destroy $w}
    return $otv
  }

  proc fecancel {typew w typefb otv} {
    if {$typew != "frame"} {
	tk busy forget [winfo parent $w]
    }
    catch {destroy $w}
    variable $otv
    set $otv ""
    return $otv
  }

  ## Code to populate the roots of the tree 
  proc populateRoots {tree dir typefb} {
    global env

    set tekdir $dir
    set w1 [winfo toplevel $tree]
#puts "populateRoots tree=$tree dir=$dir typefb=$typefb"
    if {$typefb != "dir"} {
      set mask $FE::folder(filter)
    } else {
      set mask "*"
    }
    set dir "$tekdir"
      populateTree $typefb $mask $tree "[$tree insert {} end -text "$dir" \
      -values [list "$dir" directory]]"
  }

  ## Code to populate a node of the tree
  proc populateTree {typefb mask tree node} {
    $tree delete [$tree children $node]
    if {$FE::folder(typew) == "frame"} { 
	set w1 $FE::folder(w)
    } else {
	set w1 [winfo toplevel $FE::folder(w)]
    }
    if {$FE::folder(sepfolders)} {
	set wtree "$w1.dirs.t"
    } else {
	set wtree $tree
    }
    if {[$tree set $node type] ne "directory"} {
      return
    }
    if {![llength $FE::folder(history)]} {
	set path $FE::folder(tek)
    } else {
	set path "[$tree set $node fullpath]"
    }
    #На первый уровень
    set node ""
    set directory_list ""

    set rr [file readable "$path"]
    if {$rr == 0} {
      tk_messageBox -title "Просмотр папки" -icon info -message "Каталог не доступен (populateTree):\n$path" -parent .
      set ::tekPATH $path
      return
    }

    set directory_list [lsort -dictionary [glob -nocomplain -types d -directory "$path" "*"]]
    if {$FE::folder(hiddencb)} {
      set directory_list1 [lsort -dictionary [glob -nocomplain -types {d hidden} -directory "$path" "*"]]
      set ptr [string first "/.. " $directory_list1]
      if {$ptr != -1} {
        append directory_list [string range $directory_list1 [expr $ptr + 3] end ]
      }
    }
    set ::tekPATH $path
    $tree delete [$tree children $node]
    set levelup [file dir $path ]
    set type [file type $levelup]
    set ind 0
    if {$FE::folder(sepfolders)} {
	$wtree delete [$wtree children $node]
    }
    foreach f [lsort -dictionary $directory_list] {
      set type [file type "$f"]
      set rr [file readable "$f"]
      if {$rr == 0} {
        set id [$wtree insert $node end -id $ind -image fe_icondirdenied -text [file tail "$f"] \
        -values [list "$f" "denied"]]
      } else {
        set id [$wtree insert $node end -id $ind -image fe_icondir -text [file tail "$f"] \
        -values [list "$f" $type]]
      }
      incr ind
    }
    if {$typefb != "dir"} {
	set files_list [list]
	set ind1 [string last "(" $mask]
	set ind2 [string last ")" $mask]
	incr ind1
	incr ind2 -1
	set mask1 [string range $mask $ind1 $ind2]
#puts "MASK1=$mask1 MAK=$mask ind1=$ind1 ind2=$ind2"

	foreach f1 [eval [linsert "$mask1" 0 glob -nocomplain -tails \
		-directory $path -type {f l c b p}]] {
		# Links can still be directories. Skip those.
		if {[file isdirectory [file join $path $f1]]} continue
		lappend files_list [file join $path $f1]
	}


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
          set id [$tree insert $node end -image fe_iconfiledenied -text [file tail $f] \
          -values [list $f "denied"]]
        } else {
          set id [$tree insert $node end -image fe_iconfile -text [file tail $f] \
          -values [list $f $type]]
        }
        file stat $f fstat
	set size $fstat(size)
	set date $fstat(mtime)
	set uid  $fstat(uid)
	set mode $fstat(mode)
	set type $fstat(type)
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
        $tree set $id date [datefmt $date]
        $tree set $id dateorig $date
        $tree set $id permissions [modefmt $type $mode]
      }
    }

    $tree set $node type processedDirectory
  }

  proc page_newdir {fm typefb}  {
    set ::newname  [mc "Enter a name for new folder"]
    ttk::label $fm.lforpas -text [mc "Enter a name for new folder"]  -textvariable ::newname

    #Widget for new Name
    frame $fm.topName -relief flat -bd 3 -bg chocolate
    labelframe $fm.topName.labFrPw -borderwidth 4 -labelanchor nw -relief groove -labelwidget $fm.lforpas -foreground black -height 120 -width 200  -bg #eff0f1
    pack $fm.topName.labFrPw -in $fm.topName  -anchor nw -padx 1mm -pady 1mm -fill both -expand 0
    entry $fm.topName.labFrPw.entryPw -background snow  -highlightbackground gray85 -highlightcolor skyblue -justify left -relief sunken
    pack $fm.topName.labFrPw.entryPw -fill x -expand 1 -padx 1mm -ipady 2 -pady 2mm
    eval "bind $fm.topName.labFrPw.entryPw <Key-Return> {[namespace current]::readName $fm.topName.labFrPw.entryPw}"
    ttk::button $fm.topName.labFrPw.butPw  -command {global yespas;set yespas "no"; } -text [mc "Cancel"]
    eval "ttk::button $fm.topName.labFrPw.butOk  -command {[namespace current]::readName $fm.topName.labFrPw.entryPw} -text [mc Done]"
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
      set ::newname  [mc "Enter a name for new folder"]
    } elseif {$type == "file"} {
      set ::newname  [mc "Enter a new file name"]
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
	catch {file mkdir $newd} er 
	if {$er != ""} {
    	    tk_messageBox -title [mc "Create directory"] -icon info -message "Каталог создать не удалось\n$er" -parent $w
	    return
	}
	lappend FE::folder(history) [file join $FE::folder(tek) $newdir]
	gonext $fm $typefb
    } else {
        if {[catch {set fd [open $newd w]} er]} {
    	    tk_messageBox -title [mc "Create file"] -icon info -message "Файл создать не удалось\n$er" -parent $w
    	    return
        }
        chan configure $fd -translation binary
        close $fd
	goupdate $fm $typefb
    }
    set pass ""
    return
  }

  proc renameobj {w typefb oldname fm} {
    global pass
    global yespas
    if {$typefb == "dir"} {
      set ::newname  [mc "Enter a new folder name"]
    } elseif {$typefb == "fileopen" || $typefb == "filesave" } {
      set ::newname  [mc "Enter a new file name"]
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
#puts "\n$newdir\n$oldname\n$newd\n$oldn"

    if {[file exists $newd]} {
      if {$typefb == "fileopen" || $typefb == "filesave"} {
        set answer [tk_messageBox -title "mc [Rename file]" -icon question -message "Файл с таким именем есть:\n$oldname\nПродолжить операцию ?" -type yesno  -parent $w]
        if {$answer != "yes"} {
          return
        }
      }
    }
    file rename -force "[lindex $oldname 0]" "$newd"
    set FE::folder(initialfile) ""
    $fm.seldir.entdir configure -state normal
    $fm.seldir.entdir delete 0 end
    if {$typefb != "filesave"} {
	$fm.seldir.entdir configure -state readonly
    }
    populateRoots "$fm.files.t" "$::tekPATH" $typefb
    set pass ""
  }
  proc fe_getsavefile {args} {
    #Формируем случайную переменную
    set rand [expr int(rand() * 10000)]
    set rr "otv$rand"
    #Ответ будет создан в пространстве имен fileexplorer!!!
    variable $rr
    initfe filesave $rr $args
    set cmd [subst "vwait FE::$rr"]
    set w [winfo toplevel $FE::folder(w)]
    eval $cmd
    set ret [subst "FE::$rr"]
    set retok [subst $$ret]
    unset $rr
    if {$FE::folder(typew) == "frame"} {
	all_busy_forget [winfo toplevel $w]
    }
    return "$retok"
  }
  proc fe_getopenfile {args} {
    #Формируем случайную переменную
    set rand [expr int(rand() * 10000)]
    set rr "otv$rand"
    #Ответ будет создан в пространстве имен fileexplorer!!!
    variable $rr
    initfe fileopen $rr $args
    set cmd [subst "vwait FE::$rr"]
    set w [winfo toplevel $FE::folder(w)]
    eval $cmd
    set ret [subst "FE::$rr"]
    set retok [subst $$ret]
    unset $rr
    if {$FE::folder(typew) == "frame"} {
	all_busy_forget $w
    }
    return "$retok"
  }
  proc fe_choosedir {args} {
    #Формируем случайную переменную
    set rand [expr int(rand() * 10000)]
    set rr "otv$rand"
    #Ответ будет создан в пространстве имен fileexplorer!!!
    variable $rr
    initfe dir $rr $args
    set cmd [subst "vwait FE::$rr"]
    set w [winfo toplevel $FE::folder(w)]
    eval $cmd
    set ret [subst "FE::$rr"]
    set retok [subst $$ret]
    unset $rr
    if {$FE::folder(typew) == "frame"} {
	all_busy_forget [winfo toplevel  $w]
    }
    return "$retok"
  }
  proc all_disable {parent} {
    set widgets [info commands $parent*]
    foreach w $widgets {
	catch {$w configure -state disabled}
    }
  }
  proc all_enable {parent} {
    set widgets [info commands $parent*]
    foreach w $widgets {
	catch {$w configure -state normal}
    }
  }
  proc all_busy_hold {parent} {
    set widgets [info commands $parent*]
    foreach w $widgets {
	if {$w == "." } { continue}
	catch {tk busy hold $w}
    }
    catch {tk busy forget $parent}
  }
  proc all_busy_forget {parent} {
    set widgets [info commands $parent*]
    foreach w $widgets {
	if {$w == "." } { continue}
	catch {tk busy forget $w}
    }
  }
 # С grid лучше, т.к. запоминается где был - grid remove
  proc hidescroll {sb  first last} {
    if {($first <= 0.0) && ($last >= 1.0)} {
    # Since I used the grid manager above, I will here too.
    # The grid manager is nice since it remembers geometry when widgets are hidden.
    # Tell the grid manager not to display the scrollbar (for now).
	grid remove $sb
    } else {
    # Restore the scrollbar to its prior status (visible and in the right spot).
	grid $sb
    }
    $sb set $first $last
  }

  set folder(history) ""
  set folder(histpos) -1


  namespace export fe_getsavefile
  namespace export fe_getopenfile
  namespace export fe_choosedir
  namespace export all_enable
  namespace export all_disable

}

