#-----------------------------------------------------------------------------
# asnGetLength: Decode an ASN length value (See notes) with Indefinite length BER encoding
#-----------------------------------------------------------------------------
package require asn
rename ::asn::asnGetLength ::asn::asnGetLength.orig
package require platform

proc ::asn::asnGetLength {data_var length_var} {
    upvar 1 $data_var data  $length_var length

    asnGetByte data length
    if {$length == 0x080} {
# Indefinite length BER encoding yet supported
#Vladimir Orlov http://soft.lissi.ru
# email: vorlov@lissi.ru
###############
	set lendata [string length $data]
	set tvl 1
	set length 0
	set data1 $data
	while {$tvl != 0} {
	    ::asn::asnGetByte data1 peek_tag 
	    ::asn::asnPeekByte data1 peek_tag1
	    if {$peek_tag == 0x00 && $peek_tag1 == 0x00} {
		incr tvl -1
		::asn::asnGetByte data1 tag 
		if {$tvl > 0} {
		    incr length 2
		} else {
		    incr length 2
		}
		continue
	    }
	    if {$peek_tag1 == 0x80} {
		incr tvl
		if {$tvl > 0} {
		    incr length 2
		}
		::asn::asnGetByte data1 tag 
	    } else {
		set l1 [string length $data1]
		::asn::asnGetLength data1 ll
		set l2 [string length $data1]
		set l3 [expr $l1 - $l2]
		incr length $l3
		incr length $ll
		incr length
		::asn::asnGetBytes data1 $ll strt
	    }
    
	}
	return
###############
#        return -code error "Indefinite length BER encoding not yet supported"
    }
    if {$length > 0x080} {
    # The retrieved byte is a prefix value, and the integer in the
    # lower nibble tells us how many bytes were used to encode the
    # length data following immediately after this prefix.

        set len_length [expr {$length & 0x7f}]
        
        if {[string length $data] < $len_length} {
            return -code error \
		"length information invalid, not enough octets left" 
        }
        
        asnGetBytes data $len_length lengthBytes

        switch $len_length {
            1 { binary scan $lengthBytes     cu length }
            2 { binary scan $lengthBytes     Su length }
            3 { binary scan \x00$lengthBytes Iu length }
            4 { binary scan $lengthBytes     Iu length }
            default {                
                binary scan $lengthBytes H* hexstr
		scan $hexstr %llx length
            }
        }
    }
    return
}

set OS [lindex $tcl_platform(os) 0]
# Подключаем пакет Lcc
# Подключаем пакет Lrnd

namespace eval ::GostPfx {
  namespace export pfxParse pfxMacDataParse pfxGetAuthSafeTbs pfxHmacVerify
  namespace export pfxTbsParse pfxPbeDataParse pfxPbeKey pfxDataDecrypt
  namespace export pfxIdentityDataParse pfxCertBagsParse pfxKeyBagsParse
  namespace export pfxKeyBagDecrypt pfxKeyDataParse pfxDataEncrypt
  namespace export pfxCreateSingleCertKey pfxGetSingleCertKey pfxCreateLocalKeyID 
  
  variable INTEGER_TAG 2
  variable OCTET_STRING_TAG 4
  variable OBJECT_IDENTIFIER_TAG 6
  variable SEQUENCE_TAG 16
  variable SET_TAG 17
  variable BMP_STRING_TAG 30 

  variable oid_Gost_3411_94 "1 2 643 2 2 9"
  variable oid_Gost3411_2012_512 "1 2 643 7 1 1 2 3"
  variable oid_pkcs7_data "1 2 840 113549 1 7 1"
  variable oid_pkcs7_encrypted_data "1 2 840 113549 1 7 6"
  variable oid_pkcs5PBES2 "1 2 840 113549 1 5 13"
  variable oid_pBKDF2 "1 2 840 113549 1 5 12"
  variable oid_HMACgostR3411_94 "1 2 643 2 2 10"
  variable oid_tc26_hmac_gost_3411_2012_512 "1 2 643 7 1 1 4 2"
  variable oid_gost28147_89 "1 2 643 2 2 21"
  variable oid_PKCS12CertificateBag "1 2 840 113549 1 12 10 1 3"
  variable oid_PKCS9x509Certificate "1 2 840 113549 1 9 22 1"
  variable oid_friendlyName "1 2 840 113549 1 9 20"
  variable oid_localKeyID "1 2 840 113549 1 9 21"
  variable oid_pkcs8ShroudedKeyBag "1 2 840 113549 1 12 10 1 2"
  variable oid_tc26_gost_28147_89_param_A "1 2 643 7 1 2 5 1 1"
  variable oid_GostR3410_2001 "1 2 643 2 2 19"
  variable oid_GostR3411_94_with_GostR3410_2001 "1 2 643 2 2 3"
  variable oid_tc26_gost3410_2012_256 "1 2 643 7 1 1 1 1"
  variable oid_tc26_signwithdigest_gost3410_2012_256 "1 2 643 7 1 1 3 2"
  variable oid_tc26_gost3410_2012_512 "1 2 643 7 1 1 1 2"
  variable oid_tc26_signwithdigest_gost3410_2012_256 "1 2 643 7 1 1 3 3"
  
}
#-----------------------------------------------------------------------------
# asnGetOctetString : Retrieve arbitrary string.
#-----------------------------------------------------------------------------
proc ::asn::asnGet24OctetString {data_var string_var} {
    # Here we need the full decoder for length data.

    upvar 1 $data_var data $string_var string
    
    asnGetByte data tag
    if {$tag != 0x24} { 
        return -code error \
            [format "Expected Octet String 24 (0x24), but got %02x" $tag]
    }
    asnGetLength data length
    asnGetBytes  data $length temp
    set string $temp
    return
}


# indata => dict: authSafe macData digestAlg digestParamset hmac 
proc ::GostPfx::pfxParse {indata} {
  variable INTEGER_TAG 
  variable SEQUENCE_TAG
  
  set data $indata
  set dres [dict create]
  set tag_len [asn::asnPeekTag data tag_var tag_type_var constr_var]
  if {$tag_var == $SEQUENCE_TAG} {
    asn::asnGetSequence data seqValue
    set tag_len [asn::asnPeekTag seqValue tag_var tag_type_var constr_var]

    if {$tag_var == $INTEGER_TAG} {
      asn::asnGetInteger seqValue version
      dict set dres "version" $version
    } else {
      error "pfxParse: Invalid PFX DER structure 1 tag=$tag_var"
    }    
    set tag_len [asn::asnPeekTag seqValue tag_var tag_type_var constr_var]
    if {$tag_var == $SEQUENCE_TAG} {
      asn::asnGetSequence seqValue authSafe
      dict set dres "authSafe" $authSafe
    } else {
      error "pfxParse: Invalid PFX DER structure 2"
    }    
    set tag_len [asn::asnPeekTag seqValue tag_var tag_type_var constr_var]
    # Optional
    if {$tag_var == $SEQUENCE_TAG} {
      asn::asnGetSequence seqValue macData
      dict set dres "macData" $macData
    }
  } else {
    error "pfxParse: Invalid PFX DER structure 3"
  }
  return $dres
}

# macData => dict: salt iter 
proc ::GostPfx::pfxMacDataParse {macData} {
  variable INTEGER_TAG 
  variable OCTET_STRING_TAG 
  variable OBJECT_IDENTIFIER_TAG 
  variable SEQUENCE_TAG

  set data $macData
  set dres [dict create]
  set tag_len [asn::asnPeekTag data tag_var tag_type_var constr_var]
  if {$tag_var == $SEQUENCE_TAG} {
    asn::asnGetSequence data seqValue1
    set tag_len [asn::asnPeekTag seqValue1 tag_var tag_type_var constr_var]
    if {$tag_var == $SEQUENCE_TAG} {
      asn::asnGetSequence seqValue1 seqValue2
      set tag_len [asn::asnPeekTag seqValue2 tag_var tag_type_var constr_var]
      if {$tag_var == $OBJECT_IDENTIFIER_TAG} {
        asn::asnGetObjectIdentifier seqValue2 digestAlg
        dict set dres "digestAlg" $digestAlg
      } else {
        error "pfxMacDataParse: Invalid MAC data structure"
      }  
      set tag_len [asn::asnPeekTag seqValue2 tag_var tag_type_var constr_var]
      # Optional
      if {$tag_var == $OBJECT_IDENTIFIER_TAG} {
        asn::asnGetObjectIdentifier seqValue2 digestParamset
        dict set dres "digestParamset" $digestParamset
      }
    }
    set tag_len [asn::asnPeekTag seqValue1 tag_var tag_type_var constr_var]
    if {$tag_var == $OCTET_STRING_TAG} {
      asn::asnGetOctetString seqValue1 hmac
      dict set dres "hmac" $hmac    
    }  else {
      error "pfxMacDataParse: Invalid MAC data structure"
    }  
  } else {
    error "pfxMacDataParse: Invalid MAC data structure"
  }  
  set tag_len [asn::asnPeekTag data tag_var tag_type_var constr_var]
  if {$tag_var == $OCTET_STRING_TAG} {
    asn::asnGetOctetString data salt
    dict set dres "salt" $salt
  } else {
    error "pfxMacDataParse: Invalid MAC data structure"
  }  
  set tag_len [asn::asnPeekTag data tag_var tag_type_var constr_var]
  if {$tag_var == $INTEGER_TAG} {
    asn::asnGetInteger data iter
    dict set dres "iter" $iter
  } else {
    error "pfxMacDataParse: Invalid MAC data structure"
  }    
  return $dres 
}

# authSafeData => tbs
proc ::GostPfx::pfxGetAuthSafeTbs {authSafeData} {
  variable OCTET_STRING_TAG 
  variable OBJECT_IDENTIFIER_TAG

  set data $authSafeData
  set tbs ""
  set tag_len [asn::asnPeekTag data tag_var tag_type_var constr_var]
  if {$tag_var == $OBJECT_IDENTIFIER_TAG} {
    asn::asnGetObjectIdentifier data oid
  } else {
    error "pfxGetAuthSafeTbs: Invalid AuthSafe structure"
  }

  set tag_len [asn::asnPeekTag data tag_var tag_type_var constr_var]
  if {$tag_type_var == "CONTEXT"} {
    asn::asnGetContext data contextNumber contextVar encoding_type
    ::asn::asnPeekByte contextVar peek_tag 
    ::asn::asnPeekByte contextVar peek_tag1 1
	if {$peek_tag == 0x24 && $peek_tag1 == 0x80} {
	    set contextVar1 $contextVar
	    ::asn::asnGet24OctetString contextVar1 contextVar
	    puts "pfxGetAuthSafeTbs=0x240x80"
	}
    set tag_len [asn::asnPeekTag contextVar tag_var tag_type_var constr_var]

    if {$tag_var == $OCTET_STRING_TAG} {
      asn::asnGetOctetString contextVar tbs
    } else {
      error "pfxGetAuthSafeTbs: Invalid AuthSafe structure"
    }
  } else {
    error "pfxGetAuthSafeTbs: Invalid AuthSafe structure"
  }
  return $tbs
}

# Для старого алгоритма PBA пароль должен быть представлен в UTF-16 без BOM
# с двумя нулевыми байтами в конце.
# После преобразования пароля в unicode нужно папарно переставить байты
# и добавить два нулевых байта в конец строки.   
proc ::GostPfx::passwordToUtf16 {password} {
  binary scan [encoding convertto unicode $password] c* bytes
  set bytes_len [llength $bytes]
  for {set i 0} {$i < $bytes_len} {incr i 2} {
    set left [lindex $bytes $i]
    set right [lindex $bytes [expr {$i+1}]]
    lset bytes $i $right
    lset bytes [expr {$i+1}] $left
  }
  lappend bytes 0 0
  set out [binary format c* $bytes]
  return $out
}

# returns 1 or 0
proc ::GostPfx::pfxHmacVerify {tbs hmac password hmacDigestAlg hmacKeySalt hmacKeyIter} {
  variable oid_Gost_3411_94 
  variable oid_Gost3411_2012_512
  
  if {$hmacDigestAlg == $oid_Gost_3411_94} {  
    set passwordUtf16 [passwordToUtf16 $password]
    set hmacPbaKey [lcc_gost3411_94_pkcs12_pba $passwordUtf16 $hmacKeySalt $hmacKeyIter]
    set hmacPba [lcc_gost3411_94_hmac $tbs $hmacPbaKey]
    if {$hmacPba != $hmac} {
      # В случае контейнера ТК 26 v 1.0 ключ HMAC нужно генерировать по-другому
      set hmacPbaKey [string range [lcc_gost3411_94_pkcs5 $password $hmacKeySalt $hmacKeyIter 96] 64 95]
      set hmacPba [lcc_gost3411_94_hmac $tbs $hmacPbaKey]
      if {$hmacPba != $hmac} {
        #puts "hmacPba != hmac"
      } else {
        #puts "TC 26 v 1.0 PBA HMAC OK"
        return 1
      }
    } else {
      #puts "Obsolete PBA HMAC OK"
      return 1
    }
  } else {
    if {$hmacDigestAlg == $oid_Gost3411_2012_512} {
      set hmacPbaKey [string range [lcc_gost3411_2012_pkcs5 $password $hmacKeySalt $hmacKeyIter 96] 64 95]
      set hmacPba [lcc_gost3411_2012_hmac 64 $tbs $hmacPbaKey]
      if {$hmacPba != $hmac} {
        #puts "hmacPba != hmac"
      } else {
        #puts "TC 26 v 2.0 PBA HMAC OK"
        return 1
      }
    } else {
      error "pfxHmacVerify: Unsupported digest algorithm: $hmacDigestAlg"
    }
  }
  return 0
}

proc ::GostPfx::p7mParse {p7m} {
  variable OCTET_STRING_TAG 
  variable OBJECT_IDENTIFIER_TAG 
  variable SEQUENCE_TAG 
  variable INTEGER_TAG
  variable oid_pkcs7_data 

    set seqValue2 $p7m
    set dres [dict create]
          set tag_len [asn::asnPeekTag seqValue2 tag_var tag_type_var constr_var]
          if {$tag_type_var == "CONTEXT"} {
            asn::asnGetContext seqValue2 contextNumber contextData encoding_type
            set tag_len [asn::asnPeekTag contextData tag_var tag_type_var constr_var]
            if {$tag_var == $SEQUENCE_TAG} {
              asn::asnGetSequence contextData seqValue3
              set tag_len [asn::asnPeekTag seqValue3 tag_var tag_type_var constr_var]
              if {$tag_var == $INTEGER_TAG} {
                asn::asnGetInteger seqValue3 version
                set tag_len [asn::asnPeekTag seqValue3 tag_var tag_type_var constr_var]
                if {$tag_var == $SEQUENCE_TAG} {
                  asn::asnGetSequence seqValue3 seqValue4
                  set tag_len [asn::asnPeekTag seqValue4 tag_var tag_type_var constr_var]
                  if {$tag_var == $OBJECT_IDENTIFIER_TAG} {
                    asn::asnGetObjectIdentifier seqValue4 oid2
                    if {$oid2 == $oid_pkcs7_data} {
                      set tag_len [asn::asnPeekTag seqValue4 tag_var tag_type_var constr_var]
                      if {$tag_var == $SEQUENCE_TAG} {
                        asn::asnGetSequence seqValue4 certsPbeData                  
                        dict set dres "certsPbeData" $certsPbeData
                        set tag_len [asn::asnPeekTag seqValue4 tag_var tag_type_var constr_var]
                        if {$tag_type_var == "CONTEXT"} {
			  ::asn::asnPeekByte seqValue4 peek_tag 
			  ::asn::asnPeekByte seqValue4 peek_tag1 1
			  if {$peek_tag == 0xA0 && $peek_tag1 == 0x80} {
				set seqValue4_80 $seqValue4
				set seqValue4 [string range $seqValue4_80 2 {end-2}]
                        	asn::asnGetOctetString seqValue4 encrCerts 
			  } else {
                            asn::asnGetContext seqValue4 contextNumber encrCerts encoding_type
                          }
                          dict set dres "encrCerts" $encrCerts
                        } else {
                          error "pfxTbsParse: Invalid encrypted certificates structure 1"
                        }  
                      } else {
                        error "pfxTbsParse: Invalid encrypted certificates structure 2"
                      }
                    } else {
                      error "pfxTbsParse: Invalid encrypted certificates structure 3"
                    }
                  } else {
                    error "pfxTbsParse: Invalid encrypted certificates structure 4"
                  }
                } else {
                  error "pfxTbsParse: Invalid encrypted certificates structure 5"
                }
              } else {
                error "pfxTbsParse: Invalid encrypted certificates structure 6"
              }
            } else {
              error "pfxTbsParse: Invalid encrypted certificates structure 7"
            }
          } else {
              error "pfxTbsParse: Invalid encrypted certificates structure 8"
    	  }
    	  return $dres
}

proc ::GostPfx::p7dParse {p7d} {
  variable OCTET_STRING_TAG 
  variable OBJECT_IDENTIFIER_TAG 
  variable SEQUENCE_TAG 
  variable INTEGER_TAG
  variable oid_pkcs7_data 
    set dres [dict create]

    set seqValue2 $p7d
          set tag_len [asn::asnPeekTag seqValue2 tag_var tag_type_var constr_var]
          if {$tag_type_var == "CONTEXT"} {
            asn::asnGetContext seqValue2 contextNumber contextData encoding_type
##############
	    ::asn::asnPeekByte contextData peek_tag 
	    ::asn::asnPeekByte contextData peek_tag1 1
	    if {$peek_tag == 0x24 && $peek_tag1 == 0x80} {
		set contextVar1 $contextData
		::asn::asnGet24OctetString contextVar1 contextData
		puts "p7dParse=0x240x80"
	    }
#################
            set tag_len [asn::asnPeekTag contextData tag_var tag_type_var constr_var]
            if {$tag_var == $OCTET_STRING_TAG} {
              asn::asnGetOctetString contextData keyBags
              dict set dres "keyBags" $keyBags
            } else {
              error "pfxTbsParse: Invalid key bags structure 1"
            }
          } else {
            error "pfxTbsParse: Invalid key bags structure 2"
          }

    	  return $dres
}

# tbs => dict: keyBags certsPbeData encrCerts
proc ::GostPfx::pfxTbsParse {tbs} {
  variable OCTET_STRING_TAG 
  variable OBJECT_IDENTIFIER_TAG 
  variable SEQUENCE_TAG 
  variable INTEGER_TAG
  variable oid_pkcs7_data 
  variable oid_pkcs7_encrypted_data
  
  set data $tbs
  set dres [dict create]

  set certsPbeData 0
  set encrCerts 0
while {$data > 0} { 
    set tag_len [asn::asnPeekTag data tag_var tag_type_var constr_var]

    if {$tag_var == $SEQUENCE_TAG} {
	asn::asnGetSequence data seqValue1
	set tag_len [asn::asnPeekTag seqValue1 tag_var tag_type_var constr_var]
	if {$tag_var == $SEQUENCE_TAG} {
        asn::asnGetSequence seqValue1 seqValue2
        set tag_len [asn::asnPeekTag seqValue2 tag_var tag_type_var constr_var]
        if {$tag_var == $OBJECT_IDENTIFIER_TAG} {
    	    asn::asnGetObjectIdentifier seqValue2 oid2

    	    if {$oid2 == $oid_pkcs7_encrypted_data} {
    		set gg [list]
		set gg [::GostPfx::p7mParse $seqValue2]
		foreach {l l1} $gg {
        	    if {[dict exists $dres $l]} {
			if {$l == "certsPbeData"} {
			    if {$certsPbeData == 1} {
				dict set dres $l $l1
			    }
			    set certsPbeData 1
			} elseif {$l == "encrCerts"} {
			    if {$encrCerts == 1} {
				dict set dres $l $l1
			    }
			    set encrCerts 1
			} else {
			    dict set dres $l $l1
			}
        	    } else {
			dict set dres $l $l1
		    }
		}
    	    } elseif {$oid2 == $oid_pkcs7_data} {
    		set gg [list]
		set gg [::GostPfx::p7dParse $seqValue2]
		foreach {l l1} $gg {
        	    if {[dict exists $dres $l]} {
			dict set dres $l $l1
        	    } else {
			dict set dres $l $l1
		    }
		}
	    } else {
        	error "pfxTbsParse: Invalid encrypted certificates structure 9 oid2=$oid2, oid_pkcs7_encrypted_data=$oid_pkcs7_encrypted_data"
    	    }        
    	    set data [asn::asnSequence $seqValue1]
        } else {
    	    error "pfxTbsParse: Invalid encrypted certificates structure 10"
        }
      }
    } else {
	error "pfxTbsParse: Invalid TBS structure 5"
    }
  }
  return $dres
}

# oid_pkcs5PBES2, ... => dict: hmacKeySalt hmacKeyIter hmacAlg digestParamset cipherAlg cipherIV cipherParamset
proc ::GostPfx::pfxPbeDataParse {pbeData} {
  variable OCTET_STRING_TAG 
  variable OBJECT_IDENTIFIER_TAG 
  variable SEQUENCE_TAG 
  variable INTEGER_TAG
  variable oid_pkcs5PBES2 
  variable oid_pBKDF2
  
  set data $pbeData
  set dres [dict create]
  set tag_len [asn::asnPeekTag data tag_var tag_type_var constr_var]
  if {$tag_var == $OBJECT_IDENTIFIER_TAG} {
    asn::asnGetObjectIdentifier data oid1
    if {$oid1 == $oid_pkcs5PBES2} {
      set tag_len [asn::asnPeekTag data tag_var tag_type_var constr_var]
      if {$tag_var == $SEQUENCE_TAG} {
        asn::asnGetSequence data seqValue1
        set tag_len [asn::asnPeekTag seqValue1 tag_var tag_type_var constr_var]
        if {$tag_var == $SEQUENCE_TAG} {
          asn::asnGetSequence seqValue1 seqValue2
          set tag_len [asn::asnPeekTag seqValue2 tag_var tag_type_var constr_var]
          if {$tag_var == $OBJECT_IDENTIFIER_TAG} {
            asn::asnGetObjectIdentifier seqValue2 oid2
            if {$oid2 == $oid_pBKDF2} {
              set tag_len [asn::asnPeekTag seqValue2 tag_var tag_type_var constr_var]
              if {$tag_var == $SEQUENCE_TAG} {
                asn::asnGetSequence seqValue2 seqValue3
                set tag_len [asn::asnPeekTag seqValue3 tag_var tag_type_var constr_var]
                 if {$tag_var == $OCTET_STRING_TAG} {
                  asn::asnGetOctetString seqValue3 hmacKeySalt
                  dict set dres "hmacKeySalt" $hmacKeySalt
                  set tag_len [asn::asnPeekTag seqValue3 tag_var tag_type_var constr_var]
                  if {$tag_var == $INTEGER_TAG} {
                    asn::asnGetInteger seqValue3 hmacKeyIter
                    dict set dres "hmacKeyIter" $hmacKeyIter
                    set tag_len [asn::asnPeekTag seqValue3 tag_var tag_type_var constr_var]
                    if {$tag_var == $SEQUENCE_TAG} {
                      asn::asnGetSequence seqValue3 seqValue4
                      set tag_len [asn::asnPeekTag seqValue4 tag_var tag_type_var constr_var]
                      if {$tag_var == $OBJECT_IDENTIFIER_TAG} {
                        asn::asnGetObjectIdentifier seqValue4 hmacAlg
                        dict set dres "hmacAlg" $hmacAlg
                        set tag_len [asn::asnPeekTag seqValue4 tag_var tag_type_var constr_var]
                        if {$tag_var == $OBJECT_IDENTIFIER_TAG} {
                          asn::asnGetObjectIdentifier seqValue4 digestParamset
                          dict set dres "digestParamset" $digestParamset
                        } 
                      } else {
                        error "pfxPbeDataParse: Invalid PBKDF2 HMAC algorithm structure"
                      }
                    } else {
                      error "pfxPbeDataParse: Invalid PBKDF2 HMAC algorithm structure"
                    }                    
                  } else {
                    error "pfxPbeDataParse: Invalid PBKDF2 iteration count structure"
                  }
                } else {
                  error "pfxPbeDataParse: Invalid PBKDF2 salt structure"
                }
              } else {
                error "pfxPbeDataParse: Invalid PBKDF2 structure"
              }              
            } else {
              error "pfxPbeDataParse: Invalid PBKDF2 structure"
            }
          } else {
            error "pfxPbeDataParse: Invalid PBKDF2 structure"
          }  
        }
        set tag_len [asn::asnPeekTag seqValue1 tag_var tag_type_var constr_var]
        if {$tag_var == $SEQUENCE_TAG} {
          asn::asnGetSequence seqValue1 seqValue2
          set tag_len [asn::asnPeekTag seqValue2 tag_var tag_type_var constr_var]
          if {$tag_var == $OBJECT_IDENTIFIER_TAG} {
            asn::asnGetObjectIdentifier seqValue2 cipherAlg
            dict set dres "cipherAlg" $cipherAlg
            set tag_len [asn::asnPeekTag seqValue2 tag_var tag_type_var constr_var]
            if {$tag_var == $SEQUENCE_TAG} {
              asn::asnGetSequence seqValue2 seqValue3
              set tag_len [asn::asnPeekTag seqValue3 tag_var tag_type_var constr_var]
              if {$tag_var == $OCTET_STRING_TAG} {
                asn::asnGetOctetString seqValue3 cipherIV
                dict set dres "cipherIV" $cipherIV
                set tag_len [asn::asnPeekTag seqValue3 tag_var tag_type_var constr_var]
                if {$tag_var == $OBJECT_IDENTIFIER_TAG} {
                  asn::asnGetObjectIdentifier seqValue3 cipherParamset
                  dict set dres "cipherParamset" $cipherParamset
                }
              } else {
                error "pfxPbeDataParse: Invalid PBE cipher IV structure"
              }
            } else {
              error "pfxPbeDataParse: Invalid PBE cipher params structure"
            }
          } else {
            error "pfxPbeDataParse: Invalid PBE cipher algorithm structure"
          }
        } else {
          error "pfxPbeDataParse: Invalid PBE cipher algorithm structure"
        }        
      } else {
        error "pfxPbeDataParse: Invalid PBE structure" 
      }
    } else {
      error "pfxPbeDataParse: Invalid PBE structure" 
    }
  } else {
    error "pfxPbeDataParse: Invalid PBE structure" 
  }
  return $dres
}

# generates cipher key
proc ::GostPfx::pfxPbeKey {password hmacAlg hmacKeySalt hmacKeyIter} {
  variable oid_HMACgostR3411_94 
  variable oid_tc26_hmac_gost_3411_2012_512

  set key ""
  if {$hmacAlg == $oid_HMACgostR3411_94} {
    set key [lcc_gost3411_94_pkcs5 $password $hmacKeySalt $hmacKeyIter 32]
  } else {
    if {$hmacAlg == $oid_tc26_hmac_gost_3411_2012_512} {
      set key [lcc_gost3411_2012_pkcs5 $password $hmacKeySalt $hmacKeyIter 32]
    } else {
      error "pfxPbeKey: Unsupported PKCS5 HMAC algorithm $hmacAlg"
    }
  }
  return $key
}

# encrData => decrData
proc ::GostPfx::pfxDataDecrypt {data alg paramset key iv} {
  variable oid_gost28147_89

  set out ""
  if {$alg == $oid_gost28147_89} {
    set dotted_paramset [string map {" " "."} $paramset]
    set par [lcc_gost28147_getParamsByOid $dotted_paramset]
    if {$par > 0} {
      set ctx [lcc_gost28147_cfb_ctx_create $par 0 $key $iv]
      if {$ctx > 0} {
        set out [lcc_gost28147_cfb_ctx_update $ctx $data]
        lcc_gost28147_cfb_ctx_delete $ctx
      } else {
        error "pfxDataDecrypt: Invalid cipher key or IV"
      }
      lcc_handle_free $par
    } else {
      error "pfxDataDecrypt: Unsupported cipher paramset $paramset"
    }
  } else {
    error "pfxDataDecrypt: Unsupported cipher algorithm $alg"  
  }
  return $out
} 

# plain data => encrData
proc ::GostPfx::pfxDataEncrypt {data alg paramset key iv} {
  variable oid_gost28147_89
  
  set out ""
  if {$alg == $oid_gost28147_89} {
    set dotted_paramset [string map {" " "."} $paramset]
    set par [lcc_gost28147_getParamsByOid $dotted_paramset]
    if {$par > 0} {
      set ctx [lcc_gost28147_cfb_ctx_create $par 1 $key $iv]
      if {$ctx > 0} {
        set out [lcc_gost28147_cfb_ctx_update $ctx $data]
        lcc_gost28147_cfb_ctx_delete $ctx
      } else {
        error "pfxDataEncrypt: Invalid cipher key or IV"
      }
      lcc_handle_free $par
    } else {
      error "pfxDataEncrypt: Unsupported cipher paramset $paramset"
    }
  } else {
    error "pfxDataEncrypt: Unsupported cipher algorithm $alg"  
  }
  return $out
} 

# SET => dict: friendlyName localKeyID
proc ::GostPfx::pfxIdentityDataParse {identityData} {
  variable SEQUENCE_TAG 
  variable OBJECT_IDENTIFIER_TAG 
  variable OCTET_STRING_TAG 
  variable SET_TAG 
  variable BMP_STRING_TAG
  variable oid_friendlyName 
  variable oid_localKeyID

  set data $identityData
  set dres [dict create]
  set tag_len [asn::asnPeekTag data tag_var tag_type_var constr_var]
  if {$tag_var == $SET_TAG} {
    asn::asnGetSet data set1
    while {1} {
      set tag_len [asn::asnPeekTag set1 tag_var tag_type_var constr_var]
      if {$tag_var != $SEQUENCE_TAG} {
        break
      }
      asn::asnGetSequence set1 seqValue3
      set tag_len [asn::asnPeekTag seqValue3 tag_var tag_type_var constr_var]
      if {$tag_var == $OBJECT_IDENTIFIER_TAG} {
        asn::asnGetObjectIdentifier seqValue3 oid3
        set tag_len [asn::asnPeekTag seqValue3 tag_var tag_type_var constr_var]
        if {$tag_var == $SET_TAG} {
          asn::asnGetSet seqValue3 set2
          set tag_len [asn::asnPeekTag set2 tag_var tag_type_var constr_var]
          if {$oid3 == $oid_friendlyName} {
            if {$tag_var == $BMP_STRING_TAG} {
              asn::asnGetString set2 friendlyName
              dict set dres "friendlyName" $friendlyName
            } else {
              error "pfxIdentityDataParse: friendlyName is not BMP STRING"
            }
          } else {
            if {$oid3 == $oid_localKeyID} {
              if {$tag_var == $OCTET_STRING_TAG} {
                asn::asnGetOctetString set2 localKeyID
                dict set dres "localKeyID" $localKeyID
              }
            } else {
              error "pfxIdentityDataParse: localKeyID is not OCTET STRING"
            }
          }
        } else {
          error "pfxIdentityDataParse: Invalid structure 1 $tag_var"
        }                
      } else {
        error "pfxIdentityDataParse: Invalid structure 2 $tag_var"
      }
    }
  } else {
#LISSI
    dict set dres "friendlyName" "--friendlyname not--"
    dict set dres "localKeyID" "--localKeyID not--"
#    error "pfxIdentityDataParse: Invalid structure 3 $tag_var"
  }
  return $dres
}

# certBags => { {dict: certificat  friendlyName localKeyID} ...}
proc ::GostPfx::pfxCertBagsParse {certBags} {
  variable SEQUENCE_TAG 
  variable OBJECT_IDENTIFIER_TAG 
  variable OCTET_STRING_TAG 
  variable SET_TAG 
  variable BMP_STRING_TAG
  variable oid_PKCS12CertificateBag 
  variable oid_PKCS9x509Certificate 
  variable oid_friendlyName 
  variable oid_localKeyID
  
  set data $certBags
  set lres {}
  set tag_len [asn::asnPeekTag data tag_var tag_type_var constr_var]
  if {$tag_var == $SEQUENCE_TAG} {
    asn::asnGetSequence data seqValue1
    set tag_len [asn::asnPeekTag seqValue1 tag_var tag_type_var constr_var]
    while {$tag_var == $SEQUENCE_TAG} {
      asn::asnGetSequence seqValue1 seqValue2
      set tag_len [asn::asnPeekTag seqValue2 tag_var tag_type_var constr_var]
      if {$tag_var == $OBJECT_IDENTIFIER_TAG} {
        asn::asnGetObjectIdentifier seqValue2 oid1
        if {$oid1 == $oid_PKCS12CertificateBag} {
          set dcert [dict create]
          set tag_len [asn::asnPeekTag seqValue2 tag_var tag_type_var constr_var]
          if {$tag_type_var == "CONTEXT"} {
            asn::asnGetContext seqValue2 contextNumber context1 encoding_type
            set tag_len [asn::asnPeekTag context1 tag_var tag_type_var constr_var]
            if {$tag_var == $SEQUENCE_TAG} {
              asn::asnGetSequence context1 seqValue3
              set tag_len [asn::asnPeekTag seqValue3 tag_var tag_type_var constr_var]
              if {$tag_var == $OBJECT_IDENTIFIER_TAG} {
                asn::asnGetObjectIdentifier seqValue3 oid2
                if {$oid2 == $oid_PKCS9x509Certificate} {
                  set tag_len [asn::asnPeekTag seqValue3 tag_var tag_type_var constr_var]
                  if {$tag_type_var == "CONTEXT"} {
                    asn::asnGetContext seqValue3 contextNumber context2 encoding_type
                    set tag_len [asn::asnPeekTag context2 tag_var tag_type_var constr_var]
                    if {$tag_var == $OCTET_STRING_TAG} {
                      asn::asnGetOctetString context2 certificate
            	      dict set dcert "certificate" $certificate
                    } else {
                      error "pfxCertBagsParse: Invalid structure 0"
                    }                    
                  } else {
                    error "pfxCertBagsParse: Invalid structure 1"
                  }
                } else {
                  error "pfxCertBagsParse: Invalid structure 2"
                }
              } else {
                error "pfxCertBagsParse: Invalid structure 3"
              }
            } else {
              error "pfxCertBagsParse: Invalid structure 4"
            }           
          } else {
            error "pfxCertBagsParse: Invalid structure 5"
          }
          set tag_len [asn::asnPeekTag seqValue2 tag_var tag_type_var constr_var]
          
          set did [pfxIdentityDataParse $seqValue2]
          if {[dict exists $did friendlyName]} {
            dict set dcert "friendlyName" [dict get $did friendlyName]
          }
          if {[dict exists $did localKeyID]} {
            dict set dcert "localKeyID" [dict get $did localKeyID]
          }
        } else {
          error "pfxCertBagsParse: Invalid structure 6"
        }
      } else {
        error "pfxCertBagsParse: Invalid structure 7"
      }
      lappend lres $dcert
            
      set tag_len [asn::asnPeekTag seqValue1 tag_var tag_type_var constr_var]
    }    
  } else {
    error "pfxCertBagsParse: Invalid structure 8"
  }

  return [reverse $lres]
#  return $lres
}

# SEQUENCE, {SEQUENCE, oid_pkcs8ShroudedKeyBag, ...} => { {dict: keyBag friendlyName localKeyID} ... }
proc ::GostPfx::pfxKeyBagsParse {keyBags} {
  variable SEQUENCE_TAG 
  variable OBJECT_IDENTIFIER_TAG 
  variable OCTET_STRING_TAG 
  variable SET_TAG
  variable oid_pkcs8ShroudedKeyBag 
  
  set data $keyBags
  set lres {}
  set tag_len [asn::asnPeekTag data tag_var tag_type_var constr_var]
  if {$tag_var == $SEQUENCE_TAG} {
    asn::asnGetSequence data seqValue2
    while {1} {
      set tag_len [asn::asnPeekTag seqValue2 tag_var tag_type_var constr_var]
      if {$tag_var != $SEQUENCE_TAG} {
        break
      }
      asn::asnGetSequence seqValue2 seqValue3
      set tag_len [asn::asnPeekTag seqValue3 tag_var tag_type_var constr_var]
      if {$tag_var == $OBJECT_IDENTIFIER_TAG} {
        asn::asnGetObjectIdentifier seqValue3 oid2
        if {$oid2 == $oid_pkcs8ShroudedKeyBag} { 
          set dbag [dict create]
          set tag_len [asn::asnPeekTag seqValue3 tag_var tag_type_var constr_var]
          if {$tag_type_var == "CONTEXT"} {
            asn::asnGetContext seqValue3 contextNumber context2 encoding_type
            set tag_len [asn::asnPeekTag context2 tag_var tag_type_var constr_var]
            if {$tag_var == $SEQUENCE_TAG} {
              asn::asnGetSequence context2 keyBag
              dict set dbag keyBag $keyBag                       
            } else {
              error "pfxKeyBagsParse: Invalid structure"
            }                          
          } else {
            error "pfxKeyBagsParse: Invalid structure"
          }    
          set tag_len [asn::asnPeekTag seqValue3 tag_var tag_type_var constr_var]
          if {$tag_var == $SET_TAG} {
            set did [pfxIdentityDataParse $seqValue3]
            if {[dict exists $did friendlyName]} {
              dict set dbag friendlyName [dict get $did friendlyName]
            }
            if {[dict exists $did localKeyID]} {
              dict set dbag localKeyID [dict get $did localKeyID]
            }
          }                   
          lappend lres $dbag
        } else {
          error "pfxKeyBagsParse: Invalid structure"
        }    
      } else {
        error "pfxKeyBagsParse: Invalid structure"
      }    
    }
  } else {
    error "pfxKeyBagsParse: Invalid structure"
  }            
  return $lres
}

# keyBag password => decrKey 
proc ::GostPfx::pfxKeyBagDecrypt {keyBag password} {
  variable SEQUENCE_TAG
  variable OCTET_STRING_TAG
  
  set decrKey ""
  set data $keyBag
  set tag_len [asn::asnPeekTag data tag_var tag_type_var constr_var]
  if {$tag_var == $SEQUENCE_TAG} {
    asn::asnGetSequence data pbeData
    set dpbe [pfxPbeDataParse $pbeData]
    if {[dict exists $dpbe hmacKeySalt]} {
      set hmacKeySalt [dict get $dpbe hmacKeySalt]
    }
    if {[dict exists $dpbe hmacKeyIter]} {
      set hmacKeyIter [dict get $dpbe hmacKeyIter]
    }
    if {[dict exists $dpbe hmacAlg]} {
      set hmacAlg [dict get $dpbe hmacAlg]
    }
    if {[dict exists $dpbe digestParamset]} {
      set digestParamset [dict get $dpbe digestParamset]
    }
    if {[dict exists $dpbe cipherAlg]} {
      set cipherAlg [dict get $dpbe cipherAlg]
    }
    if {[dict exists $dpbe cipherIV]} {
      set cipherIV [dict get $dpbe cipherIV]
    }
    if {[dict exists $dpbe cipherParamset]} {
      set cipherParamset [dict get $dpbe cipherParamset]
    }
    
    set tag_len [asn::asnPeekTag data tag_var tag_type_var constr_var]
    if {$tag_var == $OCTET_STRING_TAG} {
      asn::asnGetOctetString data encrKey 
    } else {
      error "pfxKeyBagDecrypt: Invalid structure"
    }
    set cipherKey [pfxPbeKey $password $hmacAlg $hmacKeySalt $hmacKeyIter]
    set decrKey [pfxDataDecrypt $encrKey $cipherAlg $cipherParamset $cipherKey $cipherIV]
  } else {
    error "pfxKeyBagDecrypt: Invalid structure"
  }    
  
  return $decrKey
}

# decrKey => dict: version keyAlg gost3410Paramset gost3411Paramset keyValue
proc ::GostPfx::pfxKeyDataParse {decrKey} {
  variable SEQUENCE_TAG 
  variable INTEGER_TAG 
  variable OBJECT_IDENTIFIER_TAG 
  variable OCTET_STRING_TAG

  set dKey [dict create]
  set data $decrKey
  set tag_len [asn::asnPeekTag data tag_var tag_type_var constr_var]
  if {$tag_var == $SEQUENCE_TAG} {
    asn::asnGetSequence data seqValue1
    set tag_len [asn::asnPeekTag seqValue1 tag_var tag_type_var constr_var]
    if {$tag_var == $INTEGER_TAG} {
      asn::asnGetInteger seqValue1 version
      dict set dKey version $version
      set tag_len [asn::asnPeekTag seqValue1 tag_var tag_type_var constr_var]
      if {$tag_var == $SEQUENCE_TAG} {
        asn::asnGetSequence seqValue1 seqValue2
        set tag_len [asn::asnPeekTag seqValue2 tag_var tag_type_var constr_var]
        if {$tag_var == $OBJECT_IDENTIFIER_TAG} {
          asn::asnGetObjectIdentifier seqValue2 keyAlg
          dict set dKey keyAlg $keyAlg
          set tag_len [asn::asnPeekTag seqValue2 tag_var tag_type_var constr_var]
          if {$tag_var == $SEQUENCE_TAG} {
            asn::asnGetSequence seqValue2 seqValue3
            set tag_len [asn::asnPeekTag seqValue3 tag_var tag_type_var constr_var]
            if {$tag_var == $OBJECT_IDENTIFIER_TAG} {
              asn::asnGetObjectIdentifier seqValue3 gost3410Paramset
              dict set dKey gost3410Paramset $gost3410Paramset
              set tag_len [asn::asnPeekTag seqValue3 tag_var tag_type_var constr_var]
              if {$tag_var == $OBJECT_IDENTIFIER_TAG} {
                asn::asnGetObjectIdentifier seqValue3 gost3411Paramset
                dict set dKey gost3411Paramset $gost3411Paramset
              }
            } else {
              error "pfxKeyDataParse: Invalid key paramset structure"
            }   
          } else {
            error "pfxKeyDataParse: Invalid key paramset structure"
          }            
        } else {
          error "pfxKeyDataParse: Invalid key algorithm structure"
        }          
      } else {
        error "pfxKeyDataParse: Invalid key algorithm structure"
      }    
      set tag_len [asn::asnPeekTag seqValue1 tag_var tag_type_var constr_var]
      if {$tag_var == $OCTET_STRING_TAG} {
        asn::asnGetOctetString seqValue1 octets1
        set tag_len [asn::asnPeekTag octets1 tag_var tag_type_var constr_var]
        if {$tag_var == $OCTET_STRING_TAG} {
          asn::asnGetOctetString octets1 keyValue
          dict set dKey keyValue $keyValue
        } else {
          error "pfxKeyDataParse: Invalid key value structure"
        }
      } else {
        error "pfxKeyDataParse: Invalid key value structure"
      }      
    } else {
      error "pfxKeyDataParse: Invalid key info structure"
    }   
  } else {
    error "pfxKeyDataParse: Invalid key info structure"
  }   
  
  return $dKey
}

# => dict: 
proc ::GostPfx::pfxGetSingleCertKey {indata password {nomacver 0} } {
  
  set dres [dict create]
  
  #puts "pfxParse"
  set dpfx [pfxParse $indata]
  if {[dict exists $dpfx authSafe]} {
    set authSafe [dict get $dpfx authSafe]
  }
  if {[dict exists $dpfx macData]} {
    set macData [dict get $dpfx macData]
  }
  

#Для старыз PKXS#12
if {$nomacver == 0} {
  #puts "pfxMacDataParse"
  set dhmac [pfxMacDataParse $macData]

  if {[dict exists $dhmac salt]} {
    set hmacKeySalt [dict get $dhmac salt]
  }
  if {[dict exists $dhmac iter]} {
    set hmacKeyIter [dict get $dhmac iter]
  }
  if {[dict exists $dhmac digestAlg]} {
    set hmacDigestAlg [dict get $dhmac digestAlg]
  }
  if {[dict exists $dhmac hmac]} {
    set hmac [dict get $dhmac hmac]
  }
}

  #puts "pfxGetAuthSafeTbs"
  set tbs [pfxGetAuthSafeTbs $authSafe]

#Для старых PKXS#12
if {0} {

  #puts "pfxHmacVerify"
  set hmac_ok [pfxHmacVerify $tbs $hmac $password $hmacDigestAlg $hmacKeySalt $hmacKeyIter]
  if {$hmac_ok != 1} {
    error "pfxGetSingleKeyCert: Check integrity: Invalid password or container corrupted!"
  }
}

  #puts "pfxTbsParse"
  set dKeysCertsData [pfxTbsParse $tbs]
  if {[dict exists $dKeysCertsData keyBags]} {
    set keyBags [dict get $dKeysCertsData keyBags]
  }
  if {[dict exists $dKeysCertsData certsPbeData]} {
    set certsPbeData [dict get $dKeysCertsData certsPbeData]
  }
  if {[dict exists $dKeysCertsData encrCerts]} {
    set encrCerts [dict get $dKeysCertsData encrCerts]
  }

  #puts "pfxPbeDataParse"
  set dCertsPbe [pfxPbeDataParse $certsPbeData]
  if {[dict exists $dCertsPbe hmacKeySalt]} {
    set hmacKeySalt [dict get $dCertsPbe hmacKeySalt]
  }
  if {[dict exists $dCertsPbe hmacKeyIter]} {
    set hmacKeyIter [dict get $dCertsPbe hmacKeyIter]
  }
  if {[dict exists $dCertsPbe hmacAlg]} {
    set hmacAlg [dict get $dCertsPbe hmacAlg]
  }
  if {[dict exists $dCertsPbe digestParamset]} {
    set digestParamset [dict get $dCertsPbe digestParamset]
  }
  if {[dict exists $dCertsPbe cipherAlg]} {
    set cipherAlg [dict get $dCertsPbe cipherAlg]
  }
  if {[dict exists $dCertsPbe cipherIV]} {
    set cipherIV [dict get $dCertsPbe cipherIV]
  }
  if {[dict exists $dCertsPbe cipherParamset]} {
    set cipherParamset [dict get $dCertsPbe cipherParamset]
  }

  #puts "pfxPbeKey"
  set cipherKey [pfxPbeKey $password $hmacAlg $hmacKeySalt $hmacKeyIter]

  #puts "pfxDataDecrypt"
  set certBags [pfxDataDecrypt $encrCerts $cipherAlg $cipherParamset $cipherKey $cipherIV]

  #puts "pfxCertBagsParse"
  set lcerts [pfxCertBagsParse $certBags]

  #puts "pfxKeyBagsParse" 
  set lKeyBags [pfxKeyBagsParse $keyBags]
  set dKeyBag [lindex $lKeyBags 0]
  if {[dict exists $dKeyBag keyBag]} {
    set keyBag [dict get $dKeyBag keyBag]
  }
  if {[dict exists $dKeyBag friendlyName]} {
    set key_friendlyName [dict get $dKeyBag friendlyName]
    dict set dRes friendlyName $key_friendlyName
    if {[info exists cert_friendlyName] && ($cert_friendlyName != $key_friendlyName)} {
      puts "pfxGetSingleKeyCert: Warning: certificate friendlyName: $cert_friendlyName is not equal to key friendlyName: $key_friendlyName"
    }
  }
  if {[dict exists $dKeyBag localKeyID]} {
    set key_localKeyID [dict get $dKeyBag localKeyID]
    dict set dRes localKeyID $key_localKeyID
#Ищем сертификат для ключа
    foreach dcert $lcerts {
	if {[dict exists $dcert "localKeyID"]} {
	    set cert_localKeyID [dict get $dcert "localKeyID"]
	} else {
	    continue
	}
	if {[info exists cert_localKeyID] && ($cert_localKeyID != $key_localKeyID)} {
	    continue
#    	    puts "pfxGetSingleKeyCert: Warning: certificate localKeyID is not equal to key localKeyID"
	}
	if {[dict exists $dcert "certificate"]} {
	    set cert [dict get $dcert "certificate"]
	    dict set dRes certificate $cert
	}
	if {[dict exists $dcert "friendlyName"]} {
	    set cert_friendlyName [dict get $dcert "friendlyName"]
	}
    }
  }

  #puts "pfxKeyBagDecrypt"
  set decrKey [pfxKeyBagDecrypt $keyBag $password]

  #puts "pfxKeyDataParse"
  set dKey [pfxKeyDataParse $decrKey]
  if {[dict exists $dKey version]} {
    set version [dict get $dKey version]
  }
  if {[dict exists $dKey keyAlg]} {
    set keyAlg [dict get $dKey keyAlg]
    dict set dRes keyAlg $keyAlg
  }
  if {[dict exists $dKey gost3410Paramset]} {
    set gost3410Paramset [dict get $dKey gost3410Paramset]
    dict set dRes gost3410Paramset $gost3410Paramset
  }
  if {[dict exists $dKey gost3411Paramset]} {
    set gost3411Paramset [dict get $dKey gost3411Paramset]
    dict set dRes gost3411Paramset $gost3411Paramset
  }
  if {[dict exists $dKey keyValue]} {
    set keyValue [dict get $dKey keyValue]
    dict set dRes keyValue $keyValue
  }
  
  return $dRes
}

proc ::GostPfx::pfxCreateSingleCertKey {password certificate keyValue keyAlg gost3410Paramset gost3411Paramset friendlyName localKeyID} {
  variable oid_Gost3411_2012_512 
  variable oid_gost28147_89 
  variable oid_tc26_gost_28147_89_param_A 
  variable oid_tc26_hmac_gost_3411_2012_512
  variable oid_pkcs5PBES2 
  variable oid_pBKDF2 
  variable oid_friendlyName 
  variable oid_localKeyID 
  variable oid_pkcs8ShroudedKeyBag 
  variable oid_pkcs7_data 
  variable oid_pkcs7_encrypted_data
  variable oid_PKCS12CertificateBag 
  variable oid_PKCS9x509Certificate
  
  set pfx ""
  set ctx [lrnd_random_ctx_create ""]

  # create identityData
  set friendlyNameData [asn::asnSequence [asn::asnObjectIdentifier $oid_friendlyName] [asn::asnSet [asn::asnBMPString $friendlyName]]]
  set localKeyIDData [asn::asnSequence [asn::asnObjectIdentifier $oid_localKeyID] [asn::asnSet [asn::asnOctetString $localKeyID]]]
  set identityData [asn::asnSet $friendlyNameData $localKeyIDData]
  
  # create private key data
  set oid3410Paramset [asn::asnObjectIdentifier $gost3410Paramset]
  set oid3411Paramset [asn::asnObjectIdentifier $gost3411Paramset]
  set paramsetSequence [asn::asnSequence $oid3410Paramset $oid3411Paramset]
  set oidKeyAlg [asn::asnObjectIdentifier $keyAlg]
  set keyAlgSequence [asn::asnSequence $oidKeyAlg $paramsetSequence]
  set keyOctets [asn::asnOctetString [asn::asnOctetString $keyValue]]
  set version [asn::asnInteger 0]
  set keyData [asn::asnSequence $version $keyAlgSequence $keyOctets]
  
  # create private key cipherKey
  set keySalt [lrnd_random_ctx_get_bytes $ctx 32]
  set cipherKeyIter 2048
  set hmacAlg $oid_tc26_hmac_gost_3411_2012_512
  set keyCipherKey [pfxPbeKey $password $hmacAlg $keySalt $cipherKeyIter]
  # create cipher algorithm and params
  set cipherAlg $oid_gost28147_89
  set cipherParamset $oid_tc26_gost_28147_89_param_A
  set keyCipherIV [lrnd_random_ctx_get_bytes $ctx 8]
  # encrypt private key data
  set encrKey [pfxDataEncrypt $keyData $cipherAlg $cipherParamset $keyCipherKey $keyCipherIV]

  # create private key PbeData
  set keyCipherParams [asn::asnSequence [asn::asnOctetString $keyCipherIV] [asn::asnObjectIdentifier $cipherParamset]]
  set keyCipherData [asn::asnSequence [asn::asnObjectIdentifier $cipherAlg] $keyCipherParams]
  set hmacAlgData [asn::asnSequence [asn::asnObjectIdentifier $oid_tc26_hmac_gost_3411_2012_512] [asn::asnNull]]
  set keyHmacData [asn::asnSequence [asn::asnOctetString $keySalt] [asn::asnInteger $cipherKeyIter] $hmacAlgData]
  set keyPbkdf2Data [asn::asnSequence [asn::asnObjectIdentifier $oid_pBKDF2] $keyHmacData]
  set keyPbeData [asn::asnSequence [asn::asnObjectIdentifier $oid_pkcs5PBES2] [asn::asnSequence $keyPbkdf2Data $keyCipherData]]
  
  # create keyBag
  set keyBagContext [asn::asnContextConstr 0 [asn::asnSequence $keyPbeData [asn::asnOctetString $encrKey]]]
  set keyBag [asn::asnSequence [asn::asnObjectIdentifier $oid_pkcs8ShroudedKeyBag] $keyBagContext $identityData]
  # create keyBags
  set keyBags [asn::asnOctetString [asn::asnSequence $keyBag]]
  set keysData [asn::asnSequence [asn::asnObjectIdentifier $oid_pkcs7_data] [asn::asnContextConstr 0 $keyBags]]
  
  # create certificate cipherKey
  set certSalt [lrnd_random_ctx_get_bytes $ctx 32]
  set certCipherKey [pfxPbeKey $password $hmacAlg $certSalt $cipherKeyIter]
  # create cipher algorithm and params
  set certCipherIV [lrnd_random_ctx_get_bytes $ctx 8]
  # create certPbeData
  set certCipherParams [asn::asnSequence [asn::asnOctetString $certCipherIV] [asn::asnObjectIdentifier $cipherParamset]]
  set certCipherData [asn::asnSequence [asn::asnObjectIdentifier $cipherAlg] $certCipherParams]
  set certHmacData [asn::asnSequence [asn::asnOctetString $certSalt] [asn::asnInteger $cipherKeyIter] $hmacAlgData]
  set certPbkdf2Data [asn::asnSequence [asn::asnObjectIdentifier $oid_pBKDF2] $certHmacData]
  set certPbeData [asn::asnSequence [asn::asnObjectIdentifier $oid_pkcs5PBES2] [asn::asnSequence $certPbkdf2Data $certCipherData]]
  # create certData
  set certData [asn::asnSequence [asn::asnObjectIdentifier $oid_PKCS9x509Certificate] [asn::asnContextConstr 0 [asn::asnOctetString $certificate]]]
  set certBag [asn::asnSequence [asn::asnObjectIdentifier $oid_PKCS12CertificateBag] [asn::asnContextConstr 0 $certData] $identityData]
  # create certBags
  set certBags [asn::asnSequence $certBag]

  # encrypt certBags
  set encrCertBags [pfxDataEncrypt $certBags $cipherAlg $cipherParamset $certCipherKey $certCipherIV]  
  # create certsInfo (non-constructed context here!) 
  set certsContent [asn::asnSequence [asn::asnObjectIdentifier $oid_pkcs7_data] $certPbeData [asn::asnContext 0 $encrCertBags]]
  set certsEncrData [asn::asnSequence [asn::asnInteger 0] $certsContent]
  set certsData [asn::asnSequence [asn::asnObjectIdentifier $oid_pkcs7_encrypted_data] [asn::asnContextConstr 0 $certsEncrData]]
  # create tbs
  set tbs [asn::asnSequence $certsData $keysData]

  # create hmacKey
  set hmacKeySalt [lrnd_random_ctx_get_bytes $ctx 32]
  set hmacPbaKey [string range [lcc_gost3411_2012_pkcs5 $password $hmacKeySalt $cipherKeyIter 96] 64 95]  
  # create hmac
  set hmacPba [lcc_gost3411_2012_hmac 64 $tbs $hmacPbaKey]
  # create macData
  set digestParams [asn::asnSequence [asn::asnObjectIdentifier $oid_Gost3411_2012_512] [asn::asnNull]]
  set hmacData [asn::asnSequence $digestParams [asn::asnOctetString $hmacPba]]
  set macData [asn::asnSequence $hmacData [asn::asnOctetString $hmacKeySalt] [asn::asnInteger $cipherKeyIter]]
  # create pfx
  set pfxData [asn::asnSequence [asn::asnObjectIdentifier $oid_pkcs7_data] [asn::asnContextConstr 0 [asn::asnOctetString $tbs]]]
  set pfx [asn::asnSequence [asn::asnInteger 3] $pfxData $macData] 

  lrnd_random_ctx_delete $ctx
  
  return $pfx
}

proc ::GostPfx::pfxCreateLocalKeyID {keyAlg gost3410Paramset privKeyValue} {
  variable oid_GostR3410_2001
  variable oid_GostR3411_94_with_GostR3410_2001
  variable oid_tc26_gost3410_2012_256
  variable oid_tc26_signwithdigest_gost3410_2012_256
  variable oid_tc26_gost3410_2012_512
  variable oid_tc26_signwithdigest_gost3410_2012_512
  
  set localKeyID ""  
  if {($keyAlg == $oid_GostR3410_2001) || ($keyAlg == $oid_GostR3411_94_with_GostR3410_2001) || \
  ($keyAlg == $oid_tc26_gost3410_2012_256) || ($keyAlg == $oid_tc26_signwithdigest_gost3410_2012_256)} {
    set par_id [string map {" " "."} $gost3410Paramset]
    set group [lcc_gost3410_2012_256_getGroupByOid $par_id]
    if {$group > 0} {
      set pubKey [lcc_gost3410_2012_256_createPublicKey $group $privKeyValue]
    } else {
      error "pfxCreateLocalKeyID: Unsupported paramset $gost3410Paramset"
    }
  } else {
    if {($keyAlg == $oid_tc26_gost3410_2012_512) || ($keyAlg == $oid_tc26_signwithdigest_gost3410_2012_512)} {
      set par_id [string map {" " "."} $gost3410Paramset]
      set group [lcc_gost3410_2012_512_getGroupByOid $par_id]
      if {$group > 0} {
        set pubKey [lcc_gost3410_2012_512_createPublicKey $group $privKeyValue]
      } else {
        error "pfxCreateLocalKeyID: Unsupported paramset $gost3410Paramset"
      }
    } else {
      error "pfxCreateLocalKeyID: Unsupported algorithm: $keyAlg"
    }
  }
  set octets [asn::asnOctetString $pubKey]
  set localKeyID [lcc_sha1 $octets]    
  return $localKeyID
}

package provide GostPfx 1.0.0
