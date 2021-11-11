oo::class create token {
  variable libp11
  variable handle
  variable infotok
  variable pintok
  variable nodet
  constructor {handlelp11 labtoken slottoken} {
    global pass
    global yespas
    set handle $handlelp11
    if {0} {
      set libp11 $lp11
      if {[catch {set handle [::pki::pkcs11::loadmodule  $libp11]} ret]} {
        #	    error "Constructor:Cannot load library   : $libp11"
        error "Constructor:Cannot load library   : $ret"
      }
    }

    set slots [pki::pkcs11::listslots $handle]
    array set infotok []
    foreach slotinfo $slots {
      set slotflags [lindex $slotinfo 2]
      if {[lsearch -exact $slotflags TOKEN_PRESENT] != -1} {
        if {[string first $labtoken [lindex $slotinfo 1]] != -1} {
          set infotok(slotlabel) [lindex $slotinfo 1]
          set infotok(slotid) [lindex $slotinfo 0]
          set infotok(slotflags) [lindex $slotinfo 2]
          set infotok(token) [lindex $slotinfo 3]
          #Берется наш токен
          break
        }
      }
    }
    #Список найденных токенов в слотах
    if {[llength [array names infotok]] == 0 } {
      error "Constructor: Token not present for library   : $handle"
    }
    #	parray infotok
    #Объект какого токена
    set nodet [dict create pkcs11_handle $handle]
    dict set nodet pkcs11_slotid $infotok(slotid)
    set tit "Введите PIN-код для токене $infotok(slotlabel)"
    set xa [my read_password $tit]
    if {$xa == "no"} {
      error "Вы передумали вводить PIN для токена $infotok(slotlabel)"
    }
    set pintok $pass
    set pass ""
    set rr [my login ]
    if { $rr == 0 } {
      unset pintok
      error "Проверьте PIN-код токена $infotok(slotlabel)."
    } elseif {$rr == -1} {
      unset pintok
      error "Отсутствует токен."
    }
    my logout
  }
  method infoslot {} {
    return [array get infotok]
  }
  method listcerts {} {
    array set lcerts []
    set certsder [pki::pkcs11::listcertsder $handle $infotok(slotid)]
    #Перебираем сертификаты
    foreach lc $certsder {
      array set derc $lc
      set lcerts($derc(pkcs11_label)) [list $derc(cert_der) $derc(pkcs11_id)]
      #parray derc
    }
    return [array get lcerts]
  }
  method read_password {tit} {
    global yespas
    global pass
    set tit_orig "$::labpas"
    if {$tit != ""} {
      set ::labpas "$tit"
    }
    tk busy hold ".st.fr1"
    tk busy hold ".st.fr3"
    #	place .topPinPw -in .st.fr1.fr2_certs.labCert  -relx 1.0 -rely 3.0 -relwidth 3.5
    place .topPinPw -in .st.labMain  -relx 0.35 -rely 5.0 -relwidth 0.30
    set yespas ""
    focus .topPinPw.labFrPw.entryPw
    vwait yespas
    catch {tk busy forget ".st.fr1"}
    catch {tk busy forget ".st.fr3"}
    if {$tit != ""} {
      set ::labpas "$tit_orig"
    }
    place forget .topPinPw
    return $yespas
  }
  unexport read_password
  method rename {type ckaid newlab} {
    if {$type != "cert" && $type != "key" && $type != "all"} {
      error "Bad type for rename "
    }
    set uu $nodet
    lappend uu "pkcs11_id"
    lappend uu $ckaid
    lappend uu "pkcs11_label"
    lappend uu $newlab
    if { [my login ] == 0 } {
      unset uu
      return 0
    }
    pki::pkcs11::rename $type $uu
    my logout
    return 1
  }
  method changeid {type ckaid newid} {
    if {$type != "cert" && $type != "key" && $type != "all"} {
      error "Bad type for changeid "
    }
    set uu $nodet
    lappend uu "pkcs11_id"
    lappend uu $ckaid
    lappend uu "pkcs11_id_new"
    lappend uu $newid
    if { [my login ] == 0 } {
      unset uu
      return 0
    }
    pki::pkcs11::rename $type $uu
    my logout
    return 1
  }
  method delete {type ckaid} {
    if {$type != "cert" && $type != "key" && $type != "all" && $type != "obj"} {
      error "Bad type for delete"
    }
    set uu $nodet
    lappend uu "pkcs11_id"
    lappend uu $ckaid
    my login
    ::pki::pkcs11::delete $type $uu
    my logout
    return 1
  }
  method deleteobj {hobj} {
    set uu $nodet
    lappend uu "hobj"
    lappend uu $hobj
#tk_messageBox -title "class deleteobj" -icon info -message "hobj: $hobj\n" -detail "$uu"
    return [::pki::pkcs11::delete obj $uu ]
  }
  method listmechs {} {
    set llmech [pki::pkcs11::listmechs $handle $infotok(slotid)]
    return $llmech
  }
  method pubkeyinfo {cert_der_hex} {
    array set linfopk [pki::pkcs11::pubkeyinfo $cert_der_hex $nodet]
    return [array get linfopk]
  }
  method listobjects {type} {
    if {$type != "cert" && $type != "pubkey" && $type != "privkey" && $type != "all" && $type != "data"} {
      error "Bad type for listobjects "
    }
#    if {$type == "privkey" || $type == "all"} {
#      my login
#    }
    set allobjs [::pki::pkcs11::listobjects $handle $infotok(slotid) $type]
#    if {$type == "privkey" || $type == "all"} {
#      my logout
#    }
    return $allobjs
  }
  method importcert {cert_der_hex cka_label} {
    set uu $nodet
    dict set uu pkcs11_label $cka_label
    if {[catch {set pkcs11id [pki::pkcs11::importcert $cert_der_hex $uu]} res] } {
      error "Cannot import this certificate:$res"
      #          return 0
    }
    return $pkcs11id
  }
  method login {} {
    set wh 1
    set rl -1
    while {$wh == 1} {
      if {[catch {set rl [pki::pkcs11::login $handle $infotok(slotid) $pintok]} res]} {
        if {[string first "SESSION_HANDLE_INVALID" $res] != -1} {
          pki::pkcs11::closesession $handle
          continue
        } elseif {[string first "TOKEN_NOT_PRESENT" $res] != -1} {
          set wh 0
          continue
        }
      }
      break
    }
    if {$wh == 0} {
      return -1
    }
    return $rl
  }
  method logout {} {
    return [pki::pkcs11::logout $handle $infotok(slotid)]
  }
  method keypair {typegost parkey} {
    my login
    set skey [pki::pkcs11::keypair $typegost $parkey $nodet]
    my logout
    return $skey
  }
  method digest {typehash source} {
    return [pki::pkcs11::digest $typehash $source $nodet]
  }
  method signkey {ckm digest hobj_priv} {
    set uu $nodet
    dict set uu hobj_privkey $hobj_priv
    my login
    set ss [pki::pkcs11::sign $ckm $digest $uu]
    my logout
    return $ss
  }
  method signcert {ckm digest pkcs11_id} {
    set uu $nodet
    dict set uu pkcs11_id $pkcs11_id
    my login
    set ss  [pki::pkcs11::sign $ckm $digest $uu]
    my logout
    return $ss
  }
  method verify {digest signature asn1pubkey} {
    set uu $nodet
    dict set uu pubkeyinfo $asn1pubkey
    return [pki::pkcs11::verify $digest $signature $uu]
  }
  method tokenpresent {} {
    set slots [pki::pkcs11::listslots $handle]
    foreach slotinfo $slots {
      set slotid [lindex $slotinfo 0]
      set slotlabel [lindex $slotinfo 1]
      set slotflags [lindex $slotinfo 2]
      if {[lsearch -exact $slotflags TOKEN_PRESENT] != -1} {
        if {infotok(slotlabel) == $slotlabel && $slotid == $infotok(slotid)} {
          return 1
        }
      }
    }
    return 0
  }
  method setpin {type tpin newpin} {
    if {$type != "user" && $type != "so"} {
      return 0
    }
    if {$type == "user"} {
      if {$tpin != $pintok} {
        return 0
      }
    }
    set ret [::pki::pkcs11::setpin  $handle $infotok(slotid) $type $tpin $newpin]
    if {$type == "user"} {
      if {$ret} {
        set pitok $newpin
      }
    }
    return $ret
  }
  method inituserpin {sopin upin} {
    set ret [::pki::pkcs11::inituserpin $handle $infotok(slotid) $sopin $upin]
    return $ret
  }
  method importkey {uukey} {
    set uu $nodet
    append uu " $uukey"
    my login
    if {[catch {set impkey [pki::pkcs11::importkey $uu ]} res] } {
        set impkey 0
    }
    my logout
    return $impkey
  }

  destructor {
    variable handle
    if {[info exists pintok]} {
      my login
    }
    #	    ::pki::pkcs11::unloadmodule  $handle
  }
}

