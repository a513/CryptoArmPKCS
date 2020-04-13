# breeze.tcl --
#
# Breeze pixmap theme for the ttk package.
#
#  Copyright (c) 2018 Maximilian Lika

#package require Tk 8.6.0

namespace eval ttk::theme::Breeze {

    variable version 0.6
    package provide ttk::theme::Breeze $version

    variable colors
#MY
#	-frame          "#d8d8d8"
#	-lighter        "#fcfcfc"
#	    -darker         "#9e9e9e"
    array set colors {
	-frame          "#d8d8d8"
	-lighter        "#fcfcfc"
	-darker         "#9e9e9e"

        -fg             "#31363b"
        -bg             "#eff0f1"
        
        -disabledfg     "#bbcbbe"
        -disabledbg     "#e7e8ea"
        
        -selectbg       "#3daee9"
        -selectfg       "white"
        
        -window         "#eff0f1"
        -focuscolor     "#3daee9"
        -checklight     "#94d0eb"
    }
        #-disabledbg     "#e3e5e6"
        #-disabledfg     "#a8a9aa"

#LISSI
variable I
array set I []
set I(checkbox-checked-insensitive) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAACXBIWXMAAA7EAAAO
xAGVKw4bAAAAB3RJTUUH4wIBDBQWTRhs6QAAAB1pVFh0Q29tbWVudAAAAAAAQ3Jl
YXRlZCB3aXRoIEdJTVBkLmUHAAAAhElEQVQoz2N8+uz5vXv3f/z4wUAIsLKyKSsr
Mh4+eoyFmUVMVJSLmxu/hlcvX7x7/4Hpx/cfxKhmYGAQE5f48+cPCwMDA0T1lStX
8KjW0dGBMJgYSASjGgaHBhbMuCRgAxsb26uXL4hR+u7Dew52dsbHT57euXP3z58/
BDWws7Hz8PIAAOrPKVFW/hqaAAAAAElFTkSuQmCC
}]

set I(arrow-up-insens) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAAAwAAAAMCAYAAABWdVznAAAABmJLR0QA/wD/AP+g
vaeTAAAAnElEQVQokWNgGBCgp2clpqdnJYZNjhmb4n8sv23+M/2TkxBVePvy5eOv
ODUYGhqK/mX+a8Pwi+UYK9Pvh3+Z/9qICcu9f/Xq6VcMDYaGhqK/GRltGH6xHrty
5eTLFy9efJOWkHj7j+WfNbImZmyKYYZg08Sop6fH/Y+F3Z3pD+uRS5eOvcIVCP9Y
ftsw/fm5Eyqgx0045AirGSAAAF+6TLqSnAj4AAAAAElFTkSuQmCC
}]

set I(button-focus) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAABmJLR0QA/wD/AP+g
vaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4gwaCQYvn1brgwAAAHVJ
REFUOMtj3PH4o9DMw0/evvrxl4EcIMbBzJBuKyPMGLjs6v+nn74ysIvJk2XQz1cP
GaT5uBmYXv34S7YhDAwMDOxi8gyvfvxlYGKgEhg1aNSgUYPoZJAYBzPDz1cPyTYA
ppdxyoXXDHuvvfpPScH2clGFGQA4JyludaEdxQAAAABJRU5ErkJggg==
}]

set I(scale-slider) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAACXBIWXMAAA7EAAAO
xAGVKw4bAAACAklEQVQ4jZ3UwW4SQRgH8G9nEnC3ZVkWVg9FLdC+gSXhDYQIxpfw
Io1Jr2yY7AY89lA56FsoGJY+gtX0WA8t2Fp60N3uLiywQDKLFzBGIVD+x8nkl5nJ
N39mMpnAvCiK4uuPRnuIYR4CAHiTyfWG3/+FEDKet5/5FyoUCg82ef6IY7lkPB4P
CiGBBwCwLbvbarU67tD97HQ6r8vl8s+FkKqqz4WQWEln0lEpIs09qW7ooNW1tm2Z
+WKx+PE/iKjqi9jj2Pts9pmEMZ6LzEIphVrtk351ffWSyPIHAAAEAHAgy1thUTzK
5bJLEQAAjDHkclkpJAhvD2R56w8UCfCVTDoTRQgtRWZBCEEmnYlGNgIVAADMMMy9
IB98k0qlgisr03AcB2ffzrjjRuMdclw3mUjshO6KzLK7sys4rptEfuzbDofFzXUh
URQDfuzbXv1RlgSN6Pjy9tbsrQuYpumM6PgSBVj2pNm8sNaFzi/O7QDLniBCyLA3
GJwahnFnxDAM6PcGp4SQIQIAMJxuvq7V257nrYx4ngd1rd42+k4eYDqQh6XSjWXb
+9VqTaeULkUopVCt1nTLtvcPS6UbgEWfNv00Kkn35yK6/gs0rdG2OvYrIsvV2frC
GmFZLpmIxYOCOK0R0+42v7c6w1Vq5O8oiuJzXfcJYPxoep8fLMt+XVRsvwEA4+2/
bFDHrgAAAABJRU5ErkJggg==
}]

set I(arrow-left) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAAAwAAAAMCAYAAABWdVznAAAABmJLR0QA/wD/AP+g
vaeTAAAApElEQVQokWNgwAMMLCwU0MWYcCu2cWD8x3wKXRNWDUZm1raM//6vZGT4
H3HhxIkHyHKM2BT/Z2BYw8jwP/LcqWP70OUZSVGM4iQDCxuH/wwMa/8zMYbjUozT
D/gAM4zx4smjB9Iy8scZ/v9fLSUte+7508f38WpgYGBgeP700SNpGfkT/xkYVuHS
xIwuQEgTRrDCACTi/q/6z/TXDD0ucAJsSQMAFAxNNV1ljE4AAAAASUVORK5CYII=
}]

set I(arrow-down-small) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAAAgAAAAICAYAAADED76LAAAABmJLR0QA/wD/AP+g
vaeTAAAAaUlEQVQYlY2OsQmAQBRDE13EEQ4E/cUvbgrBFUVXEAsRuULcR7xvYaEI
wqVMyEuAFDmR4s+jEykY82AZm32dpztUz2idZWdFAChr1Wg2ENYCPAzoCWu3sIx8
kHcLAN60z656J+qTjifrArMaJQwlwdAIAAAAAElFTkSuQmCC
}]

set I(slider-vert-insens) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAAA0AAAAcCAYAAAC6YTVCAAAABHNCSVQICAgIfAhk
iAAAAAlwSFlzAAAN1wAADdcBQiibeAAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3Nj
YXBlLm9yZ5vuPBoAAACOSURBVDiN7dQxCoNAEAXQPyHEdkGEHC7BUxiskiJVco0c
yzoKjiPe4FstGFe0kjT7u/nsY6Za4G+pKiaq9m7V6latVu1eJE/TN8c5cq5/Eij8
TMhN1Qig9N1hjghcg/Ui+XQMEIDzVreENhNRRBHti5qF7ruKBPwEhL9d8BsNQ3p3
zkDIxYMsSx/rB++VEXQiLMNb4JDyAAAAAElFTkSuQmCC
}]

set I(scrollbar-slider-insens) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABQAAAAeCAYAAAAsEj5rAAAABmJLR0QA/wD/AP+g
vaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4gwcCgIqrH07jQAAAGlJ
REFUSMft1sEJgDAQRNG/agVqF+nHIu0nXSTYQEg8iIiga1DwtHPbgXnnFZS42dO3
I8h2CxBTwE/udtNo4NAdGEDZOyUqWCq7avBNDDTQQAMNNNDA/0D5Al6N88PvoIIx
hRMqwJKiCq47KxE+Y3DNVgAAAABJRU5ErkJggg==
}]

set I(arrow-up-small-insens) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAAAgAAAAICAYAAADED76LAAAABmJLR0QA/wD/AP+g
vaeTAAAAbElEQVQYlWNgoCrQ07MS09OzEkMWY0aW/Mfy2+Y/0z85CVGFty9fPv4K
V2BoaCj6l/mvDcMvlmOsTL8f/mX+ayMmLPf+1aunXxn19PS4/7GwuzP9YT1y6dKx
V8imMf35uRNqvB43pnswxbACAKumJqoFm1acAAAAAElFTkSuQmCC
}]

set I(arrow-down-small-insens) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAAAgAAAAICAYAAADED76LAAAABmJLR0QA/wD/AP+g
vaeTAAAAb0lEQVQYlWNgIAbo6elx4xJj1tPT4/7Hwu4uIarw9uXLx18hklZi/1gY
nSRERR4xMjAwMBgaGor+ZmS0YfjFeoyV9dc/GPvKlZMvGRFGWon9Y/ltw8DAwMD0
h/XIpUvHXmFxi5WYnp6VGFEOJxoAAKNBIGUZVYmsAAAAAElFTkSuQmCC
}]

set I(entry) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAIAAAAC64paAAAABmJLR0QA/wD/AP+g
vaeTAAAAnElEQVQ4je3UsQ6DMAwE0DNKVMaQpUGF/v93ARJ0Ic5IE8kMoA7tQFqp
G7c/yTf4yHPAr1EARGSaHjNzivEYKG0r49yViMhzGMepLC9tcyOiQywiXT8sy7Ou
XQFgZs6UAIjo3jYzM4ACQIoxU778VrDIN5858Yn/j5XSIpJvREQrvWNbma4fMv32
kpU1AMhz2MfAc0rfj0H+wW9ZAQTbTWWTVwQkAAAAAElFTkSuQmCC
}]

set I(radio-unchecked) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAACXBIWXMAAA7EAAAO
xAGVKw4bAAAB+klEQVQ4jZ3UvW4aQRSG4e/M8BcgbGJIkcLIWnAV30Agaem5D8cF
EAnJSAiJggK2IL4PqN0GwxWkY1YWkdIEHO+Gf9g9aUIUORCM33rm0UxxDjEzdlUs
FuOuEMcA4AgxaFSrX3edpYdQpVIJLFbOhRR0ASFeapHIEgAs2/bBdX84Ljf9Xtks
l8vznVCxWHzj9fmvE8mklk69DcVir0BEAABmxnD4HTfd3kT1+9ZqucjUarUv/0Af
Ly/PAtLTyWazmq7rO78LAEoptNtta7VcpDcYMTNyudyzUPi5ymazr/chm0zTRLvd
/jb+aScNw5gJAAgEw/nk6enel/ydruvQk4kXgWA4DwCCiEhKef4ulQo+Wvnd+1Q6
KKQ8JyIShULpREoKRWOxQx0cRaPwSAoVCqUTQeTEIxFtfbACgIigRbQ1kRMXTwG2
JZjlwLYtz1MuMzMs2/Iwy4Go16u3jsOT0XB4MHQ3GmG9dib1evVWMDM7jnPV6Xan
h0KfuzdT1+UrZmYBAPPpuKH6/XvTNB+NmKYJs6/u59NxAwAEABiGMVsu5plWq2Up
pfYiSim0Wi1ruZhnDMOYAduG1h+4TiR0LZ1KbR3aTq83NvvKXi3m24d20581IsUH
EB1FwuEVANjjsRfMd67rNH0ez6f/rpGH5UulY+m6cWD/YvsF9VEE5DDOt3oAAAAA
SUVORK5CYII=
}]

set I(notebook-tab-top) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAAAwAAAAWCAYAAAD0OH0aAAAABmJLR0QAywDMAM6D
7+ImAAAACXBIWXMAAA3XAAAN1wFCKJt4AAAAB3RJTUUH4gwcCQIb/+WF7gAAADlJ
REFUOMtjPH3m3H8G4sCFp8+edjARqZiBh5dXhYGBIYdoDV8+f+ZhYGCwIVoDDIxq
GNUwqoGeGgAWkgtw6lHz0gAAAABJRU5ErkJggg==
}]

set I(scrollbar-trough-vert-active) [image create photo  -data {
R0lGODlhFAA4AIABAK+vr////yH+EUNyZWF0ZWQgd2l0aCBHSU1QACH5BAEKAAEA
LAAAAAAUADgAAAJojB+gi93LnIRKTmodBfnhfmxg+I3imJTgaaodu7oZ/MoWPdsX
hKY8irvpNEPPr3WMJWvLXFP43EWQU2WVeXVmoVtpBVhEBL0ccJR4NnbRa/WX+rbG
sXNtnXsn98bsfL8MBygnSEdoUAAAOw==
}]

set I(scrollbar-trough-vert-active_ORIG) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABQAAAA4CAYAAAD959hAAAAABmJLR0QA/wD/AP+g
vaeTAAAAsUlEQVRYhe3XoQ7CMBQF0NuNUgzZFPwACswcFrsvnsXiZkDxA6BYMJSy
DoNYUtYtDYbsPnn77kntA0Y3om9hlecqud6XAFAt5pdzUehgMMt2aTPVWwDyExnx
VIey3N+6OpH3e5PHpoUBgITUa1/FD8Zx4jaiNBhsGuu8f8sGgyFDkCBBggQJEiRI
kCBBgn8FChHZIdlgEHVdOZm1nZdoP/iaHQGYVmJg1MlX+fkBPsJ5A6faL2J/SI4T
AAAAAElFTkSuQmCC
}]

set I(transparent) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABQAAAAeCAYAAAAsEj5rAAAABmJLR0QA/wD/AP+g
vaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4gwcCgIqrH07jQAAAGlJ
REFUSMft1sEJgDAQRNG/agVqF+nHIu0nXSTYQEg8iIiga1DwtHPbgXnnFZS42dO3
I8h2CxBTwE/udtNo4NAdGEDZOyUqWCq7avBNDDTQQAMNNNDA/0D5Al6N88PvoIIx
hRMqwJKiCq47KxE+Y3DNVgAAAABJRU5ErkJggg==
}]

set I(arrow-up) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAAAwAAAAMCAYAAABWdVznAAAABmJLR0QA/wD/AP+g
vaeTAAAAl0lEQVQokWNgGBBgYGHjYGBh44BNjhGbYsZ//1cxMDAw/GdiDLtw4sgB
ZHkmZI6RmbUt47//KxkZ/kcwMTIGMf77v9LIzMoJWQ0zsuL/DAxrGBn+R547dWzf
86ePHknLyJ/4z8CwSkpa9tzzp4/vwzWgK4YZgk0To4GFhQLjP+ZT2NyL7q//TH/N
oAIWCjiDDK6JsJoBAgCDC0TdOaVozgAAAABJRU5ErkJggg==
}]

set I(empty) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAAAsAAAALCAYAAACprHcmAAAADklEQVQY02NgGAUj
CAAAAe8AAZYMGBwAAAAASUVORK5CYII=
}]

set I(radio-checked-insensitive) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAACXBIWXMAAA7EAAAO
xAGVKw4bAAACNElEQVQ4ja2UQW7aQBiFvxljO0yCHUBqIjWrhBs0UhbZEImNN80F
coPkOOkNcoF24w1S2LBAojdAWWWBKgVqEwy2YaYLTJsqgXTRt/znf2+e/nn/CGMM
WyDa39seQOtTKwY2Nou3hNr9TlNIbow2AaCKciKkCI3mtnXa7GwV6na7lZmb3QGf
feUvvbJnOSUbgGyRE8/iZZREFvCtnDpX5+fnk1dC3W63Mt/Je7blnBzVPjrKXRlZ
nwshVrbShMfRY54v88HO3D5bi5XWijM3u3Ms96RxeOJIIYmSiNF0TLZIEQjskkNt
t4qvfBqHDXswHDQK95e/HbX7nSaY++MPxyhXMYyGjCYjtNF/zUEKSb1S58A/IEkT
Hn48AOKiddrsSAAhufGVv1SuYjKfMHp+eiUCoI3m6fmJySxGuQpf+UshuAaQgDDa
BF7ZswDGz2O03hwJrTXj5CcAXtmzjDEBgCxyov68TrZRZI0sX/UUnN2wF3ryXdY/
QhaJTbJFXtzivEty7FVPwZkGZ0EsASOkCONZvASo7lWRcrNRKSVVtQ9APIuXQogQ
VsPGaG6jJLKSNKGyU6G2V0OK12JSSOp7dSpljyRNiJLI0trcwotkt/v3X52SEzQO
G/Y6kOPpmLQYrGs7VItAaqMZDAd5tsjC1unFJbxIdjl1ruYi7w2Gg8ZR7cj2lY+v
/K0rUk6dqzX//y/tS7T7naYQXBdh2y3KUyFEaAxf3v1G3kLYCz2A4CyIt/X9ArkM
Kaoh4zEpAAAAAElFTkSuQmCC
}]

set I(treeheading-prelight) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAAB4AAAAeCAYAAAA7MK6iAAAABmJLR0QA/wD/AP+g
vaeTAAAACXBIWXMAAA3XAAAN1wFCKJt4AAAAB3RJTUUH4gwcDyY3OFh0GQAAAD9J
REFUSMdjPH3m3P+TLLIM9ATmfx4zMDEMEBi1eNTiUYtHLR61eNTiUYtHLR61eNTi
UYtHLR5CFrPAOlH0BgBGrQi4XsR1pQAAAABJRU5ErkJggg==
}]

set I(arrow-left-insens) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAAAwAAAAMCAYAAABWdVznAAAABmJLR0QA/wD/AP+g
vaeTAAAAr0lEQVQokWNgwAP09PS40cWYcCu2EvvHwu6OrgmrBkNDQ9F/LD+sGX4x
Hb106dJXZDlGbIp/MzLaMPxiPXblysmX6PKMpChmYGBgYEZ2819mBlumP+xHL18+
8QqX33B6GheA2/Dy5eOv0hLib/4y/7URE5Z7/+rV0694NTAwMDC8ePHim7SExNt/
LP+scWliRhcgpAlDA0yThKjiu/+sf20kREUevXz58jdRHsSWNADX+VDujWZOMwAA
AABJRU5ErkJggg==
}]

set I(scrollbar-slider-vert-active) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABQAAAAeCAYAAAAsEj5rAAAABmJLR0QA/wD/AP+g
vaeTAAAAkElEQVRIie3WsQ3CMBCF4d8I4d64gBkyU2ALoAoRjJKZMgJUwb3TmMqi
uZwEtPe6e9L73NqhpB/HzXaOdwotUAoMyU9d3zTz0matgSHHG3Cqt4NzyBHgsrRZ
aaCDg9AdtY0KAnuh2/0Dfh0DDTTQQAMNNLDmKXSPn8ECg9AK3Sfq3yb5qQs54qCt
DyT/umqbN9ezHkQrVDt+AAAAAElFTkSuQmCC
}]

set I(arrow-right-insens) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAAAwAAAAMCAYAAABWdVznAAAABmJLR0QA/wD/AP+g
vaeTAAAAnUlEQVQokWNgQAN6enrc6GLIgAld8T8Wdnc9PSsxXBqYkTkvX778LS0h
/uYv818bMWG5969ePf2KVwMDAwPDixcvvklLSLz9x/LPGpsmDA2ENGHVANMkIar4
7j/rXxsJUYW3L18+/orhaWIAIy4JQ0ND0d+MjDYMv1iPXbly8iVeDbgUY9WATzED
A5aI+83IYsv0h+MoNsVYAaGkAQA2eE/mQUocvgAAAABJRU5ErkJggg==
}]

set I(arrow-left-prelight) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAAAwAAAAMCAYAAABWdVznAAAABmJLR0QA/wD/AP+g
vaeTAAAAiklEQVQokWNgwAMc1j9XQBdjwqXYZv1zh7//mU6ha8KqwX7DK1vG/0wr
GRn+RxwIlHyALMeITfG/f//XMDL8jzwUJLEPXZ6RFMUoGmzWP3dg/M+06j/jv7Aj
gZIHcPkNp6dxARQn2ax7ZcPI8H8tUU4iVhOGBkKasGpgYEAEAjPjPzP0uMAJsCUN
ALM2R+0dZr2yAAAAAElFTkSuQmCC
}]

set I(arrow-down) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAAAwAAAAMCAYAAABWdVznAAAABmJLR0QA/wD/AP+g
vaeTAAAApElEQVQokc2PTQqCUBSFz9Vd9Axdghi8HvgEVxG4Ra0tRIPIn4G2g8AU
GzaPvE0fGdUk6Iy/73AO8J/xlfK+ZchXyqPRrtii1bHY717DOqaRU7bu0r503VU4
bg7mbCbm9dCfTyYcyDACIyNw0pR5YwPA0LetcNyCgdSUAhlGDKwJnNTVYQsAZLYt
llqPzBsCJwDdnuGJYO4FgHe/JpKvdPwR/Eke6FFKPMIYKegAAAAASUVORK5CYII=
}]

set I(arrow-down-prelight) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAAAwAAAAMCAYAAABWdVznAAAABmJLR0QA/wD/AP+g
vaeTAAAAk0lEQVQokc2PsQ3CMBRE/32WwF2moDJgsUFSIBgxCGImQBaiYop0RlkB
4aMCWQkCGiSuPL13+l/kP+N8LL5l4HwsbtQzkZan0oRXsPXRgboZIU00lKaloAK1
njWXRR+e77spqDWEq1CaFs+VprMQ7iBcH6vx4QGnxG3eIV/LJahe+/BAyO8VEXn3
10CyPrqP4E9yB2s4SU1wZK6JAAAAAElFTkSuQmCC
}]

set I(checkbox-unchecked-insensitive) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAACXBIWXMAAA7EAAAO
xAGVKw4bAAAAB3RJTUUH4wIBDBodREmY7wAAAB1pVFh0Q29tbWVudAAAAAAAQ3Jl
YXRlZCB3aXRoIEdJTVBkLmUHAAAAcUlEQVQoz+3LORJAQBBA0Z5Bj7KEllS5/ykU
p7AEdgEyHXQgEzJCVX78n+iHsa4bIoKnLAvTNBFZXpiGGQaB47r3YJmnddslHaRz
A0AYxcwsAUDnvpLwsh98FSDiMk8667pvtlKi7fqyrJj5EShUnu+dV54lyUcnqr4A
AAAASUVORK5CYII=
}]

set I(button-insensitive) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAABmJLR0QA/wD/AP+g
vaeTAAABAUlEQVQ4je2UMU7DUBAFZ9e2sF0YRSkjtyh3AQkOAIpocwtOQUdJnwPk
IBGdgZIodkRspPgvFYnT5YPT8aRtR7Pa1YOeIwBmFhev74+uba+BgRdAWKoGszwf
TUWkEYCieHsKwvA+SWNU1MvIDDabT9bV+nk8vrhVgLZtb9IkRVEwvEaAJE6JougK
GP7oDES8xA6iKqhqBmRhR/73xH3CHbAXHOB3gSOyX7knxRMa9qR4OsP/K/8NKMLS
zLMVOmNmOHOrHVA1mNVNjTN/nDOom5pyVc6BbQiQ56PpYvFy9tU0l6rBuc+KzrVl
WVbzyeTuAai6pSXAEMg4ePijsgUq4OMbLtR3vDD/joIAAAAASUVORK5CYII=
}]

set I(arrow-down-insens) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAAAwAAAAMCAYAAABWdVznAAAABmJLR0QA/wD/AP+g
vaeTAAAAqUlEQVQokc2QsQrCMBiErybBoaMmBgriE/yQtXZy8cWl4OLQ9gkUoSmW
Tjq0JjiJWoW6CN78fcdxwH+GiMJvGUZEoefjtZaL2trD+TMcK8+DlZbTPbPWdpGe
nRxziZrMm6o6vkjGGOmYS9DyNM93DQOAsiwvkda15375LBljZBcECVqRFsXWAkDQ
b7sDQrS+D78Jj71dAgCjq9hkWVoNHQKiWBHFahD8SW5gekeBcxjv0wAAAABJRU5E
rkJggg==
}]

set I(notebook-tab-top-hover) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAAAwAAAAWCAYAAAD0OH0aAAAABmJLR0QA/wD/AP+g
vaeTAAAACXBIWXMAAA3XAAAN1wFCKJt4AAAAB3RJTUUH4gwcCDYdrG65GwAAADxJ
REFUOMtjnHL+9X8GRgZiwBEGBobVLAxEAh1+ZpsrH/8KMBGr4crHvwwMDAw6RGuA
gVENoxpGNdBTAwB5kQsleWZcPwAAAABJRU5ErkJggg==
}]

set I(arrow-up-small) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAAAgAAAAICAYAAADED76LAAAABmJLR0QA/wD/AP+g
vaeTAAAAaUlEQVQYla2OMQqDQBRE32wu4hEWi+UTFcQjWIhXNKdIYSFWuVD220RY
MKVTvmEeA7cmWttHa/uSqSyV/QXgQdNnW98AAaBOTafsi/A5SKOyL3V6DgCKZpXy
Yy9Xp83DN/30Vl3/XNnfHBHGIM1zRfxVAAAAAElFTkSuQmCC
}]

set I(radio-checked-active) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAACXBIWXMAAA7EAAAO
xAGVKw4bAAACRElEQVQ4ja2Uu09UURDGf+fcl/s6AdyQ0KwsoEYrEkwoxXITI6Gn
siAxLH8Na0worOiJxmRLsdwYEioiShC3MSACuSxc977GYlmzhsda+DWn+eabOTPf
jBIRboBa2Tg2AAtTgz5wLVldJVTbPJyxtaqmklYElQVQyLlWuh6nUqtOFtdvFHq9
fVhoB2o1VfJszLhJKe9YxrEA8KOEZitKdv3Q0qLeehmZf36/eHpJ6PX2YSEMVSNr
6fHHI1l3OGMD0M2jVOc9CGLWv59FQSI7rivTXTG7q9gO1GrO1eNzowXX1oqvfpvP
foQfJgAY1+KecSgbj7lR46zt+RPnAavA7J+KapuHM0rx/mmpwHDG5uOPgK2TXyTp
332wNTwcvMWjYoaDIOZd8xQRnlQni+u6Q1DVMeMmwxmbb62ITyftSyIAcQpbx22a
rYjhjM2YcRNbq0UADahU0kop3+nqzklIlF5viTgVvpyEAJTyjiVIBUCvbBwbQWV7
p9MPXY5xLFIht9w4Mrpv1D9CL0wN+go5783SD73Va8XZ0vSQrwHRStebrY7SxICL
rdW1IrZW3B1wAWi2okSh6tBpNnEqtV0/tA6CmDt5hwcDHtYVn+6M36OUd9gPYnb9
0JJEatDj7FebP99kXVWZGzWOc60hXcrGJUqFtT0/Og+l/mLy9iz0ONvLyHwQ0ljb
8ydmRnJO2XiUjXdpRfaDmA8XK+JlZL4b//+XthcXZ2RRkEoq5AC04kyh6nEqL/ue
kauw3DgyAEvTQ/5NvN+JCTTAA9NELQAAAABJRU5ErkJggg==
}]

set I(arrow-right-prelight) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAAAwAAAAMCAYAAABWdVznAAAABmJLR0QA/wD/AP+g
vaeTAAAAl0lEQVQokY2STQrCMBCFZ+YQYnceJLXFGzQLf25oQdueQIpk5SncVXIH
81wVQkzSfsvHfDCPGaKAup92YeYj4fAX8lL9VK8SxqZ4g1gzpN13n0NM4FioOquY
cGfC5am3j0UhJ0lKMHpjwO4E4qvfKSmkSArVYEuGtEw4m6YY5zzaoRps6Rxuq0rn
hv+E+XBgd/TXyLL0Gj81HUnvHA7VsQAAAABJRU5ErkJggg==
}]

set I(entry-active) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAIAAAAC64paAAAACXBIWXMAAAsTAAAL
EwEAmpwYAAAAB3RJTUUH4gwbBTMW08Q/PAAAAI5JREFUOMvt1DEKwzAMBdD/nXgK
ZCilk+8R6NKzdynkHp5Kqe1AJjdVBoPXigQ65Y9CD6RBYogJW9MCyF95vD5+FqVx
Ha/n1hoyxHR/5pPl4PqG/CkXkdFP7yy3izUA/CxKCaAhB9eXMU0t6VetzQY7cuAD
/wUvInpTm025z9FPSl9O0nUEwBDTrmeweecVJRxBZzWVy/4AAAAASUVORK5CYII=
}]

set I(scale-slider-pressed) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAACXBIWXMAAA7EAAAO
xAGVKw4bAAAB60lEQVQ4jZ3Uv2sTYRzH8c/zPe5SL7VyydmYxgYpgkGymP7QSRBc
VIwScHdyiclf4Og/YGyGbu4FoVF0EYRs/b2UmoIUSZucifmBbe5sLt7zONhIqdc2
yXs8jhfP8v0wIQTcis5vKj5Jn5aYGAcAR7CdhlNb3nhy3Xb7nx2H7uaqAb+HMpoi
ZiY1SbvkpfMA8N3k+6tNp9m02VK9zdOf4qOVE6H4u8qjy8NSJnlNDoe8zPWlJVNg
dqtTLLWcdO5hYOE/KP6++jim01w6ooySu/EvLoBXX+zqes151sWYEAK339aCUQ2L
L28o42chR7EX63Zxo4lb+YRuEACMqWI2GZF7RgCAGJCMyOExL38NAHTnzbchv4di
IbUP5bCQyuBTpMn7H796iI94Z6YvMl/fymFTfvjNXxdukipjIjDERgaFgqo0rMqY
oEGB45HVwXblQOwNChiW07I62CbaM5eWf4jGoNBKHXXvuZ+L9PnplYN6m6+VLPeb
O62SJdCwndUP9662CQDKFnueLXR2eB8WF0C20CmWTUoBAAFAPqEbuy0nlSnY1V6w
7omULCeVT+gGMMDR7poc2a3fxbLlpBYeBHLd76fOSMwnaUH174wYFt9fa/Q4I0eL
zm8qfkWfIi7CAMCJFet2beWkYfsDShDtPvMkVksAAAAASUVORK5CYII=
}]

set I(entry-insensitive) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAABmJLR0QA/wD/AP+g
vaeTAAAAr0lEQVQ4je3VOw6DMBAE0Fk7RexLE+U43AgWOqC1XfBp8KRIEaWIFD4l
c4CnlUaalRATcWJuAEAS4zhiWRbkNW8CjDVwzsF7DxEBQkzs+oFVpUVZlnbrRSRt
XdfPrh8YYiJCTNSmJcnN2BeqDUNMNACQ1wwRWfeCIrIyv6swe5FfucALvMC/QWMN
jo6DsfIBnXNQ1WIPStKqto/73QMAJMREkpimCfM8Hx5YOfsFvADodGzDQoRaTAAA
AABJRU5ErkJggg==
}]

set I(scale-trough-horizontal) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAABmJLR0QA/wD/AP+g
vaeTAAAAe0lEQVQ4je3OsQ3CMBhE4btfEXVAViTYDdgi6RIpVJnDM3kFFyGgLBBd
OnqwO/wN8PSAovgaQwiH5+v9AHgFcP6xEyX6xtV9NS/rSLJNHLuQ6uZlhZG6JcY+
SN0NgHIFIWwm0efq0eCtcXUvcQIQE1pR4uROxyHXXPFXdjoTI/gtsBivAAAAAElF
TkSuQmCC
}]

set I(notebook-tab-top-active) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAAAwAAAAWCAYAAAD0OH0aAAAABmJLR0QA/wD/AP+g
vaeTAAAACXBIWXMAAA3XAAAN1wFCKJt4AAAAB3RJTUUH4gwcCDEHHk3WpgAAAE5J
REFUOMtjPH3mXB4DA4MxAwNDHAN+cISBgaGOhYGBIZSHl9dGQlwMr+oXL1/ZfPn8
OYOJgYGBoGIGBgYGqJowJgYSwaiGUQ2jGuipAQC32Q0l82twswAAAABJRU5ErkJg
gg==
}]

set I(radio-unchecked-insensitive) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAACXBIWXMAAA7EAAAO
xAGVKw4bAAAB0ElEQVQ4jZ3UPWvbUBTG8edcWS+2QErdJQrEhLpbuyYgCsZZ9GnS
LPkcWdx8GhOIMQVD0o4d1QYXbGdxrUuvLevtdGjSNg6q7fznq5+uQOcQM6Osy8+X
DWZtHwCYtWFw2PpedpZWoV6vZ7FDpwBOmcQLs2IkALDMEoO4+AGgQ5I77XY7LoWu
bq7esKZ1d2zH9eqeXTWqj16ySBYYT8dqpmREeR4cHx5/eQJ1P/Xe6oI+NnebrmM7
pZ8LAFJFCCdfI+TFuweMmBmDwaAam2nY3H3lrUP+YhLh3beRFVde+76/EACgjPTM
td21N/k3x3bg1pwdZaRnACAAkCZwslf3ahsr9+3VvZoQOAFAonvdPyCQbRnWtg4s
w4IA2d3r/oEgyhtGxcy2Vu4zdTMjyhviucBqglkbJtmy8lxgmS4rzNpQBEetWwar
OInXP7VSnMTgolDBUetWAOC8wMVoOp5vC42m43kOugDAAgDsRD+P5nImldwYkUoi
msuZnejnwO//CL7vL5BlQTgJI6miDZAI4SSMkGWB7/sLoGxoa47rvSwb2snPmYpk
6dA+9GeNMN6zEHVT01MAWOapTkUxBaFDkj/8d42s1r3p7xPlDWD9YvsFyxztnCzd
QMEAAAAASUVORK5CYII=
}]

set I(checkbox-unchecked-pressed) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAACXBIWXMAAA7EAAAO
xAGVKw4bAAAAB3RJTUUH4wIBDBwOlq1+twAAAB1pVFh0Q29tbWVudAAAAAAAQ3Jl
YXRlZCB3aXRoIEdJTVBkLmUHAAAAu0lEQVQ4y+2TsQrCUAxFT9r6aKXoIC4OboKu
fob/W/wVXcSuShGftoKtjcNz1Va6OBjIeE/uJQl0LAE42ouu0wJbgkizSBViH1bT
iABgnd6Y9W4sJjFhFKHoR4AnwiYrSNIcD8BWsBjHBGFEWStVzce+P5T5qE+uvgMI
uMmqrbPXqgg4ANBo+22crlv4A34GoK/z/E4oTgfuMbZZgfGFwKOxjSfsziUDI+4b
Dyeryf5Kjk8bH6owNMLSWJ75pEsmp8tTfgAAAABJRU5ErkJggg==
}]

set I(arrow-down-small-prelight) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAAAgAAAAICAYAAADED76LAAAABmJLR0QA/wD/AP+g
vaeTAAAAbklEQVQYlY2OMQqDUBBEZ34uoZ2nSLXFXkELwSuKyd4gBLHyIgu5QvCv
laCF8F/5YB4DlKDmzZ2jmjdbpDWY+6WtvwAg5spI44P5SQCQ90+IeBExMKV/zjER
Mcxd9eGRPFYAcK5dEHMVcy06XswOlbsrCjnZZ+UAAAAASUVORK5CYII=
}]

set I(arrow-up-prelight) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAAAwAAAAMCAYAAABWdVznAAAABmJLR0QA/wD/AP+g
vaeTAAAAj0lEQVQokcWPsQ3CQBAEd48mIHMVRG/8ogMcIFOiEfhdAUKIiEYefQ/8
OUMv65DIvNndzul2gUXkQvQuRG95tGCqnAFAmY/Pw+Ze+lIOzZhqqvSEdgq2VOl3
w3tvfmjGVOesF0JPj3Z9AwA3JEfotdzxF/yNODuiD7H6qLysvPNeK+YtAMCHWFlg
qX+YhTQBvQ9IOfBgFW4AAAAASUVORK5CYII=
}]

set I(arrow-up-small-prelight) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAAAgAAAAICAYAAADED76LAAAABmJLR0QA/wD/AP+g
vaeTAAAAbElEQVQYla2OsQ2DQBAEZ48qyKjC0WO/6MAOLFqEgHcJDhzRyCN6MEdk
6WURMuGsdrVwKiHlGFKOpVMZym0EcG3Pz71+AxjA7bW2chuE944echuu09IBKKbc
fN3msvVbq7RdAIgpN/9/jtwhO3iRKDdemFwMAAAAAElFTkSuQmCC
}]

set I(button-hover) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAABmJLR0QA/wD/AP+g
vaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4gwZFwkmZR9ufAAAAKdJ
REFUOMtj3P/qFc/HD0x7Xn//a/rjLwMTAwmAk5nxrwgn02l+gX+ujBtuvTkuxMpo
oSvIwkAOuPj+L8Prbz/OMr3+/teMXEMYGBgY9AWZGd7/YTFkItU72MDPv/+ZKDYE
BkYNGjVomBrEycz4l1JDOJgZ/jGJcDKdPv/2F9mGnHv7i4H//49LjPtfveJ58/rP
gQ9/mA1JLQk4mBn+8f7/ebkjKyIBAGQhPa+gMClkAAAAAElFTkSuQmCC
}]

set I(radio-checked) [image create photo  -data {
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
}]

set I(scrollbar-trough-horiz-active-old) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAADgAAAAUCAYAAADY6P5TAAAABmJLR0QA/wD/AP+g
vaeTAAAAy0lEQVRYhe3TuwrCQBAF0DsTQxQNsfHV24mSD7CwzT9bWPgBabRKaaGC
jyCCGDdro5IoFkI0BuZ0O9PcyzKAEEII8RY9D1x3VEfp1INhOFrHnEeoTxFxDKVC
XMoz35/skzsj+eh6nmWej0MQVQH9Uv5/aQJRBYbq2IP+YhsE6r5J/ZC9DNsAzJ/n
y47prA+t5CBVkJn1b/N8X6pg2LRXAKKcsmQhunV4SN3gNghUp9HdEKsaMVtFuUMi
jknrHUWWP5+Oj3nnEUIIURhXog40I5tPlhsAAAAASUVORK5CYII=
}]
set I(scrollbar-trough-horiz-active) [image create photo  -data {
R0lGODlhOAAUAIABAK+vr////yH+EUNyZWF0ZWQgd2l0aCBHSU1QACH5BAEKAAEA
LAAAAAA4ABQAAAIvjI+py+0Po5y02ouz3rz7LwHiSJbmiabqyrbuC8fyTNf2jecr
yPf+DwwKh8QirwAAOw==
}]

set I(notebook-client) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAAB4AAAAeCAYAAAA7MK6iAAAABmJLR0QA/wD/AP+g
vaeTAAAACXBIWXMAAA3XAAAN1wFCKJt4AAAAB3RJTUUH4gwcCB0t/Md03gAAAEJJ
REFUSMft1zERACAMxdAPhxPq3wgcClot4IGhXRIDb05b+1wVNCTJbKai7qGuooCB
gYGBgYGBgYGBgT/fyT3S4Qf5IQk5B+vqwwAAAABJRU5ErkJggg==
}]

set I(button-toggled) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAABmJLR0QA/wD/AP+g
vaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4gwaCRkSCmSpDAAAAHxJ
REFUOMvt08ENgkAUhOGZF8MZzYYAvSld6A0TPVHH1rQlsAdAQgdjA17c9WT4Cvjz
5vAYQijm1/oEeAbQ4DtRoq9c2R+mZXuQvCJNS+o2LRuM1AWZSHWWMOeT2vAje2gP
/W8oZleE0ST67O83eKtc2UscEi+LEgd3Ot7f3IokEHPMb7oAAAAASUVORK5CYII=
}]

set I(treeview) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAAB4AAAAeCAYAAAA7MK6iAAAARElEQVRIx+3XsRUA
EBAE0eWpQSTSf0sucQlN0IPAJTMN/HjSmOsooCJJvdWvqPlWVlDAwMDAwMDAwMDA
wMCP72S+v8MXvT4JlNhEZUMAAAAASUVORK5CYII=
}]

set I(checkbox-unchecked-active) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAACXBIWXMAAA7EAAAO
xAGVKw4bAAAAB3RJTUUH4wIBDAwy8wAQYQAAAB1pVFh0Q29tbWVudAAAAAAAQ3Jl
YXRlZCB3aXRoIEdJTVBkLmUHAAAAdUlEQVQoz2N8++nTjsc/3v38z0AICLAweMpy
MC698kqK8ZumCCc3Nzd+DVfffL314S/Tu1//iVHNwMCgLcL98R8zEwMDAzGq4YCJ
gUQwqmGoahBgYbj25isxSu98+C3IxsD45v3HbQ+/fvzHTFCDEBuDIesnAE3cJiD1
JFxnAAAAAElFTkSuQmCC
}]

set I(arrow-right) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAAAwAAAAMCAYAAABWdVznAAAABmJLR0QA/wD/AP+g
vaeTAAAAnklEQVQokWNgQAMGFhYK6GLIgAldMeM/5lMGFjYOuDQwI3NePHnyQVpG
/jjD//+rpaRlzz1/+vg+Xg0MDAwMz58+eiQtI3/iPwPDKmyaMDQQ0oRVA0yThKz8
GYb/DCslZOVPv3jy6AEDA5qniQGMuCSMzKxt/zMwrGFk+B957tSxfXg14FKMVQM+
xRgaYBH3n4kx7MKJIweI8BLhpAEAP1hOKHR1it8AAAAASUVORK5CYII=
}]

set I(book-tab-top) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAAAwAAAAWCAYAAAD0OH0aAAAABmJLR0QAywDMAM6D
7+ImAAAACXBIWXMAAA3XAAAN1wFCKJt4AAAAB3RJTUUH4gwcCQIb/+WF7gAAADlJ
REFUOMtjPH3m3H8G4sCFp8+edjARqZiBh5dXhYGBIYdoDV8+f+ZhYGCwIVoDDIxq
GNUwqoGeGgAWkgtw6lHz0gAAAABJRU5ErkJggg==
}]

set I(scrollbar-slider-horiz-active) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAAB4AAAAUCAYAAACaq43EAAAABmJLR0QA/wD/AP+g
vaeTAAAAeUlEQVRIie3SMRKCMBBA0b8ZBvqYRu6G3kI7dOAoORNXoEL6OOMsDXoC
k4Z9F/jNB2PMn8hzmurTO4woHXDO3JsV4tosfeVTGIBb5uBXK3D3KeAELoWiPwJX
B2jpMPBxCrF8V2O1NkvvU0CgA9rMxX2u1yNzx5gj2QA2vRzmr3lMjwAAAABJRU5E
rkJggg==
}]

set I(entry-focus) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAIAAAAC64paAAAABmJLR0QA/wD/AP+g
vaeTAAAAtElEQVQ4je3UPQ6CQBCG4W+WHyWxwkZKY6LXMNzCxHA3KfQS6j0o1FJs
XGgkgLtjQyhsWEnsePsnmeYbklmOvtkAas37qzo/lCy5E/guhYHYzG1HEMksjy/1
ZOxul55F1IkVc5wUr7KKFo4AcEq1oQRgEUUr75hqAAKALNlQtj4rucG9G/CA/499
lxR3j7FNMU9H1OAwEHFSGHrFvEuK9UwAIJnltebD7X2+62f1+zMwP/irDwMNTWK1
SHt+AAAAAElFTkSuQmCC
}]

set I(labelframe) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAAA8AAAATCAIAAADAoMD9AAAABmJLR0QA/wD/AP+g
vaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAAB3RJTUUH4gwbBS0PY+6oIwAAAB1p
VFh0Q29tbWVudAAAAAAAQ3JlYXRlZCB3aXRoIEdJTVBkLmUHAAAALElEQVQoz2M8
cOgIA9GAhYGBQV9PlxilFy9dZmIgBYyqHlU9tFSzQJI5kaoBtHEH5h1zTEYAAAAA
SUVORK5CYII=
}]

set I(scrollbar-slider-vert) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABQAAAAeCAYAAAAsEj5rAAAABmJLR0QA/wD/AP+g
vaeTAAAAmElEQVRIie3WsQ3CMBCF4d9gMQB2ATNkH7rAFkAVJBglHftkBKgSBogs
jsoSCslJQHuvuye9z60dSoprs1jO4wVHCYiDuktt1WyKfmrjNTD4eBbY51vgEHwE
OE5tZhoosB3pdtpGBYH1SLf6B/w6BhpooIEGGmhgzn1YOLj9DDqoh90T+ejeo/5t
utRWwUcEyvzAI3UnbfMCMEIfS/u3nUUAAAAASUVORK5CYII=
}]

set I(radio-unchecked-pressed) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAABmJLR0QA/wD/AP+g
vaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAAB3RJTUUH4wIDBCYaDcTtgAAAAj9J
REFUOMutk81OE0AURs+dKbRNW2gViohGYgsbWIgkSpQlCW9A2LISwTdw6yOI4kqX
hDcgYacSNIFu0AUUglEMf7GFtimFzlwXimKwCIl3OfPlzOTmfPCfRmpdTGR2ZXt9
xVzrvVNXKu6FItHGgy8L74+S7R1+vKdJzwWayOwkRWTIiI6K0KUIgqLKB68yiTI9
1tO0XRP05M1H0xRv7cNVX0XrpCMVsySDQr2BQw/bFSVbcJSqLIuxI7v5r/OP+7s8
QOAkqCne2me8m22P2vDthCUYAK+gCiKQDAkdEcNiznWul9zs5fjVAWDujx89X8on
xVXfpmIm3d9sqTjQGksNWni941gr+KzawP2H3fFt8yvh3XA0QPpWojYEfpxXHPQk
LNEAadQNAxiADVVjVB+lYpaQrQ05CQtZSMUsBh3fUDUGYGbtKKyiHS1hwfnzeeM8
tIQFVTpnVqthA5DfK0RAqJeLSXicz+/vRwxAvDFWAuVQLwY6zscbGkoGYPBmXVlU
VrbKijXng1gDW2VFhOXBVKBsANpEvBd5ulpwHLgzenNCgQMHqwWHRybaRPzv942d
KlbJZnKOoK0NO/Yok3MUq2QRO3WqIpNLuXvGu9n2iPmr2UagUoXFvGe96Mre2IHR
7sTcqYp829ucv9TYMrBadC+3Kr4zXaNrxSNdxtqR3N7m/D/av5sU0SFjeCBIt/4M
KrrkPS9UZXr8rPafnGeZHdn8lDXXe+/WlQr5UCQWP/i88O7oyo20H+tpPiXKd1TW
/hYSGTZ9AAAAAElFTkSuQmCC
}]

set I(checkbox-checked) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAACXBIWXMAAA7EAAAO
xAGVKw4bAAAAB3RJTUUH4wIBDAIJ3IjUywAAAB1pVFh0Q29tbWVudAAAAAAAQ3Jl
YXRlZCB3aXRoIEdJTVBkLmUHAAAAg0lEQVQoz2N8+eFTxZkfdz79ZyAEFLgZekw5
GBN3v7Ll++alwMnNzY1fw9b7X7c++ct05/N/YlQzMDB4K3I/+M7MwsDAAFHttesr
HtXb3KAmMjGQCEY1DA4NLJhxScAGRW6Grfe/EqN017PfKjwMjC/ffSw5+fXBd2aC
GlR4GIrlPwEARYApx4EpM+MAAAAASUVORK5CYII=
}]

set I(button-active) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAACXBIWXMAAAsTAAAL
EwEAmpwYAAAAB3RJTUUH4gwZFx8h5+NOCAAAAH5JREFUOMtj3PH4o9C9B8/fvvvy
nYEcIMTDyaCkICnMOO3wjf+/2HkYWNjYyTLoz6+fDGw/vzAwvfvynWxDGBgYGFjY
2BneffnOwMRAJTBq0KhBowbRySAhHk6GP79+km3An18/GYR4OBlY/vEKM7J9fvv/
3dvXZBdsS1pLzQDAwie4f6eltwAAAABJRU5ErkJggg==
}]

set I(scale-slider-active) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAACXBIWXMAAA7EAAAO
xAGVKw4bAAAB1klEQVQ4jZ3UzU4TURwF8HPvTMcZ+6FlahtEGkJYGXRhtfAA7vUR
jDFdOfgIhkcQ3Ggw8RV071qmihsIK0LIIDYdGUhnWmeYj/t3oTUEp7XOWd7c/HJz
k3MYESEtq7tQ9NC+xzifBQAS4tBRqp+e30SYdp9dhF7s2LUyl9dUCc0ZlZULOVYE
gH5E3lFAp0GC9qmIV54tVrsjoY3t7oOrSm6tqUv1Uo6lvtSNCOZxYvWiaOXJrdq7
v6A32/bD65flV8u6XGXpxp8QAR+dyP72I24NMUZEeL11PF0ucPN+TZ79F3Ie+9CN
rZO+WG41Kh0OAKrKXi7p0sQIADAGNHWprqlsHQD424MDVZPYnVF/Mi6lHIMqscb6
3t4lPvDyzRt5NvXfyu/MaNC5f2VJVsDnCzIrZYWKilRQQPM8K3AxPITY78fkZgW8
MOmHEPs8Xxy0vw7oJCt05MMRWs/kj+bmAj+hL26U3rlxcSNCkNCWsbBwxgEgCOip
6SSHI/qbGiKg7SSWH5ABABwAWo1KpxdGxqYT25Ngw4q4Z8JoNSodIEtpQ4LpJJYX
CuPx7cr74fnYGZnWWLkk/5oRNyav4084I+ezugvlWmjfJc7rAMCEsL4r1c+jhu0n
CiLrBWDiM9IAAAAASUVORK5CYII=
}]

set I(checkbox-checked-active) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAACXBIWXMAAA7EAAAO
xAGVKw4bAAAAB3RJTUUH4wIBDAQrX7IyqQAAAB1pVFh0Q29tbWVudAAAAAAAQ3Jl
YXRlZCB3aXRoIEdJTVBkLmUHAAAAg0lEQVQoz2N8++nTjsc/3v38z0AICLAweMpy
MC698kqK8ZumCCc3Nzd+DVfffL314S/Tu1//iVHNwMCgLcL98R8zCwMDA0T1gltf
8ahOUIOayMRAIhjVMDg0sGDGJQEbBFgYrr35SozSOx9+C7IxML55/3Hbw68f/zET
1CDExmDI+gkA5sQptXv45EgAAAAASUVORK5CYII=
}]

set I(scale-slider-insensitive) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAACXBIWXMAAA7EAAAO
xAGVKw4bAAAB3UlEQVQ4jaXUPW/TUBQG4Pdef1wbxxVO+FANjaBiYgICKUtQqg5R
J1j6F5hIf0xh4TdkokvFUBEpUwpBTJ1QBSl1RCExSmLs66/LUCJVxYE0vOPV0aOj
K52XCCGQlcZ+Q73489IDCrIEACnE4Y8L399u3N4Is+bJWWi3vXuVadqWROWyoZsW
k1UTAHgcjjx/5CZpvMeDYHNtZe3rVOjNh9ZjTWJbdt4uMpllbspjjqOB0+UJ31y9
U3n1B9TstJ6YuvnSzttXCCGZyCRCCDgD53gYjp5OMCKEwOtOa9FUWfvm5RtL/0JO
Y5++fe4Ow+BhrVTpUQDQqfziumXPjAAAIQTXrMWiLkvPAYA2m01NlaV7qpL9J3+L
qjAoVCrtfNxhNDTSck5fyJ9b+Z2cZhYkl61QGXRZlZSFeSGmsJwMukznBc6GxkgP
wiQazgvwiI9jpAdU9eje2B8O5oXGwaifWLxNq9VqEMbJ+zDi50bCiCNKk876rXVO
AcBP42dfXOdw2gFnRQiBI7fX9eOkDgAUAGqlSo8nvO4MnONZsMmJBLFfr5UqPeB/
jjYO6qt3H21P3qfXCJHLhm5YTNFOaiQKRp7vuYmYoUZOp7HfUAte4b4gtHgymHb7
Rv/dtGL7BV8I9DcQv8E/AAAAAElFTkSuQmCC
}]

set I(scrollbar-slider-horiz) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAAB4AAAAUCAYAAACaq43EAAAABmJLR0QA/wD/AP+g
vaeTAAAAfElEQVRIie3NsRHCMBAAwXtZQwFICW6BmgxdmMzMQCnK6IcWHFlUIHgH
DFSAlPCbXHhgjPkR2d/um20XrwgDsKv8mwVSLsvkg48XhbHy8KNXOAUfcQqHRtMv
haN7ty2BpxNIrccvNPlclin4iMIA9JWfs0B6lHyu/DHmn6xkVh1tCWue8gAAAABJ
RU5ErkJggg==
}]

set I(button) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAABmJLR0QA/wD/AP+g
vaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4gwZFwoSb4bJCgAAAKRJ
REFUOMtjfPXqFc/T5y/2fP36zfTPnz9MDCQAFhaWv1zc3KdlJMVdGc9dvHycj5fH
QlhIiIEc8PLVa4aPnz6dZfr29asZuYYwMDAwiIuJMvz+9duQiVTvYAN//vxmotgQ
GBg1aNSgYWoQCwvLX0oNYWVh+cfExc19+tnz52Qb8uz5cwZmZqZLjK9eveK5/+jJ
gd+/fhmSUbD9Y2RiulxaVJAAAKKnPtVz7xSlAAAAAElFTkSuQmCC
}]

set I(button-empty) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAABmJLR0QA/wD/AP+g
vaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4wUbFTYKYNiFkgAAACBJ
REFUOMtjfP/h438GKgAmBiqBUYNGDRo1aNSgwWIQAOWDA/P8dVDBAAAAAElFTkSu
QmCC
}]

set I(radio-checked-pressed) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAABmJLR0QA/wD/AP+g
vaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAAB3RJTUUH4wIDBCcWHWmQ6gAAAtlJ
REFUOMutk0FvG2UQhp8Z76537dZOoY6slFONahsQOUCLiAoCKb+BXDlCAImfglQI
Pfaac6+RKkEURASHIMAOrYtUUcuKC42T2Gv7W3/DwahKRQMcmOs7ejQz7zvwP5Wc
JXz2XU/CyUDjc5WYXJwwG6fjk/7Y5cv+09er9p9An+/9sZgT1hS/blhj3mYI0vbo
xszY/Hj5uYMzQTe+/1nDqLpi3m6VIqldWchTTQJiVcbe00szfjmccDS1jqi876a9
nU9ee8kDBKdBYbi4othWrRzlr1ZiVCDNDG9GrEKzHFEvRez209r9E7cVhourwPZT
E238eLQoM7dzpRzV3lkq8HDo+OnxmO5oxnTmiXLKUiHHyxdiLhVD7nSH3B24juXC
lfVXSgf6ZEefrZ2PpHa1EvNwmPFVb0R7MGXoPJnB0Hn2B1O+7o3ojjKuVRLOR1LD
u/fMTBTgvpkqfr2+kCcnQvtwwqNxRiiCynxsFQhE6KcZrccTciLUF/IEwnob5qBv
7rkEaFSTgHTm6Q4dekYyVITu0JHOPNUkwLDmdtvlFWAwOCqAEKvgDabekDMSJjLX
vUGsgpkwOjoqKkC5XBqBMfaGCkQqmD0bZDbXVWDsDRGjUCoNFeDNF8MUaPfSjCSn
LBVDPM8meTOWiiFJTumlGYK0rjfCiQJcFvEe3dg/nDAzo7GQ52Ic4Gy+ggHeIDOj
kgQ0L+TJzNg/nOA9Gw2wJ/abBpvHU+vs9lMuFQPerhZolCOKoRIIFEOlXs7zVrXA
UiFgt59yPLUOGm6KiD110ps/PLquKluXz4X5a5XkVLLn9ieBMjNjt5/y64mbeG+r
H7x6cRtAT4OcO9jxJqt3B65z+8ExrcH0LwOEsTdagwm3Hxxzb+A63mTVuYOdf/1+
xdYCsQ9NaJrNbRejlZl86ZF//v7T9cXe7/Lb/p4233g3Gh2mhcJCMmp9e2f6Qn3Z
f7T8/N8s/ROMRWFi0Fb5jQAAAABJRU5ErkJggg==
}]

set I(checkbox-checked-pressed) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAACXBIWXMAAA7EAAAO
xAGVKw4bAAAAB3RJTUUH4wIBDBc1xFJOWAAAAB1pVFh0Q29tbWVudAAAAAAAQ3Jl
YXRlZCB3aXRoIEdJTVBkLmUHAAAA40lEQVQ4y+2TQU4CQRBFX3W3PdOTji7YsXAn
ypZjeAwO5i0IB/AS6sI4WwkhtjCEQCgXjSyIwiS4tLaV/1K/6hecWQIwSZ86rhvS
GkROi1QhWri/DjiAcb3k5mJJvxspQ0DRowAjwtO0YVQvMiBtoN+N2DIwW21PTlA5
uOtUPE52AAHKkMUPL3MK87uP1VYZ9iLeZp3b+9qNXRihsNJ6iebcK/wD/gDgfrrz
sTrsu5yBHM/KwbAXWyRRMAj6DYgWnqcNt50Kb9v4Fl4/1lx6yd/4Pks6epuzwNIm
g6pw5YWBT3wBuVpCx5tbUFkAAAAASUVORK5CYII=
}]

set I(checkbox-unchecked) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAACXBIWXMAAA7EAAAO
xAGVKw4bAAAAB3RJTUUH4wIBDAo31TBDaAAAAB1pVFh0Q29tbWVudAAAAAAAQ3Jl
YXRlZCB3aXRoIEdJTVBkLmUHAAAAdUlEQVQoz2N8++7dgoWLXrx4wUAIiIuKxSfE
Mfb2T1BXUzUxMeHm5sav4dTp02fOnmN68eIFMaoZGBjMTE3fvH7NxMDAQIxqOGBi
IBGMahiqGsTExE6dPk2M0vMXLkiIizO+fvNm3vwFb968IahBQkLC08MdAHjMJVak
DqSJAAAAAElFTkSuQmCC
}]

set I(scale-trough-vertical) [image create photo  -data {
iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAABmJLR0QA/wD/AP+g
vaeTAAAAlElEQVQ4je2UMQ7CMBAEdyNEbSkhgjf4TQm/AKogwVPyJj8hFMZErmmO
KhIiyUmEEm93I824M6HMObe+P/orwAqAiLAtC9NYa59zzkoL+hAvJA/DTcrRhwgA
pzkn04Kk1BNsrzlqEMBugm1/CX69FEzBFPyP4G1EBN3ioAjbT8YMI/Y+9ccuC9P4
EEFKNTywyc1Zc1507iXaqPFxfAAAAABJRU5ErkJggg==
}]

set I(radio-unchecked-active) [image create photo  -data {
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
}]
#Загрузка из png
if {0} {
    proc LoadImages {imgdir} {
        variable I
        foreach file [glob -directory $imgdir *.png] {
            set img [file tail [file rootname $file]]
            set I($img) [image create photo -file $file -format png]
        }
    }

    LoadImages [file join [file dirname [info script]] Breeze]
}


#For Android
set iw 0
set existtlf [info exists ::typetlf]
#Запоминаем сколько пикселей в 1 мм
set ::px2mm [winfo fpixels . 1m]

if {$existtlf && $::typetlf} {
#Для Android
    set iw [expr [image width $I(radio-checked-active)] * 2]
    set upz 1
    if { $::px2mm > 15} {
	set upz 4
    } elseif { $::px2mm > 10} {
	set upz 3
    } elseif { $::px2mm > 5} {
	set upz 2
    }

    foreach index [array names I] {
	scaleImage $I($index) $upz
    }
        ttk::style element create CheckbuttonMY.indicator image [list $I(checkbox-unchecked) \
                disabled            $I(checkbox-unchecked-insensitive) \
                {pressed selected}  $I(checkbox-checked-pressed) \
                {active selected}   $I(checkbox-checked-active) \
                {pressed !selected} $I(checkbox-unchecked-pressed) \
                active              $I(checkbox-unchecked-active) \
                selected            $I(checkbox-checked) \
                {disabled selected} $I(checkbox-checked-insensitive) \
            ] -width 22 -sticky w -padding $iw
        ttk::style element create RadiobuttonMY.indicator image [list $I(radio-unchecked) \
                disabled            $I(radio-unchecked-insensitive) \
                {pressed selected}  $I(radio-checked-pressed) \
                {active selected}   $I(radio-checked-active) \
                {pressed !selected} $I(radio-unchecked-pressed) \
                active              $I(radio-unchecked-active) \
                selected            $I(radio-checked) \
                {disabled selected} $I(radio-checked-insensitive) \
            ] -width 22 -sticky w -padding $iw
    ttk::style layout TRadiobutton {
	Radiobutton.padding -sticky nswe -children {RadiobuttonMY.indicator -side left -sticky {} Radiobutton.focus -side left -sticky {} -children {Radiobutton.label -sticky nswe}}
    }
    ttk::style layout TCheckbutton {
	Checkbutton.padding -sticky nswe -children {CheckbuttonMY.indicator -side left -sticky {} Checkbutton.focus -side left -sticky w -children {Checkbutton.label -sticky nswe}} 
    }

        ttk::style element create HorizontalMY.Scrollbar.trough image $I(scrollbar-trough-horiz-active) \
        -border {6 0 6 0} -sticky ew
        ttk::style element create HorizontalMY.Scrollbar.thumb \
             image [list $I(scrollbar-slider-horiz) \
                        {active !disabled}  $I(scrollbar-slider-horiz-active) \
                        disabled            $I(scrollbar-slider-insens) \
            ] -border {6 0 6 0} -sticky ew

        ttk::style element create VerticalMY.Scrollbar.trough image $I(scrollbar-trough-vert-active) \
            -border {0 6 0 6} -sticky ns
        ttk::style element create VerticalMY.Scrollbar.thumb \
            image [list $I(scrollbar-slider-vert) \
                        {active !disabled}  $I(scrollbar-slider-vert-active) \
                        disabled            $I(scrollbar-slider-insens) \
            ] -border {0 6 0 6} -sticky ns

        ttk::style layout Vertical.TScrollbar {
            VerticalMY.Scrollbar.trough -sticky ns -children {
                VerticalMY.Scrollbar.thumb -expand true
            }
        }

        ttk::style layout Horizontal.TScrollbar {
            HorizontalMY.Scrollbar.trough -sticky ew -children {
                HorizontalMY.Scrollbar.thumb -expand true
            }
        }
} else {

    ttk::style theme create Breeze -parent default -settings {
        ttk::style configure . \
            -background $colors(-bg) \
            -foreground $colors(-fg) \
            -troughcolor $colors(-bg) \
            -selectbackground $colors(-selectbg) \
            -selectforeground $colors(-selectfg) \
            -fieldbackground $colors(-window) \
            -font "Helvetica 8" \
            -borderwidth 1 \
            -focuscolor $colors(-focuscolor) \
            -highlightcolor $colors(-checklight)
        ttk::style map . -foreground [list disabled $colors(-disabledfg)]
#MY
	    ttk::style map . \
		-background [list disabled $colors(-frame) active $colors(-lighter)] \
		-foreground [list disabled $colors(-disabledfg)] \
		-selectbackground [list !focus $colors(-darker)] \
		-selectforeground [list !focus white] \
		;
        #
        # Layouts:
        #
        ttk::style layout TButton {
            Button.button -children {
                
                    Button.padding -children {
                        Button.label -side left -expand true
                    }
                
            }
        }

        ttk::style layout Toolbutton {
            Toolbutton.button -children {
                    Toolbutton.padding -children {
                        Toolbutton.label -side left -expand true
                    }
            }
        }

        ttk::style layout Vertical.TScrollbar {
            Vertical.Scrollbar.trough -sticky ns -children {
                Vertical.Scrollbar.thumb -expand true
            }
        }

        ttk::style layout Horizontal.TScrollbar {
            Horizontal.Scrollbar.trough -sticky ew -children {
                Horizontal.Scrollbar.thumb -expand true
            }
        }

        ttk::style layout TMenubutton {
            Menubutton.button -children {
                Menubutton.focus -children {
                    Menubutton.padding -children {
                        Menubutton.indicator -side right
                        Menubutton.label -side right -expand true
                    }
                }
            }
        }
        
#MY for Treeview
if {0} {
        ttk::style layout Item {
            Treeitem.padding -sticky nswe -children {
                Treeitem.indicator -side left -sticky {} Treeitem.image -side left -sticky {} -children {
                    Treeitem.text -side left -sticky {}
                    }
                }
        }
}
        #
        # Elements:
        #

#MY
if {0} {
        ttk::style element create ButtonORIG.button image [list $I(button) \
                pressed     $I(button-active) \
                {active focus}       $I(button-active) \
                active      $I(button-hover) \
                focus       $I(button-focus) \
                disabled    $I(button-insensitive) \
            ] -border 3 -sticky ewns
}
        ttk::style element create Button.button image [list $I(button) \
                pressed     $I(button-active) \
                {selected active}       $I(button-active) \
                active      $I(button-active) \
                !active      $I(button-hover) \
                selected       $I(button-focus) \
                disabled    $I(button-hover) \
            ] -border 3 -sticky ewns

        ttk::style element create Toolbutton.button image [list $I(button-empty) \
                {active selected !disabled}  $I(button-active) \
                selected            $I(button-toggled) \
                pressed             $I(button-active) \
                {active !disabled}  $I(button-hover) \
            ] -border 3 -sticky news

        ttk::style element create Checkbutton.indicator image [list $I(checkbox-unchecked) \
                disabled            $I(checkbox-unchecked-insensitive) \
                {pressed selected}  $I(checkbox-checked-pressed) \
                {active selected}   $I(checkbox-checked-active) \
                {pressed !selected} $I(checkbox-unchecked-pressed) \
                active              $I(checkbox-unchecked-active) \
                selected            $I(checkbox-checked) \
                {disabled selected} $I(checkbox-checked-insensitive) \
            ] -width 22 -sticky w -padding $iw
        ttk::style element create Radiobutton.indicator image [list $I(radio-unchecked) \
                disabled            $I(radio-unchecked-insensitive) \
                {pressed selected}  $I(radio-checked-pressed) \
                {active selected}   $I(radio-checked-active) \
                {pressed !selected} $I(radio-unchecked-pressed) \
                active              $I(radio-unchecked-active) \
                selected            $I(radio-checked) \
                {disabled selected} $I(radio-checked-insensitive) \
            ] -width 22 -sticky w -padding $iw

        ttk::style element create Horizontal.Scrollbar.trough image $I(scrollbar-trough-horiz-active) \
        -border {6 0 6 0} -sticky ew
        ttk::style element create Horizontal.Scrollbar.thumb \
             image [list $I(scrollbar-slider-horiz) \
                        {active !disabled}  $I(scrollbar-slider-horiz-active) \
                        disabled            $I(scrollbar-slider-insens) \
            ] -border {6 0 6 0} -sticky ew

        ttk::style element create Vertical.Scrollbar.trough image $I(scrollbar-trough-vert-active) \
            -border {0 6 0 6} -sticky ns
        ttk::style element create Vertical.Scrollbar.thumb \
            image [list $I(scrollbar-slider-vert) \
                        {active !disabled}  $I(scrollbar-slider-vert-active) \
                        disabled            $I(scrollbar-slider-insens) \
            ] -border {0 6 0 6} -sticky ns

        
        ttk::style element create Horizontal.Scale.trough \
            image [list $I(scrollbar-slider-horiz) disabled $I(scale-trough-horizontal)] \
            -border {8 5 8 5} -padding 0
        ttk::style element create Horizontal.Scale.slider \
            image [list $I(scale-slider) \
                disabled $I(scale-slider-insensitive) \
                pressed $I(scale-slider-pressed)\
                active $I(scale-slider-active) \
                ] \
            -sticky {}
            
            
        ttk::style element create Vertical.Scale.trough \
            image [list $I(scrollbar-slider-vert) disabled $I(scale-trough-vertical)] \
            -border {8 5 8 5} -padding 0
        ttk::style element create Vertical.Scale.slider \
            image [list $I(scale-slider) \
                disabled $I(scale-slider-insensitive) \
                pressed $I(scale-slider-pressed)\
                active $I(scale-slider-active) \
                ] \
            -sticky {}

        ttk::style element create Entry.field \
            image [list $I(entry) \
                        {focus !disabled} $I(entry-focus) \
                        {hover !disabled} $I(entry-active) \
                        disabled $I(entry-insensitive)] \
            -border 3 -padding {6 8} -sticky news

        ttk::style element create Labelframe.border image $I(labelframe) \
            -border 4 -padding 24 -sticky news

        ttk::style element create Menubutton.button \
            image [list $I(button) \
                        pressed  $I(button-active) \
                        active   $I(button-hover) \
                        disabled $I(button-insensitive) \
            ] -sticky news -border 3 -padding {3 2}
        ttk::style element create Menubutton.indicator \
            image [list $I(arrow-down) \
                        active   $I(arrow-down-prelight) \
                        pressed  $I(arrow-down-prelight) \
                        disabled $I(arrow-down-insens) \
            ] -sticky e -width 20

        ttk::style element create Combobox.field \
            image [list $I(entry) \
                {readonly disabled}  $I(button-insensitive) \
                {readonly pressed}   $I(button-hover) \
                {readonly focus hover}     $I(button-active) \
                {readonly focus}     $I(button-focus) \
                {readonly hover}     $I(button-hover) \
                readonly             $I(button) \
                {disabled} $I(entry-insensitive) \
                {focus}    $I(entry-focus) \
                {focus hover}    $I(entry-focus) \
                {hover}    $I(entry-active) \
            ] -border 4 -padding {1 1}
#LISSI
#             -border 4 -padding {6 8}

        ttk::style element create Combobox.downarrow \
            image [list $I(arrow-down) \
                        active    $I(arrow-down-prelight) \
                        pressed   $I(arrow-down-prelight) \
                        disabled  $I(arrow-down-insens) \
          ]  -border 4 -sticky {}

        ttk::style element create Spinbox.field \
            image [list $I(entry) focus $I(entry-focus) disabled $I(entry-insensitive) hover $I(entry-active)] \
            -border 4 -padding {6 8} -sticky news
        ttk::style element create Spinbox.uparrow \
            image [list $I(arrow-up-small) \
                        active    $I(arrow-up-small-prelight) \
                        pressed   $I(arrow-up-small-prelight) \
                        disabled  $I(arrow-up-small-insens) \
            ] -border 4 -sticky {}
        ttk::style element create Spinbox.downarrow \
            image [list $I(arrow-down-small) \
                        active    $I(arrow-down-small-prelight) \
                        pressed   $I(arrow-down-small-prelight) \
                        disabled  $I(arrow-down-small-insens) \
          ] -border 4 -sticky {}

       ttk::style element create Notebook.client \
            image $I(notebook-client) -border 1
        ttk::style element create Notebook.tab \
            image [list $I(notebook-tab-top) \
                        selected    $I(notebook-tab-top-active) \
                        active      $I(notebook-tab-top-hover) \
            ] -padding {12 4 12 4} -border 2

            
        # TODO Enhance
        ttk::style element create Horizontal.Progressbar.trough \
            image $I(scrollbar-trough-horiz-active) -border {6 0 6 0} -sticky ew
        ttk::style element create Horizontal.Progressbar.pbar \
            image $I(scrollbar-slider-horiz) -border {6 0 6 0} -sticky ew

        ttk::style element create Vertical.Progressbar.trough \
            image $I(scrollbar-trough-vert-active) -border {0 6 0 6} -sticky ns
        ttk::style element create Vertical.Progressbar.pbar \
            image $I(scrollbar-slider-vert) -border {0 6 0 6} -sticky ns
        # TODO: Ab hier noch teilweise Arc style
        ttk::style element create Treeview.field \
            image $I(treeview) -border 1
        ttk::style element create Treeheading.cell \
            image [list $I(notebook-client) \
                active $I(treeheading-prelight)] \
            -border 1 -padding 0 -sticky ewns
        
        # TODO: arrow-* ist at the moment a little bit too big 
        # the small version is too small :-)
        # And at the moment there are no lines as in the Breeze theme
        # And hover, pressed doesn't work
        ttk::style element create Treeitem.indicator \
            image [list $I(arrow-right) \
                user2 $I(empty) \
                user1 $I(arrow-down) \
                ] \
            -width 0 -sticky w
        # I don't know why Only with this I get a thin enough sash
        ttk::style element create vsash image $I(transparent) -sticky e -padding 1 -width 1
	    ttk::style element create hsash image $I(transparent) -sticky n -padding 1 -width 1

        #ttk::style element create Separator.separator image $I()

        #
        # Settings:
        #

        ttk::style configure TMenubutton -padding {8 4 4 4}
        ttk::style configure Toolbutton -padding {6 2} -anchor center
        ttk::style configure TCheckbutton -padding 4
        ttk::style configure TRadiobutton -padding 4
        ttk::style configure TSeparator -background $colors(-bg)

        #ttk::style configure TPanedwindow -width 1 -padding 0
        ttk::style map TPanedwindow -background [list hover $colors(-checklight)]
        ttk::style map TCombobox -selectbackground [list \
            !focus         $colors(-window) \
            {readonly hover} $colors(-checklight) \
            {readonly focus} $colors(-focuscolor) \
            ]
            
        ttk::style map TCombobox -selectforeground [list \
            !focus $colors(-fg) \
            {readonly hover} $colors(-fg) \
            {readonly focus} $colors(-selectfg) \
            ]
        
        # Treeview
        ttk::style configure Treeview -background white 
        ttk::style configure Treeview.Item -padding {2 0 0 0}
        
        # Some defaults for non ttk-widgets so that they fit
        # to the Breeze theme, too
        tk_setPalette background [ttk::style lookup . -background] \
        	foreground [ttk::style lookup . -foreground] \
        	highlightColor [ttk::style lookup . -focuscolor] \
        	selectBackground [ttk::style lookup . -selectbackground] \
        	selectForeground [ttk::style lookup . -selectforeground] \
        	activeBackground [ttk::style lookup . -selectbackground] \
        	activeForeground [ttk::style lookup . -selectforeground]
        option add *font [ttk::style lookup . -font]
        ttk::style configure TButton -padding {8 4 8 4} -width -10 -anchor center


    }
  }
}
