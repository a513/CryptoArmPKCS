package require Tk
#package require tkpath 0.3.0
package require textutil
package require http
package require ip
package require tls
namespace import ::msgcat::mc

image create photo tiletitul -data {
iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAC53pUWHRSYXcgcHJvZmlsZSB0eXBlIGV4aWYAAHja7ZddcuwoDIXfWcUsAUkIwXL4rbo7mOXPARN3upM7
VZm6D/PQUDZYBkmcD9OJG3//mu4vFMoSXFBLMcfoUUIOmQs6yV/lasmHfd+Fzys8P9nd/YJhErRyPcZxxhfY9THBwrHXZ7uzdvyk4+i8+HAoK/KK1k+Sx5HwZafz7PJJ
qcRPyzlXPZN3ZP/1ORjE6Ap/wo6HkPjrfkWS6yq4CHcWXQNF0A9oC3rxq37ulu4bAe/ei36+Hbs85LgcfSwrvuh07KTf67dV+pwR8R2ZP2dkeof4ot+cPc05rtWVEB3k
imdRH0vZPQyskFP2tIhquBR92zWjJl98A7WOpVbnKx4yMbSeFKhToUljt40aUgw82NAyN5ZtS2KcuW0YYVWabE6ydEmg0UBOFpc7F9px84qHYAmRO2EkE5wRZjxV92r4
r/XJ0ZxrmxP5dGuFvHhtWaSxyK07RgEIzaOpbn3JXY1/LQusgKBumRMWWHy9XFSlx96SzVm8OgwN/vpeyPpxAIkQW5EMCQj4SKIUyRuzEUHHBD4FmbMEriBA6pQ7suSA
fQ84iVdszDHaY1n5MuN4AQiVKAY0WQpghaAh4ntL2ELFqWhQ1aimSbOWKDFEjTFaXOdUMbFgatHMkmUrSVJImmKylFJOJXMWHGPqcsyWU865FAQtocBXwfgCQ+UqNVSt
sVpNNdfSsH1aaNpis5ZabqVzl44jwPXYraeeexk0sJVGGDrisJFGHmVir02ZYeqM02aaeZab2qH6TO2V3L9To0ONN6g1zh7UYDb7cEHrONHFDMQ4EIjbIoANzYuZTxQC
L3KLmc8sTnBuIUtdcDotYiAYBrFOutk9yP2Wm4O6P+XG35FzC92fIOcWuk/kvnL7hlov+7iVDWh9hdAUJ6Tg8xs9psKpjCZThl9d/D79pHU/nfB29Hb0dvR29Hb0dvR2
9L93JBN/QGT8S/UPyVSTr3xQ9kUAAAGFaUNDUElDQyBwcm9maWxlAAB4nH2RPUjDUBSFT1tFkYqDEVQcMlRxsCAq4qhVKEKFUCu06mDy0j9o0pCkuDgKrgUHfxarDi7O
ujq4CoLgD4iTo5Oii5R4X1JoEeOFx/s4757De/cBwVqJaVbbOKDptpmMx8R0ZlXseEUAAxAwij6ZWcacJCXgW1/31E11F+VZ/n1/VreatRgQEIlnmWHaxBvE05u2wXmf
WGAFWSU+Jx4z6YLEj1xXPH7jnHc5yDMFM5WcJxaIxXwLKy3MCqZGPEUcUTWd8oNpj1XOW5y1UoU17slfGM7qK8tcpzWEOBaxBAkiFFRQRAk2orTrpFhI0nnMxz/o+iVy
KeQqgpFjAWVokF0/+B/8nq2Vm5zwksIxoP3FcT6GgY5doF51nO9jx6mfAKFn4Epv+ss1YOaT9GpTixwBPdvAxXVTU/aAyx2g/8mQTdmVQrSCuRzwfkbflAF6b4GuNW9u
jXOcPgApmlXiBjg4BEbylL3u8+7O1rn929OY3w91nHKofIvzKQAAAAlwSFlzAAAOxAAADsQBlSsOGwAAAAd0SU1FB+QBGRQqJW4w0VIAAAArSURBVEjH7c1BAQBABAAw
rqDkYuhxJfhtBZY1HZdeHBMIBAKBQCAQCARbPtk3AkGMboaWAAAAAElFTkSuQmCC
}

image create photo newtile -data {
iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAC5HpUWHRSYXcgcHJvZmlsZSB0eXBlIGV4aWYAAHja7ZZNkhshDIX3nCJHQBJCcBx+q3KDHD8PmrE9nkkq
k8oiC0M1NGpaEu+jsd348X26byiUhV1QSzHH6FFCDpkLbpK/ytWTD7vdhc8jjN/Z3e0BwyTo5RrGceYX2PX+goVjr+/tztrxk46j8+DNoazIK1o/SR5Hwpedztjlk1KJ
D8s5Vz0v78j+4zgYxOgKf9CIh5D4q70iyXUVXISWRddE1CIqCS3KR/3cTbpPBLzdPenn27HLXY7L0duy4pNOx076uX5bpceMiG+R+TEjEIr+sTzoN2dPc45rdSVEB7ni
WdTbUvYdJlbIeakRUQ2X4t52zajJF99ArWOp1fmKQSaG1pMCdSo0aey+UUOKgQcbeubGsm1JjDO3DSOsSpPNSZYOFiwN5ARmvuVCO25e8RAsIXInzGSCM9ocH6p7Nvxt
fedozrXNiXy6aYW8eG1ZpLHIrRazAITm0VS3vuSuzj+XBVZAULfMCQssvl4uqtJ9b8nmLF4dpgZ/fS9k/TiARIitSIYEBHwkUYrkjdmIoGMCn4LMWQJXECB1yh1ZchCJ
gJN4xcY7RnsuK19mHC8AoRLFgCZLAawQNER8bwlbqDgVDaoa1TRp1hIlhqgxRovrnComFkwtmlmybCVJCklTTJZSyqlkzoJjTF2O2XLKOZeCoCUU+CqYX2CoXKWGqjVW
q6nmWhq2TwtNW2zWUsutdO7ScQS4Hrv11HMvgwa20ghDRxw20sijTOy1KTNMnXHaTDPPcqN2qL6n9kzu99ToUOMNas2zOzWYzd5c0DpOdDEDMQ4E4rYIYEPzYuYThcCL
3GLmM4sTnFvIUhecTosYCIZBrJNu7O7kfsnNQd2vcuPPyLmF7l+QcwvdA7mP3D6h1ss+bmUDWl8hNMUJKfj8po7CqXCtbeLcSWuwfqL+vHdffeHl6OXo5ejl6OXo5ejl
6L93hL8P2f0EZEWS2uWral8AAAGFaUNDUElDQyBwcm9maWxlAAB4nH2RPUjDUBSFT1ulIhWHdlBxyFAdxIKoSEetQhEqhFqhVQeTl/5Bk4YkxcVRcC04+LNYdXBx1tXB
VRAEf0CcHJ0UXaTE+5JCixgvPN7Hefcc3rsP8DcqTDW7JgBVs4x0MiFkc6tC8BU+DCKMOMYkZupzopiCZ33dUzfVXYxneff9WX1K3mSATyCeZbphEW8Qz2xaOud94ggr
SQrxOfG4QRckfuS67PIb56LDfp4ZMTLpeeIIsVDsYLmDWclQiaeJo4qqUb4/67LCeYuzWqmx1j35C0N5bWWZ67SGkcQiliBCgIwayqjAQox2jRQTaTpPePiHHL9ILplc
ZTByLKAKFZLjB/+D37M1C1OTblIoAXS/2PbHCBDcBZp12/4+tu3mCRB4Bq60tr/aAOKfpNfbWvQI6N8GLq7bmrwHXO4AA0+6ZEiOFKDlLxSA9zP6phwQvgV619y5tc5x
+gBkaFapG+DgEBgtUva6x7t7Ouf2b09rfj/PTHLM9yO/3gAAAAlwSFlzAAAOxAAADsQBlSsOGwAAAAd0SU1FB+QBGRM6I8jecLMAAAAsSURBVEjH7c0xDQAwCAAwmH9N
+EEEyUzA1xpoVk9cenFMIBAIBAKBQCAQbPmRCALkiseKdAAAAABJRU5ErkJggg==
}

image create photo sw_token -data {
  iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4wsKDzoIZEcDjwAAAB1p
  VFh0Q29tbWVudAAAAAAAQ3JlYXRlZCB3aXRoIEdJTVBkLmUHAAAFEElEQVRIx5WVaWxUVRTHf/e9N9ubactMmWJbkEJTFsHSImCAsAmpgBEIiCFoVQQCiiuoaCK7EkNM
  jAqYCJGA8EFIUElAiEZME5VSgQqlteyklG6UTmdjZt5y/VAQEIVyP917c87533PO/3+u4D6WHOKg6/kpovUqLmQfo1+g8hmXkLNbkurcy1Ff66AuIfPP0AHzVh+ts8G3
  5D+K+KOcFfl/ug5l9Nk8MP2IWp8Ug9NU2Qz2dilDodqrbCbEXn9gKm1XvwdA3Ctw/4zJ1LTv++ec7p1S5XHSt7duavIWu4QlqGxzXkART3Ft95Eb93cBmAzsA+Zok/vX
  LyjOTL52Ka54xnhljzmF7WApd7qY8HplxpUubjPcbqn1Z1u0l8S9izNtRdmGppUFQYNTVx2Uf6HLt4eFBOadru0JwY+5boYMTpDuhdUb087eswdPj4qNGdo3yaKPsnY1
  R7QKV33Tuq+PGCTtGwASEAggZsKBCt+W3YeCtS9Ma1ub8in59wRwu8A0JRMnPTFz5ozHZm4vr5cpUwjlRoGjMYTXBwp4LJtN/TLmyJTJ8cPLAdk5FkkkpqZyNmQxesAD
  IidTR3M5oKGJ1JK1OEtnw+DBkBWEpMnFhnbk/dBUCEFjS4xTHy+ntTWFNX0uz5eOJfzOAozyYzg8PnxFxSjXDLBtsG/yS+msDixp443GSbSHMQ0DbInx628Ir47+3tso
  XTM7gv9rdRJA4nYo/CB7c8WfR1qGDqaJ/tbryFiM8PRZmCerweW6w7NzPZACf4bO0DeeJZUyKcoPglCIfbIexeUGyyLyzvv41q7BMaAf8n4yECCFgMaWCJteXs1nL77P
  l98epTkUIbl4MUl/wBZZQRxFhYR37qahtZ1oPIEQdwEYdnObkzSM7kKAKgTDswUz8m0cqTg7tx9kB7nUDJ8gFdvGPFjGX2GLbbsO8Vv5aRyaemeJRgBTV6xh6apljHS7
  S0a/tmRHrOFyJvIoTqfKYUceihVjQp/uzJj4CCgqxMernJ0Bts3IvJ6M9Hm5dK6R479sux1AbtiMWDSP8lXL0mY9XLgy+/GSxSPHjuXnXd8gJfgzdNZtfBPLshDSpOyn
  X7jc3Iymabg9Oj1zumHW/MX5i3X0zitAVRTARpsC7AHEonnkw9BxpaWbRpeUDHqgWzcMC9wuN0LA5ZYoe15dQiQUw/3cQsYVP0hWZjZOh4YQAsuyMDDo16sPcUMir7da
  23M9g17+wCdL134439+1qzcQCKCqKg/m9uSww9FhKCRJQ9LDY9BqJLkUNkgkDJCpjpEhrzNCSixDov6LpumL3l06Ld3v9+q6jsfjwel0cvJkNaFQW4eFquLPzaY91gVP
  IMCoop5gWv+pmUuNEY7XXc9gaHpGnp2TvXXv/v153XNzGT9hAlJKotEotWcu0BaOAJCdqTNp/jIs2yJNk2CY3Eb421R/i9DsYLAs2KtXj0g4zImqKiLRKAUFBVyLx4mn
  JKlkCikFhgW6o0N08i7/lJAgkFhWR820NK83p6i4mOqqKnRdp6KiAp/Ph5FKyQs1Z37v7nV103U1v+ZkJQsXn0P837Nvlz4vl5hI24kWcDmXBHy+dQMLC53rP/2UdFWt
  PF1bWxdpbDxWXVe3ojnw5FfnG5ryP5hVjSVVOhNfCDCMa1hRZ7UAmPjQQwNNt/u70ydObA0q6ud/JBNJIAHIEYwLZBdrr2R57eESjE4OX2FZItl0RSz7G8RkHM2jxn02
  AAAAAElFTkSuQmCC
}

image create photo cloud_token -data {
  iVBORw0KGgoAAAANSUhEUgAAACkAAAAUCAYAAAAQhBSFAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAC4jAAAuIwF4pT92AAAAB3RJTUUH4wsKEjQvSzCrSQAAAB1p
  VFh0Q29tbWVudAAAAAAAQ3JlYXRlZCB3aXRoIEdJTVBkLmUHAAAHgElEQVRIx62We4xdVRXGf2vv87j3zn3MTKcznZZ2+oAGYQAd3glJCdAqgjYmagAjEUP8B8GQQDQp
  ifEBSowaMajBBBOjCBEBA0FsaaSVWMRQK7S2QOlAhxaGuZ1hZu7znLP38o97Z4Rqqybuk5Ocs3P2t7+91re+dYSTjG/uPBTaNF0/X0/OVpFzK7HdWDBudSi+5dvJk1ay
  p2rzs8/c9ukPTwI88PRurrtijP/3kOMnvr19L1+5fJSHntu/5i9Vf2e17q51mcN5yBScU0SgGCtLsjkin02dfUr/Z669/Nxt/+2mqoqInPD9P5IEuHv7i6smZnhsLsk+
  5ByoEZLUUAw9pbzBOajOJziEQusYxbQ+dUo595EtN3x0N8B3HtzF7ddc/C+433/mVW699LT3khsQker/FMnnD07KBacO6R1PvvzEwWP1qwyKx1KMhGV5QylKERQQUueZ
  mk+ZnFea1aMsKcY7Vg0PPl1WefbWT13wzIk2vG/X+LqZucY36km2QvCVHOl8EXegZJo//txVl+0GmJuboVzuO3EkDx2dvvn2beP35CyAoS8fsryQYDXDiEFVQQQBvAr1
  JOHApCMIY3XvHJZTSvFXv3vT1V8/EcnbHv/7dUdnGj/x3pVQBVVy2vK2NWfWlMJNWz575XYR8e9dY44H+d6uN6+JDCBCHFqGCymBOujGEAGF7rNSiiPW9UOWJeJcxnyS
  mpOlLkm9y1LxkbVkzYRWKtRMydRMnter81tf2vv6mQD3Prh1cU1wPEjmtN8ARgyDsRJphgdEBEUQMRStEFpFgNQpWRywPNfgKJ4oMD0nI/nB4Shu9GW23WrAYER1rs2h
  6RYuHmC+WedH2154FDj1pms2/TOSz7899X6RGpoKhMYSB4p2YgYI1lhGypaxAc/5A8oFA8J5A8pZA5alOcjSjKFyfuRkJNuNpq/VM20kQq3pKecizhoymOYxNF+h4Vzl
  pd0vFQF++/SfOyR/8YMJ7t83sQjSn4+tB6wYIqvd6AmIMFSwnN6TkDMe9eBViYxhddmyPM5I0ox2kvmTkVwatEutJAmKccyKSoFmoqiJOH0gwJqA6pGJnif/eujLM4cn
  Vmy+4sIOyXu+Ncbnz1zJr/ceufaLj+59a3y2NRqIxSPdC1TBEzDWn+FVUQXBI3gUj4gFDFFzmhyNflW1qtpz3J0HGApatc3rS9mGwTZnF+fYuDylSEpciEhqkyw777L8
  q0m05a7f7/nNQ1v/tHZRk7c8tv/qp/Yde6CZZoRG8ESsW2IIM0WxACzvMYhPAMGIAF2yxgJK4mFyfA/jb/9x48+zg/WeQt6FQUAQhIRRxCOPb6tdv2nDxf39vWmjXlss
  iVyojPU22TUT0uMTJt6eotzXJ/PNmQubB6de/NUfXjgjuHv7q6tfm24/Xk8yAhNQylvWlTKSpNmtYIPHEBuPBzzSpS0YIyiKiCFLU6Iwz1nnrqM6Oxdv3b6TM8/5AJVS
  CfWeI5NTree27SjdEUYKta77dA5aKRVYNXWM5LS1nGEd+47WqdkephuNngNvTG0yjcR9rNHOEAko5wJG8glpmi3qUEQYLliW5Ryp6/iadmupU98Lc4qqp9lo4NIW46+9
  TmO+BuowFgyYc8ZGi965hvfeaXeN955W4hhZVqDQmqGdCesGLDmTksQlvPIlo2I3O4TMBwzkPKq+Y9goiVrWlC2jlRZ9gcN5j3R90ne4LZJDPcYYRJUoF7P5E1cyODjY
  1a8hdY5cT8kipIB6v+C2nUMbG3LRSJG14TyqhrJpkpqYeuZHTeZdoOqJQoiN62yI4lRZEsNIoY1FSH3XKxccvdsHVDtVLoDzHUmgljgX473DOcV7xYJE1oixgRERjOng
  WWsxRjrfiLCmP0chrWEBl6ZEUdA0gj4rgPcdsIXUeRXKgScnC2ntgBojdJXQTZfiPFhjUTrpq9fnufeH9/PmxFuEYdTRXblMfXZWRHRW1ad0ra3TZQ3WdpRuxNAbZmRJ
  ims36ImiX5r+2PwusoLzwlxmF9MoKE1vSDEdKxJ5TwSlKwk63cgIRhRjArz3hEHEpRsuordSInMep0oraUc2CrHGJCLGdzAWDuvf99vmnaM636Y3EmLj7gsuWTnwt3cb
  7zz8Rs19crJuKZc6ncarUG0LU23DcL4b5W6hKOBRRAVrDVYgHwXkczmm0+Lh0aXRI5detiHOsq6vApXe3rbMvPOyer/aGIP3oN53VKkg0jm0NXB4NiUIgmRlwdzz8bH1
  e4IL1y+p7a1O33j/ziP7j7X8lldmQrO2khDiEKPsqQq2z1PJLTTHbk1rx8SNgorQE4FWVjCXX7rvxptvuHVyYjwaHKooYQjADV8oIiLpXY71xppQ8SAG9QqiZJmSqWPH
  gSkOVRPisOfOu6+/5C7JVbIAYHSgf/aWh3Z/7YwlpZ+1s+z8RqM13KzN5EgTTTLlkVdaOlIMlnp8hPdR5hyZ92Suo8E4CnqsMWtOHR58cdXy4Z8CDK1ck/y7tlhetWr/
  Ew/v2Onrc6uMRdM0bVffnT2k3s3NJT7fCorPF3K926dqwbjkKg7gH7PT8gOZNhj/AAAAAElFTkSuQmCC
}

image create photo icon11_24x24 -data {
  iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4wsBDSwt514xcAAAAB1p
  VFh0Q29tbWVudAAAAAAAQ3JlYXRlZCB3aXRoIEdJTVBkLmUHAAAFGklEQVRIx6WVbWyV5RnHf/fzck5Pzzm0hZ51uK6bdGhk0CzaaJTBLMYXdJFh4wdIzbIPbAsmLGGO
  WbMXNNvMxj5hSdmGSGSwKESc6JbqEmeTisjRrJGOs4LVzUpfqBQ8BXqel/u/D31JsWVx25U8ee7nzpP/77qvtxs+YZKm3uWS7pZ0SNIpSUclPSTpqql//mubIZ6T1CFJ
  AwMDyufzKhQKCoJAkgattWsk8f+AOuM41s6dO1VdXa1sNqvKykqtW7dOQ0ODkjQs6er/Vfw+SeOdnZ1aunSpduzYocbGRgEC1NzcrPHxcUn69acVXCTpUUm1k9+/kKQN
  GzZo+/btkqT+/n4B8jxPmUxG+XxekkY/jb4DPAv8BHhT0hLAB+jt7aWrqwuAXbt2XZankZERgMr/JBxE8cQiiiLt3r1bPT09klSU9KIktba2TocFkO/7cl1XuVxOhUJB
  kvoAipeC6/51prjq3cHzTYUPzzWNFMdXScpMk6IoGt64caPq6urU0dGhKSsUCqqvr78MAmjr1q2y1krSZoCX3vrnb1r3HdUj+47aTbu79Nu/nJCk62ceeVN3d7eWLVum
  qqoq7d+/X5JkrdXJk6f00A+2aOWKFVq7dq0OHDgwVap5SdWSnMcP/a2t8eHntPpnL+mmRw7pW+1/vQzgAXsbGhoeaG9vb9y2bRvr16/HWktz832cPf0ONzXUcv7cEm65
  +XpWNX0N3/cj4A/AWUALskkV3h8hHwuCmC9UZwDsNMAYMyppy/Llyw8aY+aXSiVaWlp489W7eOzrr1BfnuCpD75KbslrvPPHZ1my5nkvtyCzAdgDLLqjofa6n66/Ed91
  8F2Xa6+qAPiypBLwnpkRqtXA7wcGBuY/vXc/xw63cvBRwLW88JrPnTeEhKWYv6cep3H1wzhwwwcfjX3nsYNvf3vk43EuBREXSxHFSyGfrSy/sOfBW/trKlNrvKnSM8b8
  WVLTwoULD/1wy/cXHU48x7HjR/jKYo97V4QoMIxdgGq/j+IFqEhz69mxUvTCkT6GRy+CO+mrMSyurUpfCqIUYJyJPTM1V04Ab0dRTP8/XsdP+BgjCAyS4cSHPuUJO7EH
  yYTnKpNOQMIFb/JxHCQRxna60ZiCGGNCoNvzXBav3sVQMY0zIYYxYK3hYuADBuC46xgv4bqzmiyORfBJwAz7FdDTuHItdXWLQQIDxhEvHwvo6KllXjkA93uu4yQ9Z6JD
  pj2FyIogjGcDJnMRAPskGAuSXAwcRsc8zo85zKu7jT+9epy2ticIw/CBbJn/DeYY2WFsKUVznMCY6aJ6KpOtiE779/NMV5YHnxB7O3O0bPode55sIwhCRkdH8V0nl/Bm
  hyiKLeHkLPLmGlTGmEFJ225uam5973P18KV3qclVULWgxqZS5X2bN2/+jLV2XrEUkfBmRzm2Iow1dw5m3FJ9rp9irPgRH585RTpdSTKZcoAfAysdx/mRRHc6OdvHyIpS
  GM0NmCzZNPDL8VLE1aU2aortVNCL4xiAFqDXGPNza5VPJ2YDZC1BdOUqAnjSWju/v+cwR07AybHlvNH5PMNDQwC3AbcDJHzHqcwk8R1DmWMocx1SrkMm6ZMu850r5gDI
  RVFIdl6G27/5NPdkv8j5069jiAGSQBognfQHv3v3svfra6vGy3yPVNIl6TnUVKTMLdfUDCMF5grX6Oclfc9aFrmu6QEKwI1AHZAHdhhjzkmqArKlMLYJ38Vc1g2K4lhn
  /g1uPt1CX20OBgAAAABJRU5ErkJggg==
}
image create photo icon_openfile_18x16 -data {
  iVBORw0KGgoAAAANSUhEUgAAABIAAAAQCAYAAAAbBi9cAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4wYXCDgNebfI9AAAAgZJ
  REFUOMuNkz9PFUEUxX/3zuxbQAlSkGhhaWEwRhNbY6Extmhi7Kz5CH4P/RZY2FnYEG20sKOSaExEBNTn44+P3Tdzr8U8Hw8k4G0mszvn5PzO7MrrO/PcfLXCSfPm3pXr
  9bnwLtQS8SMvFZqttCwAbxeuznY/9BfcCQcnisL3SDPzE4/mF8/f7cxViEp5bg6tE6ciK0/XiADd1f7Da08uPtOACoK7I5WgAFGQCZE4HQ6Fsex4MthLuHkxcqeuJlVj
  LSK1IB1BRJApxRsjnlXcIXrA1BGHrJABQkkYAVK3az64gHcEiQEUpFLUgQ5IE1B1jIRkcBfwDA4SO2AQt148eD59+fYNjb8LvgqFCeRIqYfqc8j9lv7Hl0gUos7N3a8v
  LY6dEP53rPeN9v3SAVqZ3eFWjokwFgMbWw0VGTfKuPdAAhBOSZYYadgGP2S0A/KjiD2AnIDnBmLFUH7hB7dmwAbwtRhJOAZr1ApIGqZNwC4iERgQsQxs4qwNseQELB8Z
  iifE+5AFHCJmwHfUNgDFVE8xy6g5WAJaDMXxv2hdaDYhhvIRov/6+BANIDlYhpRHNUSJWjaxLSVbUbkabo7j5Uc1QV2LLghEJ2TDg2KND+L+6pfl9fWlW4PeLm030/40
  9rcb0p7R9MCahJ6pqCedaiZQz1R0ZiOdWSVMKe3nwafBjj3+A1B95HRZw8dhAAAAAElFTkSuQmCC
}
image create photo ::img::view_18x16 -data {
  iVBORw0KGgoAAAANSUhEUgAAABIAAAAQCAYAAAAbBi9cAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4wUXCSwOiHJe/AAAAB1p
  VFh0Q29tbWVudAAAAAAAQ3JlYXRlZCB3aXRoIEdJTVBkLmUHAAADQklEQVQ4y22TS2hcZRiGn/8//7nMOZnMTDIzpqmYIU2KtVIvRBRERImoUNu4K4qCFxAqirhx78aN
  C0HES7GC6MKi4EakggsRKRSVWKOLhmAMaNKYnDO3c2bmXP7fRUJE9Nu9i++B7+X5RLcTmfWoYC3KASiylE6nQ1ByGeUaYTTSdvGDAAz/GiGgLvu0ajZqPSp48+eMk3dM
  kecZ/SgkmGiRFxlkOW4QEAQ+E56hMKCNwZICz3T5dVPwxjc9Xrm1j7oaZjy8MMX7y4a830MqHwOYTKP8KsqzKTsQt0N+i0ZsbsYs3dXgre/qvLqQU6TrxIwjPv1xy+hG
  ndcv/MSZW2o4SpKkGWO+j+WV9qCAPrhH0m2H2MpCS8MXq5JnWl2UzjPauzsU0uX0zRW2eyk3HpqkGowddBFrw9WtEeO+xaQ/IjN1Cl3w+8jhs+U1KrU6qh1FuEfmKIot
  zl3a5sMrA748e5yXLv6BpyRHGg5PnKjw6EcbPDQrcCR0BiO0cHn23jKq3EBIiQoCn14yAK1ZPDZJ63rFdFnx7ulpCkALiHN4bsFlrmFz+2EX5XnEcZ/Yr6NFCGjUcJRi
  LAm2ww3NCpab41rgWgKAHLiWdLmpaVPxJePlEoPhgMONBqtDSWEAAcpRFiMkllfmg+8j3rkU8vXZWS4sd3CUZEINWZz3ePrjDZZum6S12qUnApSzy2P3NND7bqm0MJTG
  x4GQ++fLVEsW02Wb1xabxMWA/lCxk2heuO86moHhybtbWEgMsDLgH1C1WiXSYAzMTtiU7ABbScI0YZRm5NpgK4sThyymp+rkSNJ9JQR7IKNBGcxeAM5fjjh/OeKTx5uc
  +/ZPPCWZaficPF7ixc87LC041PyEMM7RwPMPTqGBdriL4oAueGB+jHGVMuFkvH1mBi0k/cGQ2Hi8vKiYqTucmh+j2N9ZSSDt7OKXPJQA0gLuPFYnsgXNKY9fhg5XNgzZ
  sIdfqeG6DnNHfQRwcXffUgM/rIVgl+gnXcTKxo556qsR3WFBMYxBCKSlKEYJaqyGUC7/eXsg74Xg+NjJX7z3SBPR7bTN6rU+a9s9sgJKrk0yGFKpVLAc5/8YtKMQz7Xp
  9xOOTldp2CP+BgHpZjZpGm3KAAAAAElFTkSuQmCC
}

image create photo ::img::update_18x16  -data {
  iVBORw0KGgoAAAANSUhEUgAAABIAAAAQCAIAAACUZLgLAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4wUXCQUsGVSA8wAAAmZJREFUKM9Vk0FIFFEYx//fzI67
  zi5JUXhyobXVqEAwEUQEWzJELIR0ofAoLVaHwEMkKEtFnSTo0CHqUlcXxRbKc0gkkRKFoh6DDpLuwjrvzcyb93WYUbcfvMP7v+//wf+975GUkpkBEBEAbG0Z5XLs3fvf
  HbmBtRepE+bozWB4OMhmiZmZ2TAMZoYIkVJI6RUKOpHQAKebZm58g8mABnQioScmPKXEEZFN7u351waiKoCbrDf5cix+JGhA9/f71aqMbFJKoZQ3Pa3rS4DK1aG+noP/
  NT015TFLIQSk68rNzfq2QVeXt7DgVvYdIUslr7MzqDvkjQ3pugLC81Q+f+zp7RVCCKWk60opwjzd3erIOTKilBIQ1WqQzerD7HJlRQSBqMP3xeqqtKyopLU1qFSEQbUa
  HAchZ04jk4Hr4hAi8n20tKC5OVIcB0KQwTiGGWBG+ICRwkRgZq25XjSQSsFORr13d+OOqrcRERlw9xONbDQlCIBtI5mEQbatL3cCIKDWceHe+mNPeZZpEZFBhmVaSqmZ
  H3czDwtDc8/TaX3xkk6lEOMgCIrF2F5VnW153SFf/Xr79e/6dO+jwcwgM5e3Pzxdebb257tpwjLN/P30g9wtpUBCCNO0Xn6Zm/38xCOlfBeaTTOWakgBXPMOgkDBIAAI
  uHhlZrav6CqPwlE+8J3xxfFPPz/CDoMxwiugaEFyrj1XGp1vtGxmNsLxTzUkF8cWJvsmE0YcAYMBAghgIOCEEb/TU1i+vdwYs6Pv4jgOERFRuN+p7CxtLs1vlrb3twC0
  nWofOz863Hb93MlWAoGgtSaif7CvjZ1AETa3AAAAAElFTkSuQmCC
}

image create photo creator_small -data {
  R0lGODlhPABOAOf/ABQUHBwTExYVGBgUHhkVEh8UEB0WGygVFxkaIRkbGRwbFSAaFSQYHiQZFxgcHhwbHh8bGiQdFCgcFB8gJx8hHyUgGiMgIx0iIyofGyQhICkgISMj
  HDIgHjcgGyskGTAjGjEiJy0kJC8kIDUjHColKSomJSwmICUoJzsoGEEnHjspHUAnIzItGDgqJzsqIzYsHi4tMTEtLDQtJzUsMi8vKDguLy8yL08qIkssJEUtL0MvJEcu
  JEIvKTkyLEguKT4xKjY0KDczMjU1LTM1OlExKE4zKT43MTs5LUo2JTc7Ljo6MjU6QT86Kkc3MUs3K1szJE81Pl8yLkE5RFQ3Iz87OjU9STs9OlM3M0M9Jz48QDk+QFo3
  Jlw2Llo2NUY8P1g5L2E2OD1BSGE9NmM9MWA9PFpANGc8PWw9N0VHSlFERUlHRUNIUGdBME1GTnE/MlRHQlRGT0tKQ2NFMFxGQXNBRGxFPGpFQ2JJPHJGMXpCR09OUVJP
  TYZHOXpKQlpSV3ZMQnlNPXJOTXBQRIFNP2RTYV1XVntROlZaV19YUXZTP2xVT1hZY1laXY5TWIlWUYtXSYhbQG9gYH9eUGpjX2NlYIhcTWtkWHZhWZFbSHFhbGBna4Rg
  TGZmbIZfXGtlcZViVpRnWmxybn1ubJBpaJVqUXZve5JsXnJ0d4tvYXJ0fpVuWnt0bmx4gX97jKR1ZK10X595WKF5X5p7bXyChJ97ZaF6boWBfJx7d32Di3iEk5CAfLiD
  eqyJbKmIhayKcrCIe5qOiYmSoa2Lfa+NaI2Sm46TlqWOiKiPfrmTdrKWj8WShLeWhr2UibyYgZqfqJyho5mhsaefnL+dj7Khlrmgj7qfmMaio6WstMGmn8elmcKnmM6k
  l6qvsbKuqL6tpKmywciun8+toMqupsyxtcW4r7S8zNq1o9i2qda2sNK4qdG5sNe5pb6+wLvAyb3E1N/BrN/DtOPDvd7GvcPM28zMzM7P2crT5OzQx9DZ4dHc7dfk9vrf
  0+Pq6eDt/ebz+////yH+EUNyZWF0ZWQgd2l0aCBHSU1QACH5BAEKAP8ALAAAAAA8AE4AAAj+ABMkeGBAAwYNGg5oCFEhw4YEDhxYsCBAAIUYMnrIMFGiB5AeIIGIBCKk
  JJAjST4eYXLkCBAlQjYEMFDRQQIBDxJMzLAQoQYRIkqUoCAgwQaiFmnQiME0RpAeT0H2cFmyJUqVTE4eUQJkAwECRQVCTECBZwiEGESYCGEiwwMKZB9UpEBDho0YNIRI
  lWoEphIlLZMItlqyZA8PCyoKzGkzAQSfbEWcDWHhAQQIFhDMZWqjZOe9RvRWdSlYsJCWhYUgBrt4oMDHFdZKRuj2gYMHJB4AGHCBRA3PnT2fTi1EpNWWI0/GXCBWbETH
  FSqUCIGhAu0Hby2UsDBgAA0rVNT+xFFD3ooVJeb/CvkbePDxkRUgKBZr2/GGhhkyrA1R+ygFEmEwEsopnJwSSiicHFJIIQr6cUgcSfyVBEruWQXfV85h54ABD2zg4Ych
  hLDdBRCccMgsxBRTDCuzcKLJKZowwsginHDCyCHnlaREacW9B4QMGmDYGgIIYEdWWfllUAIJF5wQiopQ4jKLJlRqssiVVCIYB3HoWTGaS0cUt8ECCogFAUQ1CbRTBg4g
  MMEJszyjopyz4AKjJpQwYuUilIQyZRxKBCeEeVZsBRhyQtAwZpmvJaDZfBmciV1OhTxjKTHO4CIlJ6mkwkqVp5wyyyyhUGJFZyTtOCFMJ8GUKAT+BZzp2kDYFUkBBRbQ
  moAN3FjqDKbESFlnnamcwsopxcLICBqpaVUcSIX9WMECZJZ5mQURIXACCdyS8GYCz3DTqzPkEhNsMcJy4omLVObJSI6F7XiEUj1EK0ME1SqgLwQTXOAvriW0VRkavT5z
  zcHlFmNusLh0qgknlByihx7nCQqYEjIoJQNJxXmgr7WX9dvktjCcEJEAlhosbsHPkItuKlSuy8kie6iRhRdG3FWCaErUgFfGStGAQQMNVBBBdBVYQMEJMMDgFAkDWdEN
  MSqLm3KwmqzBiaYw6vHGDzzw0EQTR2ikWgkYxXCXDTSYsEEHI2DwgQcfzH0BAhbYIJT+iBc4oEbLgFuq8KeL4JLiKX54UQPYYfOgww9GaKRRCQycIIMMJaBa1wsvqMD5
  CyxYMMEEJCzJ7USHkNuyig1TiQu5pxQCRQ4+7ICEDjzQHrYOTfzgAkglXBYw2zS0ZAQWWLDUgxGiTzQRCRpYoAEjdK5iCyWr4FKMwcREMkcZZIgxRhFF7KBD7ebr4ETY
  LnDQQgsVbCAUUxlEFwG+C0SAAd7OT4SdAWEoxixsYQtgFDAachJFIBJhCEAA4g91GAMRnFAEHeggfRZcwQpawIG0LEBJQpkWvgpAQglIgEhFmhR2JmAAZ7CjG92Ihgxh
  CIxj/IIWqogFKCpRiU1Iggz+VyjfDpxwux1osH0HiZRQTGC0+y2AhBE4IQofwID+BQGG3SBHN6YxDXV4AxzpAAc1lnEMX8CCFKSoBAS5wIUobGEMW0ifC0bwgQZsoAEW
  IEGk8reArxSgASd8AAIGAAABbGgCFKBEFsnBSG84UhvpCKMYj0ELUmxiE2o8wxnYcIYo1IENFdTBHD+AgQg0AAKRmtYCAkCAAASAaESSSwofYAEY2GKRjCQHNr4YyUhS
  wxeq+IMchtmHYvahDmeogyC+IMoV0LGDp7yMKltJgD82YIoAwI4FsuAHXDayGmCMJDi0QY1jqCIRbBgDG/rgiEGocQx1qEMZ1qcCFXwAmpf+uQy1XElCWKIQAAgwQN6A
  QQ51ZNGR0wCnOKmhjWWgQhJlKMITnsAGTJzRDTcoAhLWx4M5jmCO0clAH1cZgAK4kmgVSaEBDMAAIXgDG/JwpCPFUQ1xgGOc1KCGJGQhCydMYQtthMQwSPGEHaggBSlQ
  Afta4AJSaiA+X6kmCV+JgYpkM6ArjYM2dhEPLzoyHTUdZzNoQQthiKMXlQCEHLjghlgggxRsQEEH5lo3FYhyjhwQgQeiGtVXolQAhSQIh1ogjVecw6beUEc6tGFTcAy1
  FssQRi1AgQc24IEUzViGK86Ag7lyAJAjSIFH87rXvpZ0ARVoAGABkE2CNIADynj+xTbQIQ55qGOc6rjtWGlhRlVAwhCVcCszmKGKM9xgrh3gAAdGENpniqACJm1lAJ64
  AAxwYDesFcBKD3CAXexiG9LQRkyxAUnFasMXvIAFJipBiljE4hfgFYYp3LCFFCR3BXOcK3NHIAIOsNIArixpAzAggQeARbsrZcABXKEMZTiiGjGdBiThIQ90LGMZlSSF
  K14RC2ZsIxvSMMUZJGjfFaRgBR1wJh1dgIECrNSVCxhwKbGzmwGs1AAHAMU2PvEJadhWHJGUR4WlsYxfuNcVpMDEL7JhjnDUwg1nIMIOkEpl0Ta1BR/oJ9Hy14AFFDgz
  3bkxA/6wDVfE4hjwSHP+muNBWxAzgxc6xAQmmiGNX0h2EH3gAg5wUGUc4NcFLRBBlytQHaNJIIp5PMEELMBSntwBvNKQBYWFbFt1ZOPSzPiFevkw5z5EQRby/QMRvrCD
  Hex5zytAgQt+8NkIaCADHqiABzzwgg88byIaIAEISnAHIp8jHJOWBzwUCw6aMsMXrhjEIEzBC1LU4hagEMRRi+CDU/N5BSr4nQcAiQFae6DbHuBABiiwnW6BYAY5GO45
  4nEPSsMjHukQB6Zr8QlHCMMXvuCpJARRhnlecAdFIAIOdjBH321bAuCuG61doCQS5JFb567BLbYB7ElPWh3iEEedQeEKMh6Dp7JAxR3+BHGHOdwOB0QQogtc0FEJDHjW
  Clf4CfYWAojXoAaKiMc7gi1kjIsDG8swxS+kkYxeGOMYqECFIu6w9Dc4oXZFGLgPOvqDFmDg6hGY9f2+bYKZLylEJJhBDWbwA13Eu92U9rk2jiEMbRjj7Ue/hSkCcQem
  f+8K1S711HlQ9aFdXW6z9oBaSjBzboUgBmKfARSacIlq3CPNPbepNpKRDGwYQxfGQIUpRhEIMZThCt+bQxOCKHDc8Z2DDfjAC1yQVBTUUwVCWVJTxE4FL3hBEbVVMzwk
  +fNkVCPpx1gGM3rxCTdwgQg+yMHY8B51Uf6A1cql4wdG0IG51W1JM5gBU7L+XwMlNGEOl2D37tMBj1+DA+PTuIQstAEOIvfiEX0YMbVX8IPlO+5xPbB6WmZ9EKRVAAYk
  0DQzkBFBUANG8H2o0G7lR360JQ65NQ2SIA3yFlmqYAhuMAZj8AVFgGI+4AROYEEqADkt4HJDQzRbFh0woH1OEQPL4wW1dwW3oIDpEA7kF0bxZgzCkA00hWGkMAhnwEZE
  IGUAdwVNEDbPV3UuBwHUElX55DRqAxVBYARUAB6UMA0yGA7Adg6RlA3VUA2XVg33RgufkGdPEITl4wRl0Ds/IASRY3UNsQEKQABicSsx4DQ2EARBQAW1ZwWnwA7YEA9p
  9mvhcA5aeFjogA7+4ZANmcYLrvAJgzAGxydwReCBfBcaR1B1IQWHzUGHToOHeXgzcUAP/KAOgLh7WEiIWIiFh3gOYMgLqgB/UVCGAucDPmBBP2CARmAEL4AB+VECcSiH
  CXACJ1CHMDAEQ5AF4WEF3OAP/UAPpAgP63CKiSgN1KiD6FANRkYKj9BJbHR8OFA7IfgUiyMDDTERArEBJ2ADVjAENmCMQyAFWUAeocCM+lAPh3iIqRgORHZh1EhktWAK
  oOCDkPgFszh1HgEEuWgEMoABZQEXG0ADd2gFNDAEVpAFUiAFthcG/NAP+tAP+TAO4oAOgjiNF7YM1ChZkzWGf5BOX4B3PrACPND+A34ROeSYH7eyNDZwhzGQBTyZBWEQ
  BpxAj/owlO1QDdggb5cGYiZJjZEFTJUwCBCEgQTpkpCTh0qQiz3QFuMmEOloAzfXNGtQCq0ADfjgkfnQkf1gD7pQDdUIYvu4DM3QDMjglJUQQXAUhLTIAyyxHlepEeN2
  K2TRlTBgBdtzDd/gDvPgDh5pD0PZD/3wDJewDNTQj8uAb8LAC/nmCqqACfHHBV9AQdQ2dVX5F0YQBPBjk0vzHTBgA0qAmNdQDvPwDeWQlvZwlo5pD4gQCMIgmZHFC8Pg
  C7GgCpOlCpUQfxrYBHg5dbk4A30RJjXAiw5nAReQkzlpBe1QDu1gD/b+AA3foA/24A62yZHOcAWCUAvCIAy0kF6xYAo85AhqFEEaWARdkJdHkJDscQRAkkfO05VagAb1
  8A3tkA/lAA3QoJ3giZZpSQhkcAadYAqqYAqbYAjx9AcPVAdiIAYaGER49wMt4Sp/8RT8ITq3IYxZoAdo4A7f8A3bSS7z8J21iZb64AwrAAZ2IAiS8Ad9wAZicAZ/EJUX
  +gUt6QP29QE04KEf2gMi8B8lcwLGqAVhsAQo2g7uAA3OcA2IiZhn2ZjuAAVdIAbxNAZiwAVkUAeb8Afi8wUXWgY7QAajIHKKEAlvYChCEAQ/EAIwsARDoAVa0KR46g7g
  +Q3k8g2x6Q7+5cCYjWkPkXAFXKBOkNgFXVAHiVAHXQCmX3AHl+AN8SAO1lANlHcMktAEf0EFNRAC/akFS3CqWaCnVuAOtUmgzqCiglqo+mCb3zAJV/AFiwqJXOClyEQG
  XHAFqKAOtjUO1mANySBZpHAGoGoENwcCVqAHayAFYcCTqsqq20mg4BkM5aCiZ5kP0LAIVxBEX4CBbSQ+8SQGnYAN7aap1dALyXALnVAHX5ADoVqAIKAGa1AFVXCq/Aql
  +YCiB4MP5ZALslmwucAKcBCuQDoGUcBGaCo+ydBuGIcN1jAKdqALi4CRU0gFxggDLUACWpCv/XqqQ1AOAoqighoMwZCiwQD+DQcbDAmrqIsaBWAApGJwB+cgZL3XC53Q
  B5fQDhmLjFQQsm0gBSIAAkugryOLp/Pwr/Ygm+WgstAwoPMQDKzACl5wq+MqBlGAoVsgCeFwD2H0rpIQCHZABrowD4swrVOYBYvgCcFgAEirr/t6qnWbDy36tFOqKVM7
  oGsAB1BwBY7KBemEgWOQCO8gttiADbdABnZwfFcADPWwBnrgBT3JCJ4ADQNQAklLt0mbBUlrD/Mwq4cZDKlgONuKbmDgqF2wumOQTGMgCOmwD+qADZwqCILgqb8aDfWw
  CGjQkyXqB9CAAGrQBmFAt1Xwk2GwBgeaD6V7usQADVIQuF0guI7+agY7uknLQLuLWw2jIAio0AlmSwbR0A6cAAcTowZ6wAh6gAsX0AaM4Af5qq9hgAZrcKL54JHl4A6t
  0AqpUAypAAWBSwYETMCa5KXUsA/woA1d2At/EAidcLZiQL7skAp+sAc1gwZ6MASpMAF6UAgyIr9VoKc/qZhpWbWtgCzFQAhQAAbhc6F2YAd1EAWmcA8KXE7GwLN1wAVm
  ULNXQMGccME10wZo8Ls2QAkLMgmTUAh64JNZgAbz0A/+oA/f4L+hUgpQUMDxZAZmYAeB0Avy8HNdaJS2uwy1IAmS0JJkAAzs4AlCrAZpAAeWWwNpgAiIsMSFEAnsuwRa
  kL+OGQz+pVAsq5AJBSzD8VQHknAP6EANY0zG1NCpsmAKYvDDpfAMQYzBNZMGakAFPfAGSlwIlGAJk4DEe4AGfpwPweAJpVAKkbAKokAGdxDD8SQJ7Fa7tjvGxgByqCAI
  8vQFZJAGq7DEmFwzNlMDlKDEiGAJokwJzMwI+sCM7pALq5wJomA9osAGMYy78LAPioxxjdwLkSwJFloG41oHTYAIlDDMe+AFm1wDh6DE8KzEkTDKUuy8qxwJopDPtqAL
  l+DFssvNtrWp50l5RScLmyAG1fsFZSAGOeAH6TzME6MFnRwJheAH8zwJkTDPlOAP/rCdpUAI1awLurDP/CwI4QDQGPeirqAACrXADJwayXUQruFDBj7wBg+tzllQA4Gw
  03YwB60sz5PAjFFbCtS8CtZTQMCgC+KAdoeIDQDZCY3gCJ3QC7WQDL/wB+QMpF2QA548zIiAwYrTCY5wBmc7B6JwzErMjN8gzZlQCiNN0sDgDfdwD7mlDtZwC8XkCI6Q
  B3RAB6CADr/wiOKD0OccCRhcCJjsB1LQAoEQfxNMBoGgCBg9CQEBADs=
}
global wizDatacsr
global wizDatacert
array set wizDatacsr {
  type "Физическое лицо"
  O ""
  OU ""
  C ""
  ST ""
  L ""
  CN ""
  INN ""
  SNILS ""
  OGRN ""
  OGRNIP ""
  UN ""
  street ""
  title ""
  givenName ""
  SN ""
  E ""
  U ""
  emailAddress ""
  keypassword ""
  keypassword2 ""
  capassword ""
  exit "cancel"
  username ""
  caname ""
  wizardtype ""
  role ""
  typekey "gost2012_256"
  parkey "1.2.643.2.2.35.3"
  dn ""
  ckzi "Наименование СКЗИ пользователя"
  expkey 0
  selfca 0
  selfssl 1
  token ""
  cwapi ""
  libp11_fn "Выберите библиотеку PKCS#11"
  csr_fn ""
  key_fn ""
  keypassword ""
  keytok 1
}
set g_iso3166_codes {
  Австралия AU Австрия AT Азербайджан AZ {Аландские о-ва} AX Албания AL Алжир DZ {Американское Самоа} AS
  Ангилья AI Ангола AO Андорра AD Антарктида AQ {Антигуа и Барбуда} AG Аргентина AR Армения AM Аруба AW
  Афганистан AF {Багамские о-ва} BS Бангладеш BD Барбадос BB Бахрейн BH Беларусь BY Белиз BZ Бельгия BE Бенин BJ
  {Бермудские о-ва} BM Болгария BG Боливия BO {Босния и Герцеговина} BA Ботсвана BW Бразилия BR
  {Британская территория в Индийском океане} IO {Британские Виргинские о-ва} VG {Бруней Даруссалам} BN
  {Буркина Фасо} BF Бурунди BI Бутан BT Вануату VU Ватикан VA Великобритания GB Венгрия HU Венесуэла VE
  {Виргинские о-ва (США)} VI {Внешние малые острова (США)} UM {Внешняя Океания} QO {Восточный Тимор} TL Вьетнам VN
  Габон GA Гаити HT Гайана GY Гамбия GM Гана GH Гваделупа GP Гватемала GT Гвинея GN Гвинея-Бисау GW Германия DE
  Гернси GG Гибралтар GI Гондурас HN {Гонконг (особый район)} HK Гренада GD Гренландия GL Греция GR Грузия GE
  Гуам GU Дания DK {Демократическая Республика Конго} CD Джерси JE Джибути DJ Диего-Гарсия DG Доминика DM
  {Доминиканская Республика} DO {Европейский союз} EU Египет EG Замбия ZM {Западная Сахара} EH Зимбабве ZW
  Израиль IL Индия IN Индонезия ID Иордания JO Ирак IQ Иран IR Ирландия IE Исландия IS Испания ES Италия IT
  Йемен YE Казахстан KZ {Каймановы острова} KY Камбоджа KH Камерун CM Канада CA {Канарские о-ва} IC Катар QA
  Кения KE Кипр CY Киргизия KG Кирибати KI Китай CN {Кокосовые о-ва} CC Колумбия CO {Коморские о-ва} KM Конго CG
  Коста-Рика CR {Кот дИвуар} CI Куба CU Кувейт KW Лаос LA Латвия LV Лесото LS Либерия LR Ливан LB Ливия LY Литва LT
  Лихтенштейн LI Люксембург LU Маврикий MU Мавритания MR Мадагаскар MG Майотта YT {Макао (особый район)} MO
  Македония MK Малави MW Малайзия MY Мали ML {Мальдивские о-ва} MV Мальта MT Марокко MA Мартиника MQ
  {Маршалловы о-ва} MH Мексика MX Мозамбик MZ Молдова MD Монако MC Монголия MN Монтсеррат MS Мьянма MM Намибия NA
  Науру NR Непал NP Нигер NE Нигерия NG {Нидерландские Антильские о-ва} AN Нидерланды NL Никарагуа NI Ниуе NU
  {Новая Зеландия} NZ {Новая Каледония} NC Норвегия NO ОАЭ AE Оман OM {Остров Буве} BV {Остров Вознесения} AC
  {Остров Клиппертон} CP {Остров Мэн} IM {Остров Норфолк} NF {Остров Рождества} CX {Остров Святого Бартоломея} BL
  {Остров Святого Мартина} MF {Остров Святой Елены} SH {Острова Зеленого Мыса} CV {Острова Кука} CK
  {Острова Тёркс и Кайкос} TC {Острова Херд и Макдональд} HM Пакистан PK Палау PW {Палестинские территории} PS
  Панама PA {Папуа Новая Гвинея} PG Парагвай PY Перу PE Питкэрн PN Польша PL Португалия PT Пуэрто-Рико PR
  {Республика Корея} KR Реюньон RE {Российская Федерация} RU Руанда RW Румыния RO Сальвадор SV Самоа WS Сан-Марино SM
  {Сан-Томе и Принсипи} ST {Саудовская Аравия} SA Свазиленд SZ {Свальбард и Ян-Майен} SJ {Северная Корея} KP
  {Северные Марианские о-ва} MP {Сейшельские о-ва} SC {Сен-Пьер и Микелон} PM Сенегал SN {Сент-Винсент и Гренадины}
  VC {Сент-Киттс и Невис} KN Сент-Люсия LC Сербия RS {Сербия и Черногория} CS {Сеута и Мелилья} EA Сингапур SG
  Сирия SY Словакия SK Словения SI {Соломоновы о-ва} SB Сомали SO Судан SD Суринам SR США US Сьерра-Леоне SL
  Таджикистан TJ Таиланд TH Тайвань TW Танзания TZ Того TG Токелау TK Тонга TO {Тринидад и Тобаго} TT
  Тристан-да-Кунья TA Тувалу TV Тунис TN Туркменистан TM Турция TR Уганда UG Узбекистан UZ Украина UA
  {Уоллис и Футуна} WF Уругвай UY {Фарерские о-ва} FO {Федеративные Штаты Микронезии} FM Фиджи FJ Филиппины PH
  Финляндия FI {Фолклендские о-ва} FK Франция FR {Французская Гвиана} GF {Французская Полинезия} PF
  {Французские Южные Территории} TF Хорватия HR ЦАР CF Чад TD Черногория ME Чехия CZ Чили CL Швейцария CH Швеция
  SE Шри-Ланка LK Эквадор EC {Экваториальная Гвинея} GQ Эритрея ER Эстония EE Эфиопия ET ЮАР ZA
  {Южная Джорджия и Южные Сандвичевы Острова} GS Ямайка JM Япония JP
}
set rfregions  {{Республика Адыгея (Адыгея)} {Республика Башкортостан} {Республика Бурятия} {Республика Алтай}
{Республика Дагестан} {Республика Ингушетия} {Кабардино-Балкарская Республика} {Республика Калмыкия}
{Карачаево-Черкесская Республика} {Республика Карелия} {Республика Коми} {Республика Марий Эл}
{Республика Мордовия} {Республика Саха (Якутия)} {Республика Северная Осетия - Алания}
{Республика Татарстан} {1Республика Тыва} {Удмуртская Республика} {Республика Хакасия} {Чеченская Республика}
{Чувашская Республика - Чувашия} {Алтайский край} {Краснодарский край} {Красноярский край} {Приморский край}
{Ставропольский край} {Хабаровский край} {Амурская область} {Архангельская область и Ненецкий автономный округ}
{Астраханская область} {Белгородская область} {Брянская область} {Владимирская область} {Волгоградская область}
{Вологодская область} {Воронежская область} {Ивановская область} {Иркутская область} {Калининградская область}
{Калужская область} {Камчатский край} {Кемеровская область} {Кировская область} {Костромская область}
{Курганская область} {Курская область} {Ленинградская область} {Липецкая область} {Магаданская область} 15
{Московская область} {Мурманская область} {Нижегородская область} {Новгородская область}
{Новосибирская область} {Омская область} {Оренбургская область} {Орловская область} {Пензенская область}
{Пермский край} {Псковская область} {Ростовская область} {Рязанская область} {Самарская область}
{Саратовская область} {Сахалинская область} {Свердловская область} {Смоленская область} {Тамбовская область}
{Тверская область} {Томская область} {Тульская область} {Тюменская область} {Ульяновская область}
{Челябинская область} {Забайкальский край} {Ярославская область} {г. Москва} {г. Санкт-Петербург}
{Еврейская автономная область} {Ханты-Мансийский автономный округ - Югра} {Чукотский автономный округ}
{Ямало-Ненецкий автономный округ} {Иные территории, включая, г. Байконур}}

global mydir
set mydir [file dirname [info script]]
global typesys
set typesys [tk windowingsystem]
if {$typesys == "x11"} {
    set myfont [font configure TkDefaultFont]
    #puts "myfont=$myfont"
    set myfont [lreplace $myfont 5 5 bold]
    set com "font create TkDefaultFontBold $myfont"
    set com [subst $com]
    eval $com
    set myfont [lreplace $myfont 3 3 12]
    set com "font create TkFontForFirst $myfont"
    set com [subst $com]
    eval $com
}

global macos
set macos 0
set ::filetypesrc {
  {{File for sign (MS)} {.doc}}
  {{File for sign (MS)} {.docx}}
  {{File for sign (TXT)} {.txt}}
  {{File for sign (BIN)} {.bin}}
  {{File for sign (PDF)} {.pdf}}
  {{File for sign (XML)} {.xml}}
  {{All Files} *}
}
set ::filetypep7s {
  {{PKCS7 (DER)} {.p7s}}
  {{PKCS7 (DER)} {.sig}}
  {{PKCS7 (DER)} {.p7b}}
  {{PKCS7 (PEM)} {.pem}}
  {{All Files} *}
}

set ::ku_options {"Цифровая подпись" "Неотрекаемость" "Шифрование ключа" "Шифрование данных" "Согласование ключа" "Подпись сертификата" "Подпись СОС/CRL" "Только шифровать" "Только расшифровать" "Аннулирование списка подписей"}
set ::bc_options {
  {}
  {CA:FALSE}
  {critical, CA:FALSE}
  {CA:TRUE}
  {critical, CA:TRUE}
}
set ::bc ""

set ::ku0 1
set ::ku1 1
set ::ku2 1
set ::ku3 1
for {set i 4} {$i <= 9} {incr i} {
  set ::ku$i 0
}
set ::pointca ""
set ::rpw ""
set ::pw ""

set ::tokeninfo ""
#"[mc {Token information}]:\nМетка:\nПроизводитель:\nТип:\nСерийный номер:\nНомер слота:"
#set ::listtok {"Токен LS11SW2016" "Токен LSCLOUD"}
set ::listtok [list "Программный токен" "Облачный токен"]
set ::handle ""
set ::tektoken "sw"
set ::pkcs11_module "libls11sw2016.so"
set ::listx509 {}
set ::slotid_teklab ""
set ::slotid_tek -1
set ::dercert ""
set ::cert_pkcs11_id ""
set ::pagescsr {}
set ::wizpagecsr 0
set ::pagescert {}
set ::wizpagecert 0
set ::formatCSR 0
set ::dateSign "Документ подписан: ЧЧММДДГГГГ"
set ::dateSignTST "Метка получена: не получалась"
set ::dateSignEscTS "Метка утверждена: не утверждалась"
set ::p7s_hex ""
set ::tekTSP ""
set ::tekTSPadd ""
set ::certfrompfx ""
set ::tekdns 0
set ::tekip 0
set ::tekemail 0
set ::Listedns {""}
set ::Listeip {""}
set ::Listeemail {""}
set ::sslcert 0
set ::ssldomen ""
set ::tlssrv 0
set ::tlscln 0
set ::egais 0
set ::certegais 0
set ::lisalko 0
set ::yearcert 1
set ::dayscert 0
set ::dayscert2 0
set ::snforcert [clock seconds]
set ::pkcs11_status -1
variable certfor
set certfor 1

#set ::listx509 [list "Токен не подключен"]
set ::listx509 [list ]
package require pki
rename ::pki::x509::parse_cert ::pki::x509::parse_cert_old

proc ::pki::x509::parse_cert {cert} {
  array set parsed_cert [::pki::_parse_pem $cert "-----BEGIN CERTIFICATE-----" "-----END CERTIFICATE-----"]
  set cert_seq $parsed_cert(data)

  array set ret [list]

  # Decode X.509 certificate, which is an ASN.1 sequence
  ::asn::asnGetSequence cert_seq wholething
  ::asn::asnGetSequence wholething cert

  set ret(cert) $cert
  set ret(cert) [::asn::asnSequence $ret(cert)]
  binary scan $ret(cert) H* ret(cert)

  ::asn::asnPeekByte cert peek_tag
  if {$peek_tag != 0x02} {
    # Version number is optional, if missing assumed to be value of 0
    ::asn::asnGetContext cert - asn_version
    ::asn::asnGetInteger asn_version ret(version)
    incr ret(version)
  } else {
    set ret(version) 1
  }

  ::asn::asnGetBigInteger cert ret(serial_number)
  ::asn::asnGetSequence cert data_signature_algo_seq
  ::asn::asnGetObjectIdentifier data_signature_algo_seq ret(data_signature_algo)
  ::asn::asnGetSequence cert issuer
#LISSI
  binary scan [::asn::asnSequence $issuer] H* ret(issuer_hex)

  ::asn::asnGetSequence cert validity
  ::asn::asnGetUTCTime validity ret(notBefore)
  ::asn::asnGetUTCTime validity ret(notAfter)
  ::asn::asnGetSequence cert subject
#LISSI
  binary scan [::asn::asnSequence $subject] H* ret(subject_hex)

  ::asn::asnGetSequence cert pubkeyinfo
#LISSI
  binary scan $pubkeyinfo H* ret(pubkeyinfo_hex)

  ::asn::asnGetSequence pubkeyinfo pubkey_algoid
  ::asn::asnGetObjectIdentifier pubkey_algoid ret(pubkey_algo)
  ::asn::asnGetBitString pubkeyinfo pubkey

  set extensions_list [list]
  while {$cert != ""} {
    ::asn::asnPeekByte cert peek_tag

    #add		"0x81"
    #add		"0x82"
    switch -- [format {0x%02x} $peek_tag] {
      "0x81" {
        ::asn::asnGetContext cert - issuerUniqueID
      }
      "0x82" {
        ::asn::asnGetContext cert - subjectUniqueID
      }
      "0xa1" {
        ::asn::asnGetContext cert - issuerUniqID
      }
      "0xa2" {
        ::asn::asnGetContext cert - subjectUniqID
      }
      "0xa3" {
        ::asn::asnGetContext cert - extensions_ctx
        ::asn::asnGetSequence extensions_ctx extensions
        while {$extensions != ""} {
          ::asn::asnGetSequence extensions extension
          ::asn::asnGetObjectIdentifier extension ext_oid

          ::asn::asnPeekByte extension peek_tag
          if {$peek_tag == 0x1} {
            ::asn::asnGetBoolean extension ext_critical
          } else {
            set ext_critical false
          }

          ::asn::asnGetOctetString extension ext_value_seq

          set ext_oid [::pki::_oid_number_to_name $ext_oid]

          set ext_value [list $ext_critical]

          switch -- $ext_oid {
            id-ce-basicConstraints {
              ::asn::asnGetSequence ext_value_seq ext_value_bin

              if {$ext_value_bin != ""} {
                ::asn::asnGetBoolean ext_value_bin allowCA
              } else {
                set allowCA "false"
              }

              if {$ext_value_bin != ""} {
                ::asn::asnGetInteger ext_value_bin caDepth
              } else {
                set caDepth -1
              }
              						
              lappend ext_value $allowCA $caDepth
            }
            default {
              binary scan $ext_value_seq H* ext_value_seq_hex
              lappend ext_value $ext_value_seq_hex
            }
          }

          lappend extensions_list $ext_oid $ext_value
        }
      }
    }
  }
  set ret(extensions) $extensions_list

  ::asn::asnGetSequence wholething signature_algo_seq
  ::asn::asnGetObjectIdentifier signature_algo_seq ret(signature_algo)
  ::asn::asnGetBitString wholething ret(signature)

  # Convert values from ASN.1 decoder to usable values if needed
  set ret(notBefore) [::pki::x509::_utctime_to_native $ret(notBefore)]
  set ret(notAfter) [::pki::x509::_utctime_to_native $ret(notAfter)]
  set ret(serial_number) [::math::bignum::tostr $ret(serial_number)]
#LISSI
  set snstr [::asn::asnBigInteger [math::bignum::fromstr $ret(serial_number)]]
  binary scan $snstr H* ret(serial_number_hex)

  set ret(data_signature_algo) [::pki::_oid_number_to_name $ret(data_signature_algo)]
  set ret(signature_algo) [::pki::_oid_number_to_name $ret(signature_algo)]
  set ret(pubkey_algo) [::pki::_oid_number_to_name $ret(pubkey_algo)]
  set ret(issuer) [_dn_to_string $issuer]
  set ret(subject) [_dn_to_string $subject]
  #My
#  set ret(issuer_bin) $issuer
#  set ret(subject_bin) $subject

  set ret(signature) [binary format B* $ret(signature)]
  binary scan $ret(signature) H* ret(signature)

  # Handle RSA public keys by extracting N and E
  switch -- $ret(pubkey_algo) {
    "rsaEncryption" {
      set pubkey [binary format B* $pubkey]
      binary scan $pubkey H* ret(pubkey)

      ::asn::asnGetSequence pubkey pubkey_parts
      ::asn::asnGetBigInteger pubkey_parts ret(n)
      ::asn::asnGetBigInteger pubkey_parts ret(e)

      set ret(n) [::math::bignum::tostr $ret(n)]
      set ret(e) [::math::bignum::tostr $ret(e)]
      set ret(l) [expr {int([::pki::_bits $ret(n)] / 8.0000 + 0.5) * 8}]
      set ret(type) rsa
    }
  }
  return [array get ret]
}

array set ::param3410 {
  "1 2 643 2 2 35 1"	"id-GostR3410-2001-CryptoPro-A-ParamSet"
  "1 2 643 2 2 35 2"	"id-GostR3410-2001-CryptoPro-B-ParamSet"
  "1 2 643 2 2 35 3"	"id-GostR3410-2001-CryptoPro-C-ParamSet"
  "1 2 643 2 2 36 0"	"id-GostR3410-2001-CryptoPro-XchA-ParamSet"
  "1 2 643 2 2 36 1"	"id-GostR3410-2001-CryptoPro-XchB-ParamSet"
  "1 2 643 7 1 2 1 1 1"	"id-tc26-gost-3410-2012-256-paramSetA"
  "1 2 643 7 1 2 1 1 2"	"id-tc26-gost-3410-2012-256-paramSetB"
  "1 2 643 7 1 2 1 1 3"	"id-tc26-gost-3410-2012-256-paramSetC"
  "1 2 643 7 1 2 1 1 4"	"id-tc26-gost-3410-2012-256-paramSetD"
  "1 2 643 7 1 2 1 2 1"	"id-tc26-gost-3410-2012-512-paramSetA"
  "1 2 643 7 1 2 1 2 2"	"id-tc26-gost-3410-2012-512-paramSetB"
  "1 2 643 7 1 2 1 2 3"	"id-tc26-gost-3410-2012-512-paramSetC"
}

set ::listtsp [list "http://sp2.ekey.ru:90/tsa" "http://ca.rzd.ru/tsp-3/tsp.srf"]

set ::oidData			"1 2 840 113549 1 7 1"
set ::oidSignedData		"1 2 840 113549 1 7 2"
set ::oidEnvelopedData		"1 2 840 113549 1 7 3"
set oidSignedAndEnvelopedData	"1 2 840 113549 1 7 4"
set oidDigestedData		"1 2 840 113549 1 7 5"
set oidEncryptedData		"1 2 840 113549 1 7 6"
set ::oidAttributeContentType	"1 2 840 113549 1 9 3"
set ::oidAttributeMessageDigest	"1 2 840 113549 1 9 4"
set ::oidAttributeSigningTime	"1 2 840 113549 1 9 5"
#timeStamp
set ::oidtimeStampToken             "1 2 840 113549 1 9 16 2 14"
#Второй штамр времени
set ::oidesctimeStamp           "1 2 840 113549 1 9 16 2 25"
set ::oidCertificateRefs        "1 2 840 113549 1 9 16 2 21"
set ::oidrevocationRefs         "1 2 840 113549 1 9 16 2 22"
set ::oidcertValues             "1 2 840 113549 1 9 16 2 23"
set ::revocationValues       	"1 2 840 113549 1 9 16 2 24"
set id-ct-TSTInfo		     "1 2 840 113549 1 9 16 1 4"
set id-aa-signingCertificate         "1 2 840 113549 1 9 16 2 12"
set ::oidsigningCertificateV2        "1 2 840 113549 1 9 16 2 47"

#Считываем размеры экрана в пикселях
set ::scrwidth [winfo screenwidth .]
set ::scrheight [winfo screenheight .]
#Считываем размеры экрана в миллиметрах
set ::scrwidthmm [winfo screenmmwidth .]
set ::scrheightmm [winfo screenmmheight .]
#Запоминаем сколько пикселей в 1 мм
set ::px2mm [winfo fpixels . 1m]
puts "$::scrwidth  $::scrwidthmm $::px2mm"
set ::typetlf 0
#Проверяем, что это телефон
if {$::scrwidth < $::scrheight} {
    set ::typetlf 1
}
if {$::typetlf} {
    set userpath $env(EXTERNAL_STORAGE)
    set ::libcloud [file join $userpath "ls11cloud" "libls11cloud.so"]
} else {
    set userpath $env(HOME)
    set ::libcloud [file join $userpath "ls11cloud" "libls11cloud.so"]
}
if {[file exists $::libcloud]} {
    set myHOME1 $env(HOME)
    set mm [file join $myHOME1 "libls11cloud.so"]
    file delete -force $mm
  set err [catch {file copy -force $::libcloud $mm} res]
  if {$err} {
    tk_messageBox -title "Копирование биб-ки" -icon error -message "Установить не удалось."
  } else {
    set ::libcloud $mm
  }
}
#---------------------------------------------------------------------------
# asnT61String: encode tcl string as UTF8 String
#----------------------------------------------------------------------------
proc asn::asnT61String {string} {
  return [asnEncodeString 14 [encoding convertto utf-8 $string]]
}
#------------------------------------------------------------------------
# asnGetT61String: Decode T61 string from data
#------------------------------------------------------------------------
proc asn::asnGetT61String {data_var print_var} {
  upvar 1 $data_var data $print_var print
  asnGetByte data tag
  if {$tag != 0x14} {
    return -code error \
    [format "Expected T61 String (0x14), but got %02x" $tag]
  }
  asnGetLength data length
  asnGetBytes data $length string
  #there should be some error checking to see if input is
  #properly-formatted utf8
  set print [encoding convertfrom utf-8 $string]
        	
  return
}	

#Список токенов со слотами
proc listts {handle} {
  set slots [pki::pkcs11::listslots $handle]
  #    puts "Slots: $slots"

  set listtok {}
  foreach slotinfo $slots {
    set slotid [lindex $slotinfo 0]
    set slotlabel [lindex $slotinfo 1]
    set slotflags [lindex $slotinfo 2]
    set tokeninfo [lindex $slotinfo 3]

    if {[lsearch -exact $slotflags TOKEN_PRESENT] != -1} {
      lappend listtok $slotlabel
      lappend listtok $slotid
      lappend listtok $tokeninfo
      lappend listtok $slotflags
    }
  }
  #Список найденных токенов в слотах
  #    puts $listtok
  return $listtok
}
#Список сертификатов
proc listcerttok {handle token_slotlabel token_slotid} {
  #    puts "token_slotlabel=$token_slotlabel"
  #    puts "token_slotid=$token_slotid"
  set listCer {}

  set ::certs_p11 [pki::pkcs11::listcertsder $handle $token_slotid]
  if {[llength $::certs_p11] == 0} {
    return $listCer
  }
  #puts $certs

  array set ::arrayCer []
  foreach certinfo_list $::certs_p11 {
    unset -nocomplain certinfo
    array set certinfo $certinfo_list
    set ::arrayCer($certinfo(pkcs11_label)) $certinfo(cert_der)
    lappend listCer $certinfo(pkcs11_label)
  }
  return $listCer
}


proc ::updatetok {} {
#Возвращает
# 1 - все хорошо
# -1 - нет библиотеки
# 0 - нет подключенных токенов
# Строка с инф-цией об ошибке

  variable nickCert
  global wizDatacsr
  global wizDatacert
  set wizDatacsr(keytok) 0
#  set selecttok ".st.fr1.fr2_tokens"
# set saveCert ".st.fr1.fr2_certs"
  #puts "UpdateListTok"
  if {$::handle != ""} {
    catch {::pki::pkcs11::logout $::handle 0}
    catch {set ::handle [pki::pkcs11::unloadmodule $::handle]}
    set ::handle ""
  }
  if {$::pkcs11_module == ""} {
    tk_messageBox -title [mc "PKCS#11 library"] -icon error -message "Выберите библиотеку PKCS#11 для токена"
    set ::pkcs11_status -1
    return  -1
  }
#create_template_sw_token
  if {[catch {set ::handle [pki::pkcs11::loadmodule "$::pkcs11_module"]} result]} {
	set cm [string first "TOKEN_NOT_RECOGNIZED" $result]
	if { $cm != -1} {
#У Токена отсутствует лицензия
	    set ::pkcs11_status 3
	    return $result
	}
    tk_messageBox -title "Библиотека PKCS#11" -icon error -message "Плохая библиотека PKCS11\n$::pkcs11_module" -detail "$result\nlen=[string length $::pkcs11_module]\n$::pkcs11_module"
#    set ::handle ""
#    set ::pkcs11_status -1
#    set ::pkcs11_module ""
    return $result
  }
  #Список найденных токенов в слотах и сертификатов
  set ::slotid_tek -1
  set lists [listts $::handle]
  if {[llength $lists] == 0} {
#Отсутствует подключенный потен
	set ::pkcs11_status 1
#    set ::tokeninfo "Токены отсутствуют"
#    tk_messageBox -title "Библиотека PKCS#11" -icon info -message "Токены отсутствуют\n"
    #Автоматическое обновление токенов
#    after 10000 updatetok
    return 0
  }

  set i 0
  set ::listtok {}
  set oldslot $::slotid_teklab
  set j 0
  foreach {lab slotid tokeninfo slotflags} $lists {
    #	    puts "Токен \"$lab\" находится в слоте \"$slotid\""
    lappend ::listtok $lab
    if {$i == 0} {
      set ::tokeninfo "Информация о токене:\nМетка: [lindex $tokeninfo 0]\nПроизводитель: [lindex $tokeninfo 1]\nТип: [lindex $tokeninfo 2]\nСерийный номер: [lindex $tokeninfo 3]\nНомер слота: $slotid"
    }
    if {$::slotid_tek == -1} {
      set ::slotid_tek $slotid
      set ::slotid_teklab $lab
    }
    if {$oldslot == $lab } {
      set ::slotid_tek $slotid
      set ::slotid_teklab $lab
      set j $i
    }
#    set cm [string first "CKF_USER_PIN_INITIALIZED" $slotflags]
#tk_messageBox -title [mc "FLAGS"] -icon info -message "ЛИЦЕНЗИЯ=$slotflags"
    incr i
  }
  set ::nickTok [lindex $::listtok 0]

  if {[catch {set ::listx509 [listcerttok $::handle $::slotid_teklab $::slotid_tek]} result]} {
	set cm [string first "TOKEN_NOT_RECOGNIZED" $result]
	if { $cm != -1} {
#У Токена отсутствует лицензия
	    set ::pkcs11_status 3
	    return $result
	}
    tk_messageBox -title "Библиотека PKCS#11" -icon error -message "Плохая библиотека PKCS11\n$::pkcs11_module" -detail "$result\nlen=[string length $::pkcs11_module]\n$::pkcs11_module"
  }

    set cm [string first "USER_PIN_INITIALIZED" $slotflags]
    if { $cm == -1} {
#Токен не инициализирован
	set ::pkcs11_status 2
	return $slotflags
    }

  set nickCert [lindex $::listx509 0]
  set wizDatacsr(keytok) 1
#Все ОК
  set ::pkcs11_status 0
  set fnt {.fn1 .fn7  }
  set fnc {.fn2 .fn4 }
  foreach fn $fnt {
    $fn.tok.listTok configure -state normal
    $fn.tok.listTok configure -values $::listtok
    $fn.tok.listTok configure -state readonly
    $fn.cert.listCert configure -state normal
    $fn.cert.listCert configure -values $::listx509
    $fn.cert.listCert configure -state readonly
  }
if {1} {
  foreach fn $fnc {
    $fn.tok.listCert configure -state normal
    $fn.tok.listCert configure -values $::listx509
    $fn.tok.listCert configure -state readonly
  }
}
  .fn11.tok.listTok configure  -state normal
  .fn11.tok.listTok configure -values $::listtok
  .fn11.tok.listTok configure  -state readonly
  .fn5.tok.listTok configure  -state normal
  .fn5.tok.listTok configure -values $::listtok
  .fn5.tok.listTok configure  -state readonly
  .fn6.tok.listTok configure  -state normal
  .fn6.tok.listTok configure -values $::listtok
  .fn6.tok.listTok configure  -state readonly
#  .fn3.p1.page.tok.listTok configure  -state normal
#  .fn3.p1.page.tok.listTok configure -values $::listtok
#  .fn3.p1.page.tok.listTok configure  -state readonly

if {0} {
  .fn1.tok.listTok configure -values $::listtok
  .fn1.cert.listCert configure -values $::listx509
  .fn2.tok.listCert configure -values $::listx509
  .fn4.tok.listCert configure -values $::listx509
  .fn5.tok.listTok configure -values $::listtok
  .fn7.tok.listTok configure -values $::listtok
  .fn7.cert.listCert configure -values $::listx509
  .fn11.tok.listTok configure -values $::listtok
}
  return 1	
}

proc create_template_sw_token {} {
global mydir
global env
#Ввести параметр для пересоздания и уничтожения
    set userpath $env(EXTERNAL_STORAGE)

    set tokpath [file join $userpath ".LS11SW2016"]
#file delete -force $tokpath
#exit
tk_messageBox -title "Проверка токена" -icon info -message "Токена существует????"

    if {![file exists $tokpath]} {
        tk_messageBox -title "Проверка токена" -icon info -message "Токена не существует:\n$tokpath"
        file mkdir $tokpath
	if {![file exists $tokpath]} {
    	    tk_messageBox -title "Проверка токена" -icon info -message "Не удалось создать папку:\n$tokpath"
    	    return
	} 
    	tk_messageBox -title "Проверка токена" -icon info -message "Папка для токена создана:\n$tokpath"	
    	# generate random bytes for signature
	set rnd_ctx [lrnd_random_ctx_create ""]
	set rnd_bytes [lrnd_random_ctx_get_bytes $rnd_ctx 40]
	set frnd [file join $tokpath "prng_start.bin"]
	if {![file exists $frnd]} {
    	    set fd [open $frnd w]
    	    chan configure $fd -translation binary
    	    puts -nonewline $fd $rnd_bytes
    	    close $fd
    	}
    } else {
#set dd [file join $mydir "create_sw_token"]
#set rc [file attributes  $dd -permissions 0755]
#set rc [exec chmod  0755  $dd]
#set rc [eval $dd]

	set frnd [file join $tokpath "prng_start.bin"]
tk_messageBox -title "Проверка токена" -icon info -message "Токена существует=$tokpath\n$frnd"
    	# generate random bytes for signature
	set rnd_ctx [lrnd_random_ctx_create ""]
	set rnd_bytes [lrnd_random_ctx_get_bytes $rnd_ctx 40]
	if {![file exists $frnd]} {
    	    set fd [open $frnd w]
    	    chan configure $fd -translation binary
    	    puts -nonewline $fd $rnd_bytes
    	    close $fd
    	    tk_messageBox -title "Проверка токена" -icon info -message "Датчик нет, создаем:\n$frnd"
	} else {
        tk_messageBox -title "Проверка токена" -icon info -message "Датчик:\n$frnd"
	}
    }
#Инициализация программного токена
    set handle [pki::pkcs11::loadmodule $::pkcs11_module]
    set sopin "87654321"
    set labtok "testtoken"
    set token_slotid 0
#===========
  set slots [pki::pkcs11::listslots $handle]
  #    puts "Slots: $slots"
  set listtok {}
  foreach slotinfo $slots {
    set slotid [lindex $slotinfo 0]
    set slotlabel [lindex $slotinfo 1]
    set slotflags [lindex $slotinfo 2]
    set tokeninfo [lindex $slotinfo 3]
tk_messageBox -title "FLAGS" -icon info -message "FLAGS $slotlabel:\n $slotflags"
  }
    set mkuser [file join $tokpath "MK_USER"]
    if {[file exists $mkuser]} {
tk_messageBox -title "FLAGS" -icon info -message "MK_USER присутствует "
	catch {::pki::pkcs11::logout $handle 0}
	catch {set handle [pki::pkcs11::unloadmodule $handle]}
	return
    }
if {0} {
#    set ind [string first "TOKEN_INITIALIZED" $slotflags]
    set ind [string first "USER_PIN_INITIALIZED" $slotflags]
    if {$ind != -1 } {
tk_messageBox -title "FLAGS" -icon info -message "Токен присутствует "
	catch {::pki::pkcs11::logout $handle 0}
	catch {set handle [pki::pkcs11::unloadmodule $handle]}
	return
    }
}
#========
tk_messageBox -title "FLAGS" -icon info -message "Токен не создавался "
if {0} {
    set ret [pki::pkcs11::inittoken $handle 0 $sopin $labtok]
    catch {::pki::pkcs11::logout $handle 0}
    set userpin "11111111"
    set newpin "01234567"
    if {[catch {set ret [pki::pkcs11::inituserpin $handle 0 $sopin $userpin]} result]} {
	tk_messageBox -title "inituserpin" -icon error -message "BAD inituserpin:$result"
    } else {
	if {[catch {set ret [pki::pkcs11::setpin $handle $token_slotid "user" $userpin $newpin ]} result]} {
	    tk_messageBox -title "setpin" -icon error -message "BAD setpin:$result"
	} else {
	    tk_messageBox -title "Test token" -icon info -message "User PIN: $newpin\nРекомендуем сменить"
	}
    }
}
    catch {::pki::pkcs11::logout $handle 0}
    catch {set handle [pki::pkcs11::unloadmodule $handle]}
}

set ::pki::oids(2.5.4.42)  "givenName"
set ::pki::oids(1.2.643.100.1)  "OGRN"
set ::pki::oids(1.2.643.100.5)  "OGRNIP"
set ::pki::oids(1.2.643.3.131.1.1) "INN"
set ::pki::oids(1.2.643.100.3) "SNILS"
#Для КПП ЕГАИС
set ::pki::oids(1.2.840.113549.1.9.2) "UN"
#set ::pki::oids(1.2.840.113549.1.9.2) "unstructuredName"
#Алгоритмы подписи
#    set ::pki::oids(1.2.643.2.2.19) "ГОСТ Р 34.10-2001"
set ::pki::oids(1.2.643.2.2.3) "GOST R 34.10-2001 with GOST R 34.11-94"
set ::pki::oids(1.2.643.2.2.19) "GOST R 34.10-2001"
set ::pki::oids(1.2.643.7.1.1.1.1) "GOST R 34.10-2012-256"
set ::pki::oids(1.2.643.7.1.1.1.2) "GOST R 34.10-2012-512"
set ::pki::oids(1.2.643.7.1.1.3.2) "GOST R 34.10-2012-256 with GOSTR 34.11-2012-256"
set ::pki::oids(1.2.643.7.1.1.3.3) "GOST R 34.10-2012-512 with GOSTR 34.11-2012-512"
set ::pki::oids(1.2.643.100.113.1) "KC1 Class Sign Tool"
set ::pki::oids(1.2.643.100.113.2) "KC2 Class Sign Tool"

#source "AllOIDS.tcl"
array set ::payoid1 {
  1.2.643.6.3.1.2.2 "МЭТС"
  1.2.643.6.7 "B2B и B2G"
  1.2.643.6.15 "Фабрикант"
  1.2.643.6.14 "Центр реализации"
  1.2.643.100.2.1 "Росреестр"
  1.2.643.3.8.100.1.113 "Росреестр"
  1.2.643.2.2.34.25 "Росреестр"
  1.2.643.2.2.34.26 "Росреестр"
  1.3.6.1.5.5.7.3.1 "TLS Web Server Autentication Certificate"
  1.3.6.1.5.5.7.3.2 "TLS Web Client Autentication Certificate"
  1.3.6.1.5.5.7.3.3 "Code Signing Certificate"
  1.3.6.1.5.5.7.3.4 "Email Protection Certificate"
  1.3.6.1.5.5.7.3.8 "Time Stamping Certificate"
  1.3.6.1.5.5.7.3.9 "OCSP Responder Certificate"
}
array set dn_fields {
  C "Country" ST "State" L "Locality" STREET "Adress" TITLE "Title"
  O "Organization" OU "Organizational Unit"
  CN "Common Name" SN "Surname" GN "Given Name" INN "INN" OGRN "OGRN" OGRNIP "OGRNIP" SNILS "SNILS" EMAIL "Email Address"
  UN "KPP"
}
array set dn_fields_ru {
  C "Страна" ST "Регион" L "Местность" STREET "Адрес" TITLE "Название"
  O "Организация" OU "Подразделение"
  CN "Общепринятое имя" SN "Фамилия" GN "Имя, отчество" GIVENNAME "Имя,отчество" INN "ИНН" OGRN "ОГРН" OGRNIP "ОГРНИП" SNILS "СНИЛС" EMAIL "Адрес эл.почты"
  UN "unstructuredName"
}
# GOST R 34.10-2012 TC 26 parameter sets: (0~Test, 1~A, 2~B, 3~C, 4~ExA, 5~ExB)
# TC26 GOST R 34.10-2012 512 parameter sets: (0~Test, 1~A, 2~B, 3~C)
# GOST R 34.10-2001 Crypto-Pro parameter sets: (0~Test, 1~A, 2~B, 3~C, 4~ExA, 5~ExB)
array set param3410 {
  "1 2 643 2 2 35 1"	"id-GostR3410-2001-CryptoPro-A-ParamSet"
  "1 2 643 2 2 35 2"	"id-GostR3410-2001-CryptoPro-B-ParamSet"
  "1 2 643 2 2 35 3"	"id-GostR3410-2001-CryptoPro-C-ParamSet"
  "1 2 643 2 2 36 0"	"id-GostR3410-2001-CryptoPro-XchA-ParamSet"
  "1 2 643 2 2 36 1"	"id-GostR3410-2001-CryptoPro-XchB-ParamSet"
  "1 2 643 7 1 2 1 1 1"	"id-tc26-gost-3410-2012-256-paramSetA"
  "1 2 643 7 1 2 1 1 2"	"id-tc26-gost-3410-2012-256-paramSetB"
  "1 2 643 7 1 2 1 1 3"	"id-tc26-gost-3410-2012-256-paramSetC"
  "1 2 643 7 1 2 1 1 4"	"id-tc26-gost-3410-2012-256-paramSetD"
  "1 2 643 7 1 2 1 2 1"	"id-tc26-gost-3410-2012-512-paramSetA"
  "1 2 643 7 1 2 1 2 2"	"id-tc26-gost-3410-2012-512-paramSetB"
  "1 2 643 7 1 2 1 2 3"	"id-tc26-gost-3410-2012-512-paramSetC"
}

#global mydir
#set mydir [file dirname [info script]]
update
wm title . "Full-screen with NO decorations"
wm overrideredirect . yes      ;# removes window decorations

set ::certfrompfx ""
################
if {0} {
pack [text .t -wrap none] -fill both -expand 1
set count 0
set tabwidth 0

font delete TkDefaultFont
font create TkDeafaultFont -family {Arial} -size 10
option add *font TkDefaultFont

.t insert end "This is a simple sampler Функционал\n"

foreach family [lsort -dictionary [font families]] {
    .t tag configure f[incr count] -font [list $family 10]
    .t insert end ${family}:\t {} \
            "This is a simple sampler Функционал\n" f$count
    set w [font measure [.t cget -font] ${family}:]
    if {$w+5 > $tabwidth} {
        set tabwidth [expr {$w+5}]
        .t configure -tabs $tabwidth
    }
}
set i 0
set fam ""
foreach family [lsort -dictionary [font families]] {
    append fam "$family\n"
    incr i
    if {$i > 10 } {
	set i 0
tk_messageBox -title "FONTS" -icon info -message "$fam"
set fam ""

    }
}
}

###############
set ::sntlf "Неизвестно"
if {$::scrwidth < $::scrheight} {
    global env
#    option add *Dialog.msg.width 70
    option add *Dialog.msg.wrapLength 750
#    option add *Dialog.msg.wrapLength 11i
#    option add *Dialog.dtl.wrapLength 11i
    option add *Dialog.dtl.wrapLength 750
#    option add *Dialog.dtl.width 70
    set ::myHOME $env(EXTERNAL_STORAGE)
#Шрифт для Androwish
    set ::ftxt "Roboto Condensed Medium"
    set ::ftxt1 "Roboto"
    set ::dlx1 6
    set ::dlx2 4
    set ::dlx3 3
    set ::dlx4 2

    set ::typetlf 1
    set lcc [file join $mydir Lcc_x86arm.so]
    set lrnd [file join $mydir Lrnd_x86arm.so]
  #   app specific directory on external storage
#  set file [tk_getSaveFile -title "env(EXTERNAL_STORAGE)"  -filetypes "" -initialdir "$env(EXTERNAL_STORAGE)"]
set cpu [borg osbuildinfo]
#tk_messageBox -title "osbuildinfo" -icon info -message "$cpu"
array set infoand $cpu
set snand [file join $env(EXTERNAL_STORAGE) "snandroid.txt"]
file delete -force $snand
if {[info exists infoand(serial)]} {
    set fd [open $snand w]
    chan configure $fd -translation binary
    puts -nonewline $fd $infoand(serial)
    close $fd
    set ::sntlf $infoand(serial)
#    tk_messageBox -title "osbuildinfo" -icon info -message "Серийный номер устройства:\n$::sntlf"
}

if {0} {
tk_messageBox -title "env(PATH)" -icon info -message "$env(PATH)"
#   path for exec(n) including app specific directory
  #   app specific directory on external files
tk_messageBox -title "env(EXTERNAL_FILES)" -icon info -message "$env(EXTERNAL_FILES)"
  set file [tk_getSaveFile -title "SAVEFILE"  -filetypes "" -initialdir "$env(EXTERNAL_FILES)"]
#   path name of external storage (could be internal SD card) 
#tk_messageBox -title "env(EXTERNAL_STORAGE2)" -icon info -message "$env(EXTERNAL_STORAGE2)"
#   path name of external storage (real external SD card)
tk_messageBox -title "env(HOME)" -icon info -message "$env(HOME)"
  set file [tk_getSaveFile -title "env(HOME)"  -filetypes "" -initialdir "$env(HOME)"]
#   app's home directory (internal storage)
tk_messageBox -title "env(INTERNAL_STORAGE)" -icon info -message "$env(INTERNAL_STORAGE)"
#   app specific directory on internal storage (identical with $env(HOME))
tk_messageBox -title "env(LD_LIBRARY_PATH)" -icon info -message "$env(LD_LIBRARY_PATH)"
#   load path for shared libraries including app specific directory
tk_messageBox -title "env(PACKAGE_CODE_PATH)" -icon info -message "$env(PACKAGE_CODE_PATH)"
#   path name of the app's APK
tk_messageBox -title "env(PACKAGE_NAME)" -icon info -message "$env(PACKAGE_NAME)"
#   package name where the app's main class comes from
tk_messageBox -title "env(TMPDIR)" -icon info -message "$env(TMPDIR)"
#   path name for temporary files
}
load "Lcc.so" Lcc
#  if {[catch {[load "Lcc.so" Lcc]} result]} {
#    tk_messageBox -title "LCC library" -icon error -message "Cannot load Lcc" -detail "$result"
#  }

#load [file join $mydir "Lcc.so"] Lcc
load "Lrnd.so" Lrnd
#load [file join $mydir "Lrnd.so"] Lrnd
load "tclpkcs11.so" Tclpkcs11

#create_template_sw_token
#tk_messageBox -title "TclPKCS11" -icon info -message "Грузим LS11SW2016"  

} else {
wm overrideredirect . no      ;# moves window decorations
    wm iconphoto . icon11_24x24
    set ::myHOME $::env(HOME)
    set ::typetlf 0
#Шрифт для PC
    set ::ftxt "Nimbus Sans Narrow"
    set ::ftxt1 "Nimbus Sans Narrow"
    set ::dlx1 2
    set ::dlx2 2
    set ::dlx3 3
    set ::dlx4 1

    set lcc [file join $mydir Lcc_64.so]
    set lrnd [file join $mydir Lrnd_64.so]
    set ltclpkcs11 [file join $mydir tclpkcs11_64.so]
#    tk_messageBox -title "Грузим Тему" -icon info -message "Это PC:$ff"  -parent . -detail "screenwidth=$::scrwidth\nscreenheight=$::scrheight"
load $lcc Lcc
load $lrnd Lrnd
load $ltclpkcs11 Tclpkcs11
#Конфигурирование виджета под смартфон
#Ширина 75 mm
    set ::scrwidth [expr {int(75 * $px2mm)}]
#Высота 140 mm
    set ::scrheight [expr int(140 * $px2mm)]
    wm minsize . $::scrwidth $::scrheight
    set geometr $::scrwidth
    append geometr "x"
    append geometr $::scrheight
    append geometr "+0+0"
    wm geometry . $geometr
}
#::updatetok

proc infotoken {} {
    set infotok "Работа с токенами будет\nдоступна в 2020 году.\nС Новым Годом!"
    tk_messageBox -title "Токены PKCS11" -icon info -message "$infotok"  -parent . 
}

#  load $tclpkcs11 Tclpkcs11
#load $lcc Lcc
#load "Lcc.so" Lcc
#load $lrnd Lrnd
#set pkcs11id_hex "XAXAXA"
#set pkcs11id_bin [lcc_sha1 "XAXAXA"]
#binary scan $pkcs11id_bin H* pkcs11id_hex

#tk_messageBox -title "Грузим Lcc/Lrnd" -icon info -message "Загрузили  Lcc/Lrnd\nXAXAXA" -detail "sha1=$pkcs11id_hex" -parent .
#wm geometry . [winfo screenwidth .]x[winfo screenheight .]+0+0
#update idletasks               ;# updates the full-screen

wm attributes . -topmost yes   ;# stays on top - needed for Linux
                               ;# on Win9x, if =no, alt-tab will malfunction

#font configure TkFixedFont -size 10

proc dateLIC {} {
    global env
    if {$::typetlf} {
	set userpath $env(EXTERNAL_STORAGE)
    } else {
	set userpath $env(HOME)
    }
    set filelic [file join $userpath ".LS11SW2016" "LIC.DAT"]

  if {[catch {set fl [open $filelic] } result]} {
    return ""
  }
  seek $fl 64 start
  set date [read $fl 8]
  close $fl
  set d [string range $date 0 1]
  set m [string range $date 2 3]
  set d [string range $date 0 1]
  set y [string range $date 4 end]
  return "$d.$m.$y"
}

proc butImg {img} {


    if {$img == "but2"} {
	pack forget  .fr0
	pack .fr1 -side top -anchor center -expand 1 -fill both -side top  -padx 0 -pady 0 
    } elseif {$img == "but1"} {
	pack forget  .fr1
	pack .fr0 -side top -anchor center -expand 1 -fill both -side top  -padx 0 -pady 0 
    } elseif {$img == "img1"} {
	if {$::typetlf} {
	    borg activity android.intent.action.VIEW http://soft.lissi.ru text/html
	} else {
	    openURL "http://soft.lissi.ru text/html"
	}
    } elseif {$img == "cloud"} {
	set fr $::rfr
	set  wd [expr {int ($::px2mm / 2)}]
	set  sz [expr {int($::px2mm * 5)}]
	set x1 $::rx1
	    if {$::tektoken == "sw"} {
		set y1 $::ry1
	    } elseif  {$::tektoken == "cloud"} {
		set y1 [expr {$::ry1 + $sz + $sz / 2}]
	    } else {
		set y1 [expr {$::ry1 + $sz * 2 + $sz }]
	    }
#	set y1 $::ry1
	set x2 [expr $x1 + $sz]
	set y2 [expr $y1 + $sz]
	create_rectangle $fr.can $::tektoken $x1 $y1 $x2 $y2  "skyblue" 0.1 $wd "#58a95a"

	set y1 [expr {$::ry1 + $sz + $sz / 2}]
	set x2 [expr $x1 + $sz]
	set y2 [expr $y1 + $sz]
	set imt2 [create_rectangle $fr.can "cloud" $x1 $y1 $x2 $y2  "#58a95a" 0.9 $wd "snow"]
	set cloud 0
	set savelib $::pkcs11_module
	if {![file exists $::libcloud]} {
	    tk_messageBox -title "Облачный токен" -icon info -message "В настоящее время у вас нет облачного токена."
	} else {
	    set ::pkcs11_module $::libcloud
	    place .linfo -in .fr1 -relx 0.05 -rely 0.4
	    after 100
	    update
	    set ret [::updatetok]
	    place forget .linfo
	    switch -- $::pkcs11_status {
		-1	{
		    tk_messageBox -title "Используемый токен"   -icon info -message "Отсутствует библиотека"
		}
		0 {
#		    set date [dateLIC]
#		    if {$date == ""} {
#			set date "31.12.2999"
#		    }
		    tk_messageBox -title "Используемый токен" -icon info -message "Токен готов к использованию:\n$::slotid_teklab\n"
#		    tk_messageBox -title "Используемый токен" -icon info -message "Токен готов к использованию:\n$::slotid_teklab\nЛицензия до $date"
		    set cloud 1
		}
		1	{
		    tk_messageBox -title "Используемый токен"   -icon info -message "Отсутствует подключенный токен"
		}
		2  {
#puts "::pkcs11_status=$::pkcs11_status \nret=$ret"
		    tk_messageBox -title "Используемый токен"   -icon info -message "Требуется инициализация токена.\nДля инициализации токена перейдите\nна страницу\n\"Конфигурирование токена\""
		    set cloud 1
		}
		default  {
		    tk_messageBox -title "Используемый токен"   -icon info -message "Неизвестная ошибка.\nПодключитесь к облаку" 
		}
	    }
	}
	if {!$cloud} {
	    set ::pkcs11_module $savelib
	    set ret [::updatetok]
	    if {$::tektoken == "sw"} {
		set y1 $::ry1
	    } elseif  {$::tektoken == "cloud"} {
		set y1 [expr {$::ry1 + $sz + $sz / 2}]
	    } else {
		set y1 [expr {$::ry1 + $sz * 2 + $sz }]
	    }
#		set y1 $::ry1
		set x2 [expr $x1 + $sz]
		set y2 [expr $y1 + $sz]
	    create_rectangle $fr.can $::tektoken $x1 $y1 $x2 $y2  "#58a95a" 0.9 $wd "snow"
		set y1 [expr {$::ry1 + $sz + $sz / 2}]
		set x2 [expr $x1 + $sz]
		set y2 [expr $y1 + $sz]
	    create_rectangle $fr.can "cloud" $x1 $y1 $x2 $y2  "skyblue" 0.1 $wd "#58a95a"
	} else {
	    set ::tektoken "cloud"
	}
    } elseif {$img == "hw"} {
	global env
	set typesX11 {
	    {"Библиотеки"		{.so .so.*}	}
	    {"Любые файлы"		*}
	}
	if {$::typetlf} {
	    set lastdir $env(EXTERNAL_STORAGE)
	} else {
	    set lastdir $env(HOME)
	}
	set flib [tk_getOpenFile -title "Выбор библиотеки PKCS#11"  -filetypes $typesX11 -initialdir $lastdir]
	if {$flib == ""} {
	    return
	}
	if {[file exists $flib]} {
	    set myHOME1 $env(HOME)
	    set mm [file join $myHOME1 "otherlib.so"]
	    file delete -force $mm
	    set err [catch {file copy -force $flib $mm} res]
	    if {$err} {
		tk_messageBox -title "Копирование биб-ки" -icon error -message "Установить не удалось."
		return
	    } else {
		set ::libother $mm
	    }
	} else {
		tk_messageBox -title "Выбор библиотеки" -icon error -message "Плохая библиотека."
		return
	}
#tk_messageBox -title "Другой токен" -icon info -message "В стадии разработки \n Библиотека PKCS#11=$flib."
#return
	set fr $::rfr
	set  wd [expr {int ($::px2mm / 2)}]
	set  sz [expr {int($::px2mm * 5)}]
	set x1 $::rx1
#	set y1 $::ry1
	    if {$::tektoken == "sw"} {
		set y1 $::ry1
	    } elseif  {$::tektoken == "cloud"} {
		set y1 [expr {$::ry1 + $sz + $sz / 2}]
	    } else {
		set y1 [expr {$::ry1 + $sz * 2 + $sz }]
	    }
	set x2 [expr $x1 + $sz]
	set y2 [expr $y1 + $sz]
	create_rectangle $fr.can $::tektoken $x1 $y1 $x2 $y2  "skyblue" 0.1 $wd "#58a95a"

#	set y1 [expr {$::ry1 + $sz + $sz / 2}]
	set y1 [expr {$::ry1 + $sz * 2 + $sz}]
	set x2 [expr $x1 + $sz]
	set y2 [expr $y1 + $sz]
	set imt2 [create_rectangle $fr.can "hw" $x1 $y1 $x2 $y2  "#58a95a" 0.9 $wd "snow"]
	set savelib $::pkcs11_module

	set other 0
	    set ::pkcs11_module $::libother
	    set ret [::updatetok]
	    switch -- $::pkcs11_status {
		-1	{
		    tk_messageBox -title "Используемый токен"   -icon info -message "Отсутствует библиотека"
		}
		0 {
		    tk_messageBox -title "Используемый токен" -icon info -message "Токен готов к использованию:\n$::slotid_teklab\n"
		    set other 1
		}
		1	{
		    tk_messageBox -title "Используемый токен"   -icon info -message "Отсутствует подключенный токен"
		}
		2  {
#puts "::pkcs11_status=$::pkcs11_status \nret=$ret"
		    tk_messageBox -title "Используемый токен"   -icon info -message "Требуется инициализация токена.\nДля инициализации токена перейдите\nна страницу\n\"Конфигурирование токена\""
		    set other 1
		}
		default  {
		    tk_messageBox -title "Используемый токен"   -icon info -message "Неизвестная ошибка." 
		}
	    }
	if {!$other} {
	    set ::pkcs11_module $savelib
	    set ret [::updatetok]
	    if {$::tektoken == "sw"} {
		set y1 $::ry1
	    } elseif  {$::tektoken == "cloud"} {
		set y1 [expr {$::ry1 + $sz + $sz / 2}]
	    } else {
		set y1 [expr {$::ry1 + $sz * 2 + $sz }]
	    }
		set x2 [expr $x1 + $sz]
		set y2 [expr $y1 + $sz]
	    create_rectangle $fr.can $::tektoken $x1 $y1 $x2 $y2  "#58a95a" 0.9 $wd "snow"
		set y1 [expr {$::ry1 + $sz * 2 + $sz }]
#		set y1 [expr {$::ry1 + $sz + $sz / 2}]
		set x2 [expr $x1 + $sz]
		set y2 [expr $y1 + $sz]
	    create_rectangle $fr.can "hw" $x1 $y1 $x2 $y2  "skyblue" 0.1 $wd "#58a95a"
	} else {
	    set ::tektoken "hw"
	} 

    } elseif {$img == "sw"} {
	global env
#wm state . withdraw
#	tk_messageBox -title "Встроенный токен" -icon info -message "::pkcs11_status=$::pkcs11_status"
	if {$::typetlf} {
	    set ::pkcs11_module "libls11sw2016.so"
	} else {
	    set ::pkcs11_module "./libls11sw2016.so"
	}
	set fr $::rfr
	set x1 $::rx1
	set y1 $::ry1
	set  sz [expr {int($::px2mm * 5)}]
	set  wd [expr {int ($::px2mm / 2)}]

		set y1 $::ry1
		set x2 [expr $x1 + $sz]
		set y2 [expr $y1 + $sz]
	    create_rectangle $fr.can "sw" $x1 $y1 $x2 $y2  "#58a95a" 0.9 $wd "snow"
	    if {$::tektoken == "sw"} {
		set y1 $::ry1
	    } elseif  {$::tektoken == "cloud"} {
		set y1 [expr {$::ry1 + $sz + $sz / 2}]
	    } else {
		set y1 [expr {$::ry1 + $sz * 2 + $sz }]
	    }
#		set y1 [expr {$::ry1 + $sz + $sz / 2}]
		set x2 [expr $x1 + $sz]
		set y2 [expr $y1 + $sz]
	    create_rectangle $fr.can $::tektoken $x1 $y1 $x2 $y2  "skyblue" 0.1 $wd "#58a95a"

	set ret [::updatetok]
	switch -- $::pkcs11_status {
	    -1	{
		tk_messageBox -title "Используемый токен"   -icon info -message "Отсутствует библиотека"
	    }
	    0 {
		set date [dateLIC]
		if {$date == ""} {
		    set date "31.12.2999"
		}
		tk_messageBox -title "Используемый токен" -icon info -message "Токен готов к использованию:\n$::slotid_teklab\nЛицензия до $date"
	    }
	    1	{
		tk_messageBox -title "Используемый токен"   -icon info -message "Отсутствует подключенный токен"
	    }
	    2  {
#puts "::pkcs11_status=$::pkcs11_status \nret=$ret"
		tk_messageBox -title "Используемый токен"   -icon info -message "Требуется инициализация токена.\nДля инициализации токена перейдите\nна страницу\n\"Конфигурирование токена\""
	    }
	    3  {
		tk_messageBox -title "Используемый токен"   -icon info -message "Нет лицензии на токен.\nЗапрос на лицензию LIC.REQ хранится в папке:\n$::myHOME\n" \
		    -detail "Для получения и установки лицензии\n перейдите на вкладку \"Конфигурирование токенов\""
	    }
	}
	set ::tektoken "sw"
#wm state . normal
    } else {
	tk_messageBox -title "Кнопка" -icon info -message "Нажали=$img" -detail "::screenwidth=$::scrwidth\n::screenheight=$::scrheight" -parent .
    }
}

proc create_rectangle  {canv img x1 y1 x2 y2 color alfa {wbd 0} {colorline black} } {
    image create photo $img -format "default -colorformat  rgb"
    set rgb1 [winfo rgb $canv $color]
    set cr  [lindex $rgb1 0]
    set cg  [lindex $rgb1 1]
    set cb  [lindex $rgb1 2]
    set fill [format "#%04x%04x%04x" $cr $cg $cb ]
#Создаем цветной праямоугольник
    $img put $fill -to 0 0 [expr {$x2 - $x1}] [expr {$y2 -$y1}]
#Сохраняем картинку
    set dimg [$img data -format png]
#Создаем image с учетом alpha канала
    image create photo $img -data $dimg -format "png -alpha $alfa"
#    $img put [list $rgb1] -to 0 0 [expr {$x2 - $x1}] [expr {$y2 -$y1}]
#Отображаем цветной прямоугольник
    set imgr [$canv create image $x1 $y1 -image $img -anchor nw] 
    set cc [subst {butImg $img}]
    $canv bind $imgr <ButtonPress-1> $cc
#Оконтовка вокруг цветного прямоугольника
    if {$wbd > 0 } {
	set item [$canv create rect $x1 $y1 $x2 $y2 -outline $colorline -width $wbd ]
	$canv bind $item <ButtonPress-1> $cc
    }
   return $imgr
}

#Увеличить/уменьшить (отрицательное значение - уменьшение)
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



image create photo logo_product -file [file join $mydir "imageme" "validcertkey_51x24.png"] 
image create photo logo_ls -file [file join $mydir "imageme" "lissi_soft.png"] -format "png -alpha 1.0"
#image create photo logo_ls -file [file join $mydir "imageme" "я_орел_160x75.png"] -format "png -alpha 1.0"
image create photo logo_and -file [file join $mydir "imageme" "AndTk_inv_147x173.png"] -format "png -alpha 1.0"
image create photo svitok -file [file join $mydir "imageme" "blue_svitok.png"] -format "png -alpha 1.0"
image create photo logo_awish -file [file join $mydir "imageme" "logo_awish_152x150.png"] -format "png -alpha 1.0"
image create photo logobic -file [file join $mydir "imageme" "logo-bic_token_96x96.png"]
image create photo voda -file [file join $mydir "imageme" "voda_400x800.png"]

set ::padls 20
set ::padlx 15
set ::padly 15
if {[tk windowingsystem] == "win32"}  {
    wm state . zoomed  ;# This command for Windows only
} elseif {$::typetlf} {
	wm attributes . -fullscreen 1
	scaleImage cloud_token 3
	scaleImage sw_token 3
	scaleImage icon_openfile_18x16 3
	scaleImage ::img::view_18x16 3
	scaleImage ::img::update_18x16 3
#Для ЛИССИ-Софт 4
	scaleImage logo_ls 4
#Для Орла 5
#	scaleImage logo_ls 5

#	scaleImage logo_orel 4
	scaleImage logo_product 2
#Андроида tcl/tk
    if { $::px2mm > 15} {
	scaleImage logo_and 4
    } elseif { $::px2mm > 10} {
	scaleImage logo_and 3
    } elseif { $::px2mm > 5} {
	scaleImage logo_and 2
    }
#Свиток опечатанный
	scaleImage svitok 4
	scaleImage creator_small 3
	set ::padls 50
	set ::padlx 75
	set ::padly 50
} else {
#	wm minsize . 370 700
	scaleImage logo_awish -2
#	scaleImage logo_orel -2
#	set ::scrwidth 370
#	set ::scrheight 670

}

if {$::typetlf == 0} {
    package provide ttk::theme::Breeze 0.6
    source [file join $mydir breeze.tcl]
    ttk::style theme use Breeze
}
source [file join $mydir "GostPfx.tcl"]
source [file join $mydir "alloids.tcl"]

ttk::style configure TCheckbutton  -background white
ttk::style configure TLabelframe -background  white -borderwidth 6
#skyblue
ttk::style configure TLabelframe.Label -background  white -borderwidth 6
#skyblue
ttk::style configure TRadiobutton  -background white -pad 0
option add *Labelframe.background	wheat
#option add *Labelframe.background	#bee9fd
option add *Labelframe.borderWidth	5

image create photo tileand -data {
R0lGODlhIgAiAOelAEWeR0WeSEaeR0aeSEWfRkWfR0WfSEafR0afSEafSUefSEefSUifSUWgSEifSkagSEmfSkagSUegSEegSUegSkigSUigSkigS0mgSkmgS0ihSkih
S0mhSkmhS0mhTEqhS0qhTEmiSkmiS0yhTUqiTE2hTk2hT0uiTUyiTUyiTkyiT02iTk2iT06iUEyjTkyjT02jTk2jT02jUE6jTk6jT06jUE+jUE2kT02kUE6kT06kUE+k
UE+kUVGkU1KkU1KkVFOkVFOkVVKlU1KlVFKlVVOlVFOlVVOlVlKmU1KmVFOmVFOmVVOmVlSmVVSmVlWmVlKnVVOnVFOnVVSnVVSnVlinW1eoWVioWVioWlioW1moWlmo
W1moXFqoW1ipWlipW1mpWlmpW1mpXFqpW1qpXFmqWlmqW1mqXFqqW1qqXFqqXVuqXFyqXl2qX16qYF+qYF2rXl2rX12rYF6rXl6rX16rYF+rX1+rYF+rYV2sX2CrYV6s
X16sYF6sYV+sX1+sYF+sYWCsYGCsYWCsYl6tYGGsYmGsY1+tYF+tYWKsY1+tYmKsZGCtYmGtYmGtY2GtZGKtYmKtY2KtZGKtZWOtY2OtZGOtZWStZWKuYmKuY2KuZGKu
ZWOuY2OuZGOuZWOuZmSuZGSuZWSuZmWuZmSvZf//////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////yH+EUNyZWF0ZWQgd2l0aCBHSU1QACH5BAEKAP8ALAAAAAAiACIAAAj+ADPUqfOhRiQwCIhYWjJhCyMYAvlwYPEozIQjkpQs2OIoh0CCdP6AYBFp
zIMhoZokwBJJR4aQHVhUSvOgSKUlCbR0wmEh5EiJMRwhNBJKCYItkWhsqLNHAwtNYR4k0aQkAtIYGugAddQhRSM0EYSQWiLgiiaXdf5scFFpTAEhKRFo0cSCgh1BXb+y
cBQGgZNQSQ6EqRTDQtoNMTp9OUBEFM4ukmB0wNPHKV8EksgoKOLYAJhQNQwD6hCjEhkDnJ0gwCJJhoU/iDSkyLw5zIEhnsiG8eSCQVoLKzR9IVBklBEALG844MOnQgqo
tz0lGNJpCoIrnHT0RATCa1/cTpD+Z6qRIc6fDiscjZleHUjKBFs23YCA51BMR2YUABHVBACYTmgRwoEJm6CBgHsqdfLEBFg4UkMHMKVQyBgTGNGJajrtsAFMMkRCxgI/
KMjgEgdo4UhhdfAhmyR9FaFJEgWE0YlracUkiRkGDHEJiSau1ogOHjAVUyNlLGBEJEtsNN4FcewBQguNeBGBhU34qANrMmTwx3krZHZSbgp0MUkMFdzVwQySiIFAEZ40
YQCWGbQkUB4a1MAiAklUolEYmcRwwR3n7WXGA0bkJpecdegwgVYbwNCJGAUMIQqGkrygwR16aHBCJFENMcoSBWBxiaJaTVCHHxNVAkYBREVxFCX+heERyAbPDVVUAVt0
EoOpqMYxCHqapIGAEJMiV4kOFfyB13NrKIBSEwJo8YmivqKHCAcqJOIFAkaIIkUBVWhCw5+HcJDCIn394IkUB3DRyQ2GXZstCChAgsYCcFEBgBWd8KABHIh0lYmwPoDi
xAJXvLsdvfamYMgYEhhx0wGs0ZCBHHuEQFEYEgxhiRMSZCFJDBy8MZrDEHs4wRCVVKkFJToweQcJBp2xQBGhULEAS+TRgRcMKg9hhgRFSAKFXJnAYBgfIpAEBqFtrtYR
BkzJhh/RkkyARCZNTABGSxf4FEMhUSlh8GqR2ADhHx68gAkaWnOt4xIK5BorIOZeTZT+EgdkASAGcvwxkSQGzq1AKJQWpqxsmcBNZQFagFLDBXucF8PAOSIuFxWQj2yq
IhSMIImwQ3wC6haeyLAoIBuUMFOkonCuhSQDaBFJDhfUAUgGLNxoZCdLDJCrcinGVBICQZDiRO23X+FJaHUEjEIlagzrCRVyeaKdGwGvEIkZw05agPOhnZVBG3x0oEIk
aDwARCcqbZEJ7m6MZoIjjuccABbmt8GDBWxIXwocQZMeeOIJD7iCJHSggTjgQQQoKAQZJiAESzDhAGb5XwAxEAc6FOQgCamEFHbGCIsVzwQVqVBGEpCF23HQg3PgAwm8
R4aOeUI1DdIBB2CSngkOQRJCTMiJJkITwxlazhBgaABRpHAUSUCvKU/plCaW0ER41SgGhugAChphhrCQoj8J0w4dACGbmQwrFFNYgE5qsDotcjEgADs=
}

proc createtile {w  backg} {
    image create photo tiled
set hc [$w configure -height]
set hc [lindex 4]
#puts "createtile h=$hc\n$::scrheight"

    tiled copy $backg -to 0 0 $::scrwidth $::scrheight -shrink
#    tiled copy $backg -to 0 0 $::scrwidth $hc -shrink
    $backg copy tiled
    image delete tiled

## Put the image on the canvas.
    $w create image 0 0  \
      -image $backg  \
      -anchor nw
}

proc exitPKCS {} {
    set answer [tk_dialog .dialog2 "Конец работы" "Вы действительно\nхотите выйти?" question 0 "Да" "Нет" ]
    if {$answer == 0} {
      exit
    }
}
#Создаем заголовок титульной страницы с иконкой продукта и его названием
set name_product "CryptoArmPKCS-A" 

label .labtitul -image logo_product -compound left -fg snow -text $name_product -font {Arial 10 bold} -anchor w  -width [winfo screenwidth .] -pady $::padls -padx 10 -bg #222222 
pack .labtitul -anchor nw -expand 0 -fill x -side top  -padx 1 -pady 0

set i 0
ttk::style configure MyFRame.TFrame -background #e2e2e1  -borderwidth 0  -padding 0
#ttk::style configure MyBorder.TButton  -font TkFixedFont -padding 0

proc my_mes {} {

    set fr ""
#Создаем холст на весь экран
    set h [expr $::scrheight / 4]
    set w [expr $::scrwidth / 2]
#    tkp::canvas $fr.canmes -borderwidth 0 -height $h -width $w -relief flat
    canvas $fr.canmes -borderwidth 0 -height $h -width $w -relief flat
#    canvas $fr.can -borderwidth 0 -height [winfo screenheight .] -width [winfo screenwidth .] -relief flat
#Мостим холст плиткой 
    createtile "$fr.canmes"  "tileand"
    
}
proc page_titul {fr  logo_manufacturer} {
    global mydir
#Создаем холст на весь экран
#    tkp::canvas $fr.can -borderwidth 0 -height [winfo screenheight .] -width [winfo screenwidth .] -relief flat
#    canvas $fr.can -borderwidth 0 -height [winfo screenheight .] -width [winfo screenwidth .] -relief flat
    canvas $fr.can -borderwidth 0 -height $::scrheight  -width $::scrwidth -relief flat
#Мостим холст плиткой 
    createtile "$fr.can"  "tileand"
#    createtile "$fr.can"  "tiletitul"

    pack $fr.can  -anchor center -expand 1 -fill both -side top  -padx 0 -pady 0
#Вычисляем координаты для логотипа производителя
#update чтобы обновилась информация в БД об окнах
    update
#    set aa [winfo height $fr.labtitul]
    set aa $::padly
#Центрируем логотип разработчика
    set ha [image width $logo_manufacturer]
    set xman [expr {($::scrwidth - $ha) / 2 }]
    $fr.can create image $xman $aa -image $logo_manufacturer -anchor nw -tag tag_logo

    set blogo [$fr.can bbox tag_logo]
    set wexit [lindex $blogo 3]
#puts "FTXT=$::ftxt, dlx1=$::dlx1"
	set dlx [expr {$::padlx / 1}]
#Центрируем текст
#############################
	set allfunc "Электронная подпись"
	catch {font delete fontTEMP_titul0}
	set font_titul "-family {$::ftxt} -size 15"
        eval font create fontTEMP_titul0  $font_titul
	set funcWidthPx [font measure fontTEMP_titul0 "$allfunc"]
	set dlx [expr {($::scrwidth - $funcWidthPx) / 2}]

#	$fr.can create text [expr $dlx + $::dlx1] [expr {$wexit + $::padly + $::dlx1}] -anchor nw -text "$allfunc" -fill black -font fontTEMP_titul0
#	$fr.can create text $dlx [expr {$wexit + $::padly}] -anchor nw -text "$allfunc" -fill white -font fontTEMP_titul0 -tag id_text0
	$fr.can create text [expr $dlx + $::dlx1] [expr {$wexit + $::dlx1}] -anchor nw -text "$allfunc" -fill black -font fontTEMP_titul0
	$fr.can create text $dlx [expr {$wexit }] -anchor nw -text "$allfunc" -fill white -font fontTEMP_titul0 -tag id_text0
	update
	set blogo [$fr.can bbox id_text0]
	set wexit [lindex $blogo 3]
#Центрируем текст
	set allfunc "для платформы Android"
	catch {font delete fontTEMP_titul1}
	set font_titul "-family {$::ftxt} -size 13"
        eval font create fontTEMP_titul1  $font_titul
	set funcWidthPx [font measure fontTEMP_titul1 "$allfunc"]
	
	set dlx [expr {($::scrwidth - $funcWidthPx) / 2}]

#	$fr.can create text [expr $dlx + $::dlx1] [expr {$wexit + $::padly + $::dlx1}] -anchor nw -text "$allfunc" -fill black -font fontTEMP_titul1
#	$fr.can create text $dlx [expr {$wexit + $::padly}] -anchor nw -text "$allfunc" -fill white -font fontTEMP_titul1 -tag id_text1
	$fr.can create text [expr $dlx + $::dlx1] [expr {$wexit + $::dlx1}] -anchor nw -text "$allfunc" -fill black -font fontTEMP_titul1
	$fr.can create text $dlx [expr {$wexit}] -anchor nw -text "$allfunc" -fill white -font fontTEMP_titul1 -tag id_text1
	update
	set blogo [$fr.can bbox id_text1]
	set wexit [lindex $blogo 3]
	set font_titul "-family {$::ftxt} -size 12"
    catch {font delete fontTEMP_titul2}
    eval font create fontTEMP_titul2  $font_titul
	set allfunc "№ 63 ФЗ \"Об электронной подписи"
	set funcWidthPx [font measure fontTEMP_titul2 "$allfunc"]
	set dlx [expr {($::scrwidth - $funcWidthPx) / 2}]
    set x1 [expr {int($::px2mm * 2)}]
	$fr.can create text [expr $dlx + $::dlx1] [expr {$wexit + $x1}] -anchor nw -text "№ 63 ФЗ \"Об электронной подписи\nот 6 апреля 2011 года\"" -fill black -font fontTEMP_titul2
	$fr.can create text $dlx [expr {$wexit + $x1}] -anchor nw -text "№ 63 ФЗ \"Об электронной подписи\nот 6 апреля 2011 года\"" -fill white -font fontTEMP_titul2 -tag id_text2

	set blogo [$fr.can bbox id_text2]
	set wexit [lindex $blogo 3]
	set font_titul "-family {$::ftxt} -size 10"
    catch {font delete fontTEMP_titul3}
    eval font create fontTEMP_titul3  $font_titul
	$fr.can create text [expr $dlx + $::dlx4] [expr {$wexit + $::dlx1}] -text "Авторы: В.Н. Орлов\nhttp://soft.lissi.ru, http://www.lissi.ru\n+7(495)589-99-53\ne-mail: support@lissi.ru\n" \
	-anchor nw -fill black  -font fontTEMP_titul3
	$fr.can create text $dlx [expr {$wexit + 0}] -text "Авторы: В.Н. Орлов\nhttp://soft.lissi.ru, http://www.lissi.ru\n+7(495)589-99-53\ne-mail: support@lissi.ru\n" \
	-anchor nw -fill white -tag id_text3  -font fontTEMP_titul3


    set blogo [$fr.can bbox id_text3]
    set wland [lindex $blogo 3]
#Размеры logo_and
    set ha [image height logo_and]
    set wa [image width logo_and]
#    set wland [expr {$::scrheight - $ha }]
    set hy1 [expr $ha / 4]
set widthrect [expr $ha / 4]
    set hy2 [expr $hy1 / 4]

    $fr.can create image $::padlx $wland -image logo_and -anchor nw -tag tag_land
    set ha1 [expr {$ha - ($ha / 2 ) }]
    $fr.can create image [expr {$wa - 80 }] [expr {$wland + $ha1}] -image svitok -anchor nw -tag tag_land

#	set x1 [expr {int($::px2mm * 5)}]
	set x1 $dlx
	set y1 [expr {$wland + $hy2}]
	set x2 [expr {$::scrwidth - $x1}]
#	set widthrect [expr {int($::px2mm * 8)}]
	set y2 [expr {$y1 + $widthrect}]
	set  wd $::px2mm
#    set g5 [$fr.can gradient create linear -stops {{0 lightgreen} {1 green}}] 
#    set S3 [$fr.can style create -stroke "skyblue" -fill  $g5 -strokewidth $wd  -fillopacity 0.6]
#    set im1 [$fr.can create prect $x1 $y1 $x2 $y2 -rx $rr -style $S3]
    set im1 [create_rectangle $fr.can "but1" $x1 $y1 $x2 $y2 "green" 0.5 [expr int($wd)] "skyblue"]
#    set im1 [create_rectangle $fr.can "but1" $x1 $y1 $x2 $y2 "#2b972d" 0.6 [expr int($wd)] "skyblue"]
    $fr.can bind $im1 <ButtonPress-1> {butImg "img1"}
#Печатаем техт
    set blogo [$fr.can bbox $im1]
    set by2 [lindex $blogo 3]
    set by1 [lindex $blogo 1]
    set bb [expr {($by2 - $by1) / 2}]
    set bx2 [lindex $blogo 2]
    set bx1 [lindex $blogo 0]
    set bbx [expr {($bx2 - $bx1) / 2}]
#    set txt1 [$fr.can create text [expr {$x1 + $::padlx * 2}] [expr {$y1 + 1 }] -anchor nw -text "Сайт разработчика" -fill black -font {{Arial} 10 normal}] 
    set txt0 [$fr.can create text [expr {$x1 + $::padlx * 2}] [expr {$y1 + 1 }] -anchor nw -text {Сайт разработчика} -fill black -font fontTEMP_titul2]
    set txt1 [$fr.can create text [expr {$x1 + $::padlx * 2}] [expr {$y1 + 1 }] -anchor nw -text {Сайт разработчика} -fill white -font fontTEMP_titul2]
#Центрируем техт
    set btxt1 [$fr.can bbox $txt1]
#Смещение по оси Y
    set ty2 [lindex $btxt1 3]
    set ty1 [lindex $btxt1 1]
    set tt [expr {$ty2 - $ty1}]
    set tt [expr {$tt / 2}]
    set offsy [expr {($by1 + $bb) - ($ty1 + $tt)}]
#Смещение по оси X
    set tx2 [lindex $btxt1 2]
    set tx1 [lindex $btxt1 0]
    set ttx [expr {$tx2 - $tx1}]
    set ttx [expr {$ttx / 2}]
    set offsx [expr {($bx1 + $bbx) - ($tx1 + $ttx)}]
    $fr.can move $txt0 [expr $offsx + $::dlx1] [expr $offsy + $::dlx1]
    $fr.can move $txt1 $offsx $offsy
    $fr.can bind $txt1 <ButtonPress-1> {butImg "img1"}

#	set y1 [expr {$y2 + int($::px2mm * 2)}]
	set y1 [expr {$y2 + $hy2}]
	set y2 [expr {$y1 + $widthrect}]
#    set im1 [create_rectangle $fr.can "but2" $x1 $y1 $x2 $y2 "#00bfa5" 0.5 $wd "skyblue"]
    set im1 [create_rectangle $fr.can "but2" $x1 $y1 $x2 $y2 "green" 0.5 $wd "skyblue"]
#Печатаем техт
    set blogo [$fr.can bbox $im1]
    set by2 [lindex $blogo 3]
    set by1 [lindex $blogo 1]
    set bb [expr {($by2 - $by1) / 2}]
    set bx2 [lindex $blogo 2]
    set bx1 [lindex $blogo 0]
    set bbx [expr {($bx2 - $bx1) / 2}]
    set txt0 [$fr.can create text [expr {$x1 + $::padlx * 2}] [expr {$y1 + 1 }] -anchor nw -text "Переход в основное меню" -fill black -font fontTEMP_titul2] 
    set txt1 [$fr.can create text [expr {$x1 + $::padlx * 2}] [expr {$y1 + 1 }] -anchor nw -text "Переход в основное меню" -fill white -font fontTEMP_titul2] 
#Центрируем текст
    set btxt1 [$fr.can bbox $txt1]
#Смещение по оси Y
    set ty2 [lindex $btxt1 3]
    set ty1 [lindex $btxt1 1]
    set tt [expr {$ty2 - $ty1}]
    set tt [expr {$tt / 2}]
    set offsy [expr {($by1 + $bb) - ($ty1 + $tt)}]
#Смещение по оси X
    set tx2 [lindex $btxt1 2]
    set tx1 [lindex $btxt1 0]
    set ttx [expr {$tx2 - $tx1}]
    set ttx [expr {$ttx / 2}]
    set offsx [expr {($bx1 + $bbx) - ($tx1 + $ttx)}]
    $fr.can move $txt0 [expr $offsx + $::dlx1] [expr $offsy + $::dlx1]
    $fr.can move $txt1 $offsx $offsy
    $fr.can bind $txt1 <ButtonPress-1> {butImg "but2"}
###############
	set y1 [expr {$y2 + $hy2}]
#	set y1 [expr {$y2 + int($::px2mm * 2)}]
	set y2 [expr {$y1 + $widthrect}]

#    set S3 [$fr.can style create -stroke skyblue -fill  $g5 -strokewidth $wd  -fillopacity 0.6]
#    set im1 [$fr.can create prect $x1 $y1 $x2 $y2 -rx $rr -style $S3]
    set im1 [create_rectangle $fr.can "but3" $x1 $y1 $x2 $y2 "green" 0.5 $wd "skyblue"]
    set blogo [$fr.can bbox $im1]
    $fr.can bind $im1 <ButtonPress-1> {exitPKCS}
    set by2 [lindex $blogo 3]
    set by1 [lindex $blogo 1]
    set bb [expr {($by2 - $by1) / 2}]
    set bx2 [lindex $blogo 2]
    set bx1 [lindex $blogo 0]
    set bbx [expr {($bx2 - $bx1) / 2}]
#    set txt1 [$fr.can create text [expr {$x1 + $::padlx * 2}] [expr {$y1 + 1 }] -anchor nw -text "Конец работы" -fill black  -font {Arial 10 normal}]
    set txt0 [$fr.can create text [expr {$x1 + $::padlx * 2}] [expr {$y1 + 1 }] -anchor nw -text "Конец работы" -fill black  -font fontTEMP_titul2]
    set txt1 [$fr.can create text [expr {$x1 + $::padlx * 2}] [expr {$y1 + 1 }] -anchor nw -text "Конец работы" -fill white  -font fontTEMP_titul2]
    $fr.can bind $txt1 <ButtonPress-1> {exitPKCS}
    set btxt1 [$fr.can bbox $txt1]
#Смещение по оси Y
    set ty2 [lindex $btxt1 3]
    set ty1 [lindex $btxt1 1]
    set tt [expr {$ty2 - $ty1}]
    set tt [expr {$tt / 2}]
    set offsy [expr {($by1 + $bb) - ($ty1 + $tt)}]
#Смещение по оси X
    set tx2 [lindex $btxt1 2]
    set tx1 [lindex $btxt1 0]
    set ttx [expr {$tx2 - $tx1}]
    set ttx [expr {$ttx / 2}]
    set offsx [expr {($bx1 + $bbx) - ($tx1 + $ttx)}]
    $fr.can move $txt0 [expr $offsx + $::dlx1] [expr $offsy + $::dlx1]
    $fr.can move $txt1 $offsx $offsy
}

proc butCliked {num fr} {
    pack forget  .fr1
    set ::tekFrfunc $fr
puts "butCliked=$num"
    if {$num == 3 && $::wizpagecsr == 0} {
    #puts "MOVE wizpage=$::wizpagecsr"
	move "csr" [lindex $::pagescsr 0]
#	pack $fr 
	pack $fr -side top -anchor center -expand 1 -fill both -side top  -padx 0 -pady 0 
#pack forget $fr.can
#pack $fr.can  -anchor center -expand 1 -fill both -side top  -padx 0 -pady 0
    } elseif {$num == 6} {
	$fr.fratext.text delete 1.0 end
	set ::listObjs [list ]
	$fr.frhd.lobj configure -state normal
	$fr.frhd.lobj delete 0 end
	$fr.frhd.lobj configure -values $::listObjs
	$fr.frhd.lobj configure -state readonly
	pack $fr -side top -anchor center -expand 1 -fill both -side top  -padx 0 -pady 0 
    } else {
	pack $fr -side top -anchor center -expand 1 -fill both -side top  -padx 0 -pady 0 
    }
#    tk_dialog .dialog1 "Dear user:" "Button $num was clicked\nFr=$fr" info 0 OK 
}
proc butReturn {} {
    pack forget  $::tekFrfunc
    pack .fr1 -side top -anchor center -expand 1 -fill both -side top  -padx 0 -pady 0 
#    tk_dialog .dialog1 "Dear user:" "Button $num was clicked\nFr=$fr" info 0 OK 
}

namespace eval cagui {

  variable img_cert
  set img_cert img_cert

  variable status {}  ;# status displayed in progress

}

proc cagui::FileDialog {args} {
  global typesys
  global home

  set validopts {-dialogtype -defaultextension -filetypes -title -variable -initialdir -command -parent}
  set passingopts {-defaultextension -filetypes -title -initialdir -initialfile -parent}

  # parse arguments
  array set opts_in $args
  foreach opt $validopts {
    if {[info exists opts_in($opt)]} {
      set opts($opt) $opts_in($opt)
    }
  }

  if {[info exists opts_in(-variable)]} {
    upvar $opts_in(-variable) variable
  }
  if {$opts(-dialogtype)=="directory"} {
    if {![info exists variable] || $variable == ""} {
      if {[info exists opts_in(-initialdir)]} {
        set opts(-initialdir) $opts_in(-initialdir)
      }
    } else  {
      set opts(-initialdir) $variable
    }
  } else  {
    if {![info exists variable] || $variable == ""} {
      set opts(-initialfile) ""
      if {[info exists $opts_in(-initialdir)]} {
        set opts(-initialdir) $opts_in(-initialdir)
      }
    } else  {
      set opts(-initialfile) [file tail $variable]
      set opts(-initialdir) [file dirname $variable]
    }
  }

  # build command
  # parray opts
  set command tk_getOpenFile

  if {[info exists opts(-dialogtype)]} {
    if {$opts(-dialogtype)=="open"} {
      set command "tk_getOpenFile -parent ."
    } elseif {$opts(-dialogtype)=="save"} {
      set command "tk_getSaveFile  -parent ."
    } elseif {$opts(-dialogtype)=="directory"} {
      if {![info exists opts(-parent)]} {
        set command "tk_chooseDirectory  -parent ."
      } else {
        set command "tk_chooseDirectory "
      }
    }
  }
  foreach opt $passingopts {
    if {[info exists opts($opt)]} {
      lappend command $opt $opts($opt)
    }
  }

  set v [eval $command]
  if {$typesys == "win32" } {
    if { "after#" == [string range $v 0 5] } {
      set v ""
    }
  }

  if {$v != ""} {
    if {[info exists variable]} {
      set variable $v
    }
    if {[info exists opts(-command)] && $opts(-command) != ""} {
      uplevel #0 $opts(-command)
    }
  }

  return $v
}

proc cagui::FileEntry {w args} {
#  ttk::style map My1.TButton -background [list disabled gray85  active #00ff7f] -foreground [list disabled gray64] -relief [list {pressed !disabled} sunken]
#  ttk::style configure My1.TButton -borderwidth 2

  set validopts {-dialogtype -width -defaultextension -filetypes -title -variable -initialdir -command -parent}

  set passingopts {-dialogtype -defaultextension -filetypes -title -variable -initialdir -command -parent}
  set entryopts {-width}

  # parse arguments
  array set opts_in $args
  foreach opt $validopts {
    if {[info exists opts_in($opt)]} {
      set opts($opt) $opts_in($opt)
    }
  }
  upvar $opts(-variable) variable
  upvar $opts_in(-variable) variable
  if {$variable == ""} {
    set opts(-initialfile) ""
    if {[info exists opts_in(-initialdir)]} {
      set opts(-initialdir) $opts_in(-initialdir)
    }
  } else  {
    set opts(-initialfile) [file tail $variable]
    set opts(-initialdir) [file dirname $variable]
  }

  # build buttoncommand
  set buttoncommand "cagui::FileDialog"
  foreach opt $passingopts {
    if {[info exists opts($opt)]} {
      lappend buttoncommand $opt $opts($opt)
    }
  }

  set entrycommand [list entry $w.entry -textvariable $opts(-variable) -highlightthickness 1 -highlightbackground skyblue -highlightcolor skyblue]
  foreach opt $entryopts {
    if {[info exists opts($opt)]} {
      lappend entrycommand $opt $opts($opt)
    }
  }

  frame $w
  #label $w.label -text $opts(-text)
  eval $entrycommand
  button $w.but -image icon_openfile_18x16  -compound center -command $buttoncommand -bd 0 -background white -activebackground white -highlightthickness 0
  pack $w.entry -side left -expand 1 -fill x -ipadx 1
  pack $w.but -side left -ipadx 1 -padx {4 3}
}

proc issuerpol {iss_hex} {
  array set ret [list]
  set iss [binary format H* $iss_hex]
  ::asn::asnGetSequence iss iss_pol
  for {set i 1} {[string length $iss_pol] > 0}  {incr i} {
    ::asn::asnGetUTF8String iss_pol ret(isspol$i)
  }
  return [array get ret]
}
proc subjectpol {iss_hex} {
  puts "SUBJECTPOL=$iss_hex"
  set iss [binary format H* $iss_hex]
  array set ret [list]
  #    ::asn::asnGetSequence iss iss_pol
  #Из-за того, что длина раньше попадала не в байтах, а в символах, то обрабатывалось не все
  set i 1
  #set ret(isspol$i) [encoding convertfrom utf-8 [string range $iss 2 end]]
  #    for {set i 1} {[string length $iss] > 0}  {incr i} {
  ::asn::asnGetUTF8String iss ret(isspol$i)
  #    }
  return [array get ret]
}

proc extku {ku_hex} {
  #set ::ku_options {"Digital signature" "Non-Repudiation" "Key encipherment" "Data encipherment" "Key agreement" "Certificate signature" "CRL signature" "Encipher Only" "Decipher Only" "Revocation list signature"}
  #puts "KU_hex=$ku_hex"
  set ku [binary format H* $ku_hex]
  ::asn::asnGetBitString ku ku_bin
  set ret {}
  #puts "KU=$ku_bin"
  #puts "KU len=[string length $ku_bin]"
  for {set i 0} {$i < [string length $ku_bin]}  {incr i} {
    #	puts "I=$i"
    if {[string range $ku_bin $i $i] > 0 } {
      lappend ret [lindex $::ku_options $i]
    }
  }
  #    puts $ret
  return $ret
}

proc extpol {pol_hex} {
  set pol [binary format H* $pol_hex]
  set ret {}
  ::asn::asnGetSequence pol oid_pol
  for {set i 1} {[string length $oid_pol] > 0}  {incr i} {
    ::asn::asnGetSequence oid_pol oid_pol1
    ::asn::asnGetObjectIdentifier oid_pol1 ret1
    lappend ret $ret1
  }
  #    puts $ret
  return $ret
}

proc extkeyuse {keyuse_hex} {
  set use [binary format H* $keyuse_hex]
  set ret {}
  ::asn::asnGetSequence use oid_use
  for {set i 1} {[string length $oid_use] > 0}  {incr i} {
    ::asn::asnGetObjectIdentifier oid_use ret1
    lappend ret $ret1
  }
  #    puts "EXTKEYUSE=$ret"
  return $ret
}

proc edithex {hex} {
  set c ""
  set l [string length $hex]
  #    puts $l
  for {set j 0 } { $j < $l} {incr j +2} {
    set c "$c[string range $hex $j $j+1] "
  }
  return [string toupper [string trimright $c]]
}



proc del_comma {ldn} {
  set lret {}
  set ff ""
  foreach el $ldn {
    if {[string first "=" $el] != -1} {
      if {$ff != ""} {
        lappend lret $ff
      }
      set ff $el
    } else {
      set ff "$ff,$el"
    }
  }
  lappend lret $ff
  return $lret
}

proc cert2der {data} {
  if {[string first "-----BEGIN CERTIFICATE-----" $data] != -1} {
    #	set data [string map {"\015\012" "\n"} $data]
    set data [string map {"\r\n" "\n"} $data]
  }
  array set parsed_cert [::pki::_parse_pem $data "-----BEGIN CERTIFICATE-----" "-----END CERTIFICATE-----"]
  set asnblock $parsed_cert(data)
  return $asnblock
}

proc ::fileWithCert {w nick cert_hex typecert} {
  global home
  global loadfile
  global dn_fields_ru
  set ::dercert ""
  set ::parsecert ""
  $w delete 0.0 end
  puts "fileWithCert=$typecert"
  #Файл с сертификатм из командной строки
  set comline 1
  ###############
  array set cert_parse []
  if {$cert_hex != "" && $nick == $cert_hex} {
    set asndata [binary  format H* $cert_hex]
    if {[catch {array set cert_parse [::pki::x509::parse_cert $asndata]} rc]} {
      tk_messageBox -title [mc "Load certificate"] -icon error -message "$file" -detail [mc "The selected file does not contain a certificate"]
      return
    }
    set ::dercert $asndata
    array set cert_parse [pki::x509::parse_cert $asndata]
    #Читаем публичный ключ
    #puts "CERT_PARSE_filewith=$certinfo_list"
#    array set infopk [pki::pkcs11::pubkeyinfo $cert_hex ]

    set cert_parse(pubkeyinfo) $cert_parse(pubkeyinfo_hex)
    if {$typecert == 6} {
      set ::tekcert "pkcs12"
    } else {
      set ::tekcert "pkcs7"
    }
  } elseif {$nick == "" } {
    unset -nocomplain cert_parse
    set file $cert_hex
    if {$file == ""} {
	return
    }
    set fd [open $file]
    chan configure $fd -translation binary
    set data [read $fd]
    close $fd
    set asndata [cert2der $data]
    if {$asndata == "" } {
      tk_messageBox -title "Загрузка сертификата" -icon error -message "$file" -detail "Выбранный файл не содержит сертификата"
      return
    }

    if {[catch {array set cert_parse [::pki::x509::parse_cert $asndata]} rc]} {
      tk_messageBox -title "Загрузка сертификата" -icon error -message "$file" -detail "Выбранный файл не содержит сертификата"
      return
    }
    set ::dercert $asndata
    binary scan  $asndata H*  cert_hex
    #	array set infopk [pki::pkcs11::pubkeyinfo $cert_hex [list pkcs11_handle $::handle pkcs11_slotid $::slotid_tek]]
#    array set infopk [pki::pkcs11::pubkeyinfo $cert_hex]

    set cert_parse(pubkeyinfo)  $cert_parse(pubkeyinfo_hex)
    set ::tekcert "file"
  } else {

    ############
    foreach certinfo_list $::certs_p11 {
      unset -nocomplain cert_parse
      array set cert_parse_der $certinfo_list
      if {$cert_parse_der(pkcs11_label) == $nick} {
        set ::dercert [binary format H* $cert_parse_der(cert_der)]
        array set cert_parse [pki::x509::parse_cert $::dercert]
        #Читаем публичный ключ
        #puts "CERT_PARSE_filewith=$certinfo_list"
        array set infopk [pki::pkcs11::pubkeyinfo $cert_parse_der(cert_der)]

        set cert_parse(pubkeyinfo) $infopk(pubkeyinfo)
        break
      }
    }
    #Экспорт в текстовом виде	.saveCert.labExp.but.butSave configure -text [mc "Export"]
    set ::tekcert "pkcs11"
  }
  #parray cert_parse
  #    puts  $cert_parse(subject)
  set ::subjectcert "$cert_parse(subject)"
  set lsub [split $cert_parse(subject) ","]
  set lsub [del_comma $lsub]
  #    puts $lsub

  $w insert end "Subject Name" bold
  $w insert end "\n"
  foreach a $lsub {
    set ind [string first "=" $a]
    if {$ind == -1 } { continue }
                	
    set oidsub [string trim [string range $a 0 $ind-1]]
    if {[info exists dn_fields_ru($oidsub)]} {
      set nameoid "$dn_fields_ru($oidsub)"
    } else {
      set nameoid ""
    }

    #	puts $nameoid
    set oidval "[mc [string trim [string range $a $ind+1 end]]]"
    if {$oidsub == "CN"} {
      set ::cn_subject  $oidval
    }

    if {$oidsub == "GIVENNAME"} {
      set oidsub "GV"
    }
    set oidsub "$nameoid ($oidsub)"
    #	set oidsub "$oidsub$nameoid"
    $w insert end "\t$oidsub\t$oidval\n"  margins1
  }
  $w insert end [mc "Issuer Name"] bold
  $w insert end "\n"
  #    puts  $cert_parse(issuer)
  set ::issuercert "$cert_parse(issuer)"
  set liss [split $cert_parse(issuer) ","]
  set liss [del_comma $liss]
  #    puts $liss

  foreach a $liss {
    set ind [string first "=" $a]
    if {$ind == -1 } { continue }
    set oidsub [string trim [string range $a 0 $ind-1]]
    if {[info exists dn_fields_ru($oidsub)]} {
      set nameoid "$dn_fields_ru($oidsub)"
    } else {
      set nameoid ""
    }

    set oidval "[mc [string trim [string range $a $ind+1 end]]]"
    if {$oidsub == "CN"} {
      set ::cn_issuer  $oidval
    }

    set oidsub "$nameoid ($oidsub)"
    #	set oidsub "$oidsub$nameoid"
    $w insert end "\t$oidsub\t$oidval\n"  margins1
  }
  $w insert end [mc "Issued Certificate"] bold
  $w insert end "\n"
  $w insert end "\t[mc "Version"]:\t$cert_parse(version)\n"  margins1
  set ::sncert "$cert_parse(serial_number)"
  set sn_bin [::asn::asnBigInteger [math::bignum::fromstr $cert_parse(serial_number)]]
  set sn_bin [string range $sn_bin 2 end]
  binary scan $sn_bin H* sn_hex

  $w insert end "\t[mc "Serial Number"] (hex):\t[edithex $sn_hex]\n"  margins1
  $w insert end "\t[mc "Serial Number"] (dec):\t$cert_parse(serial_number)\n"  margins1
  set ::notafter  $cert_parse(notAfter)
  set t $cert_parse(notAfter)
  #puts "T=$t"
  set notafter [clock format $t -format "%d/%m/%Y %R %Z"]
  set ::notbefore $cert_parse(notBefore)
  set t $cert_parse(notBefore)
  #puts "T=$t"
  set notbefore [clock format $t -format "%d/%m/%Y %R %Z"]
  $w insert end "\t[mc "Not Valid Before"]:\t$notbefore\n"  margins1
  $w insert end "\t[mc "Not Valid After"]:\t$notafter\n"  margins1
  set ver [mc "Expires"]
  $w insert end [mc "Public Key Info"] bold
  $w insert end "\n"
  if {[string range $cert_parse(pubkey_algo) 0 7] == "1.2.643." || [string range $cert_parse(pubkey_algo) 0 7] == "ГОСТ Р 3" || [string range $cert_parse(pubkey_algo) 0 7] == "GOST R 3"} {
    $w insert end "\t[mc "Key Algorithm"]:\t[mc $cert_parse(pubkey_algo)]\n"  margins1
    $w insert end "\t[mc "Key Parameters"]:\n"  margins1
    array set ret [parse_key_gost $cert_parse(pubkeyinfo)]
    #	parray ret
    $w insert end "\t[mc "sign param"]:\t[mc $ret(paramkey)]\n"  margins2
    $w insert end "\t[mc "hash param"]:\t[mc $ret(hashkey)]\n"  margins2
    set sek 4
    if {[string range $ret(pubkey) 2 3] != 40} {
      set sek 6
    }
    set pk [edithex [string range $ret(pubkey) $sek end]]
    $w insert end "\t[mc "Public Key"]:\t$pk\n"  margins11
    #Идентификатор ключа получателя
    set pk_bin [binary format H* $ret(pubkey)]
    set pkcs11id_bin [lcc_sha1 $pk_bin]
    binary scan $pkcs11id_bin H* ::pkcs11id
  } else {
    if {[string range $cert_parse(pubkey_algo) 0 2] == "rsa" } {
      set pkcs11id_bin [lcc_sha1 [binary format H* $cert_parse(pubkey)]]
      binary scan $pkcs11id_bin H* ::pkcs11id
      $w insert end "\t[mc "Key Algorithm"]:\tRSA\n"  margins1
      $w insert end "\t[mc "Key Size"]:\t$cert_parse(l)\n"  margins2
      $w insert end "\t[mc "Public Key"]:\t[edithex $cert_parse(pubkey)]\n"  margins11
    } else {
      $w insert end "\t[mc "Key Algorithm"]:\t$cert_parse(pubkey_algo)\n"  margins1
      $w insert end "\t[mc "Key Info"]:\t[edithex $cert_parse(pubkeyinfo)]\n" margins11
    }
  }
  array set extcert $cert_parse(extensions)
  #    parray extcert
  if {[info exists extcert(id-ce-basicConstraints)]} {
    $w insert end [mc "Basic Constraints"] bold
    $w insert end "\n"
    set basic $extcert(id-ce-basicConstraints)
    #	puts $basic
    if {[lindex $basic 1] == 1} {
      set typecert [mc "Yes"]
    } else {
      set typecert [mc "No"]
    }
    $w insert end "\t[mc "Certificate Authority"]:\t$typecert\n"  margins1
    if {[lindex $basic 2] == -1} {
      set lencert [mc "Unlimited"]
    } else {
      set lencert [lindex $basic 2]
    }
    $w insert end "\t[mc "Max Path Length"]:\t$lencert\n"  margins1
    if {[lindex $basic 0] == 1} {
      set critcert [mc "Yes"]
    } else {
      set critcert [mc "No"]
    }
    $w insert end "\t[mc "Critical"]:\t$critcert\n"  margins1
    unset extcert(id-ce-basicConstraints)
  }
  #  1 false -1
  # первое поле критичность 1 - Да, false - нет
  # второе поле УЦ 1 - Да, false - нет
  #Третье поле - длина пути : -1 - неограниченный, или значение 0 и т.д.
  if {[info exists extcert(1.2.643.100.112)]} {
    #issuerSignTools
    array set pol [issuerpol [lindex $extcert(1.2.643.100.112) 1]]
    $w insert end [mc "issuerSignTool"] bold
    $w insert end "\n"
    $w insert end "\t[mc "Name CKZI"]:\t$pol(isspol1)\n"  margins1
    $w insert end "\t[mc "Name CA"]:\t$pol(isspol2)\n"  margins1
    $w insert end "\t[mc "Certificate SKZI CA"]:\t$pol(isspol3)\n"  margins1
    $w insert end "\t[mc "Certificate CA"]:\t$pol(isspol4)\n"  margins1
    #	parray pol
    unset extcert(1.2.643.100.112)
  }
  if {[info exists extcert(1.2.643.100.111)]} {
    #subjectSignTools
    array set pol [subjectpol [lindex $extcert(1.2.643.100.111) 1]]
    $w insert end [mc "subjectSignTool"] bold
    $w insert end "\n"
    $w insert end "\t[mc "User CKZI"]:\t$pol(isspol1)\n"  margins1
    #	parray pol
    unset extcert(1.2.643.100.111)
  }
  if {[info exists extcert(id-ce-keyUsage)]} {
    $w insert end [mc "Key Usage"] bold
    $w insert end "\n"

    set ku [extku [lindex $extcert(id-ce-keyUsage) 1]]
    $w insert end "\t[mc "Usages"]:\t[mc [lindex $ku 0]]\n"  margins1
    for {set i 1 } { $i < [llength $ku] } {incr i} {
      $w insert end "\t\t[lindex $ku $i]\n"  margins1
    }
    #	puts $ku
    if {[lindex $extcert(id-ce-keyUsage) 0] == 1} {
      set critcert [mc "Yes"]
    } else {
      set critcert [mc "No"]
    }
    $w insert end "\t[mc "Critical"]:\t$critcert\n"  margins1
    unset extcert(id-ce-keyUsage)
  }
  if {[info exists extcert(id-ce-certificatePolicies)]} {
    $w insert end [mc "Certificate Policies"] bold
    $w insert end "\n"
    set lpol [extpol [lindex $extcert(id-ce-certificatePolicies) 1]]
    $w insert end "\t[mc "Policy Name"]:\t[mc [::pki::_oid_number_to_name [lindex $lpol 0]]]\n"  margins1
    for {set i 1 } { $i < [llength $lpol] } {incr i} {
      $w insert end "\t\t[mc [::pki::_oid_number_to_name [lindex $lpol $i]]]\n"  margins1
    }
    #	puts $ku
    if {[lindex $extcert(id-ce-certificatePolicies) 0] == 1} {
      set critcert [mc "Yes"]
    } else {
      set critcert [mc "No"]
    }
    $w insert end "\t[mc "Critical"]:\t$critcert\n"  margins1
    unset extcert(id-ce-certificatePolicies)
  }
  if {[info exists extcert(id-ce-subjectKeyIdentifier)]} {
    $w insert end [mc "Subject Key Identifier"] bold
    $w insert end "\n"
    $w insert end "\t[mc "Key ID"]:\t[edithex [string range [lindex $extcert(id-ce-subjectKeyIdentifier) 1] 4 end]]\n"  margins1
    #	set ::pkcs11id [string range [lindex $extcert(id-ce-subjectKeyIdentifier) 1] 4 end]
    unset extcert(id-ce-subjectKeyIdentifier)
  }
  if {[info exists extcert(id-ce-privateKeyUsagePeriod) ]} {
    $w insert end [mc "Key Usage Period"] bold
    $w insert end "\n"
    array set keyperiod [keyperiod [lindex $extcert(id-ce-privateKeyUsagePeriod) 1]]
    #	parray keyperiod
    set t $keyperiod(notBefore)
    set year [string range $t 0 3]
    set month [string range $t 4 5]
    set day [string range $t 6 7]
    set hour [string range $t 8 9]
    set minute [string range $t 10 11]

    #	puts  "$day $month $year $hour $minute"
    set notbefore "$day/$month/$year $hour:$minute"

    set t $keyperiod(notAfter)
    set notafter "[string range $t 6 7]/[string range $t 4 5]/[string range $t 0 3] [string range $t 8 9]:[string range $t 10 11]"
    $w insert end "\t[mc "Not Valid Before"]:\t$notbefore\n"  margins1
    $w insert end "\t[mc "Not Valid After"]:\t$notafter\n"  margins1

    if {[lindex $extcert(id-ce-privateKeyUsagePeriod) 0] == 1} {
      set critcert [mc "Yes"]
    } else {
      set critcert [mc "No"]
    }
    $w insert end "\t[mc "Critical"]:\t$critcert\n"  margins1
    unset extcert(id-ce-privateKeyUsagePeriod)
  }
  if {[info exists extcert(id-ce-authorityKeyIdentifier) ]} {
    $w insert end [mc "Certificate Authority Key Identifier"] bold
    $w insert end "\n"
    array set autkey [autkeyid [lindex $extcert(id-ce-authorityKeyIdentifier) 1]]
    $w insert end "\t[mc "Key ID"]:\t[edithex $autkey(authKeyID)]\n"  margins1
    if {[info exists autkey(issuer) ] } {
      $w insert end "\t[mc "Directory Name"]:\t$autkey(issuer)\n"  margins1
    }
    if {[info exists autkey(sernum) ]} {
      $w insert end "\t[mc "Serial Number"]:\t[edithex $autkey(sernum)]\n"  margins1
    }
    unset extcert(id-ce-authorityKeyIdentifier)
  }
  if {[info exists extcert(2.5.29.37) ]} {
    $w insert end [mc "Extended Key Usage"] bold
    $w insert end "\n"
    set listusage [extkeyuse [lindex $extcert(2.5.29.37) 1]]
    set oidt [string map {" " "."} [lindex $listusage 0]]
    if {[info exists ::payoid($oidt) ]} {
      set poid " ($::payoid($oidt))"
    } else {
      set poid ""
    }
    $w insert end "\t[mc "Allowed Purposes"]:\t$oidt$poid\n"  margins1
    for {set i 1 } { $i < [llength $listusage] } {incr i} {
      set oidt [string map {" " "."} [lindex $listusage $i]]
      if {[info exists ::payoid($oidt) ]} {
        set poid " ($::payoid($oidt))"
      } else {
        set poid ""
      }
      $w insert end "\t\t$oidt$poid\n"  margins1
    }
    if {[lindex $extcert(2.5.29.37) 0] == 1} {
      set critcert [mc "Yes"]
    } else {
      set critcert [mc "No"]
    }
    $w insert end "\t[mc "Critical"]:\t$critcert\n"  margins1
    unset extcert(2.5.29.37)
  }
  set ::chaincert ""
  if {[info exists extcert(1.3.6.1.5.5.7.1.1)]} {
    $w insert end [mc "Authority information Accesss"] bold
    $w insert end "\n"
    set listchain [chainocsp [lindex $extcert(1.3.6.1.5.5.7.1.1) 1]]
    #	puts $listchain
    foreach {a b} $listchain {
      $w insert end "\t[mc $a]:\tURI:$b\n"  margins1
    }
    set ::chaincert [lindex $extcert(1.3.6.1.5.5.7.1.1) 1]
    #	puts "CHAIN=[lindex $extcert(1.3.6.1.5.5.7.1.1) 1]"
    unset extcert(1.3.6.1.5.5.7.1.1)
  }

  set ::crlfile ""
  if {[info exists extcert(2.5.29.31)]} {
    $w insert end "CRL Distribution Points" bold
    $w insert end "\n"
    #	puts "CRL=$extcert(2.5.29.31)"
    set listcrl [crlpoints [lindex $extcert(2.5.29.31) 1]]
    #	puts $listcrl
    foreach {crlp} $listcrl {
      $w insert end "\tDistribution Point:\tURI:$crlp\n"  margins1
    }
    set ::crlfile  $listcrl
    unset extcert(2.5.29.31)
  }
  #extcert(id-ce-issuerAltName)          = false 3000
  #extcert(id-ce-subjectAltName)
  if {[info exists extcert(id-ce-issuerAltName)]} {
    $w insert end [mc "Issuer Alt Name"] bold
    $w insert end "\n"
    #	puts "ALT ISSUER=$extcert(id-ce-issuerAltName)"
    set listalt [altname [lindex $extcert(id-ce-issuerAltName) 1]]
    foreach {a b} $listalt {
      $w insert end "\t[mc $a]:\tURI:$b\n"  margins1
    }
    unset extcert(id-ce-issuerAltName)
  }
  if {[info exists extcert(id-ce-subjectAltName)]} {
    $w insert end [mc "Subject Alt Name"] bold
    $w insert end "\n"
    #	puts "ALT=$extcert(id-ce-subjectAltName)"
    set listalt [altname [lindex $extcert(id-ce-subjectAltName) 1]]
    foreach {a b} $listalt {
      $w insert end "\t[mc $a]:\tURI:$b\n"  margins1
    }
    unset extcert(id-ce-subjectAltName)
  }

  set listext [array get extcert]
  foreach {a b} $listext {
    $w insert end [mc "Extension"] bold
    $w insert end "\n"
    $w insert end "\t[mc "Identifier"]:\t$a\n"  margins1
    $w insert end "\t[mc "Value"]:\t[edithex [lindex $b 1]]\n"  margins1
    if {[lindex $b 0] == 1} {
      set critcert [mc "Yes"]
    } else {
      set critcert [mc "No"]
    }
    $w insert end "\t[mc "Critical"]:\t$critcert\n"  margins1
  }

  $w insert end [mc "Signature"] bold
  $w insert end "\n"
  $w insert end "\t[mc "Signature Algorithm"]\t[mc "$cert_parse(signature_algo)"]\n"  margins1
  $w insert end "\t[mc "Signature"]:\t[edithex $cert_parse(signature)]\n"  margins11

  $w insert end [mc "Certificate Fingerprints"] bold
  $w insert end "\n"

  set fingerprint_sha256 [::sha2::sha256 $::dercert]
  #    set fingerprint_sha1 [::sha1::sha1  $::dercert]
  set fingerprint_sha1_bin [lcc_sha1  $::dercert]
  binary scan $fingerprint_sha1_bin H* fingerprint_sha1

  $w insert end "\t[mc "SHA1"]:\t[edithex $fingerprint_sha1]\n"  margins11
  $w insert end "\t[mc "SHA256"]:\t[edithex $fingerprint_sha256]\n"  margins11

  set ::parsecerttxt [$w get 1.0 end]
}

proc savetext {w typetxt} {
  set tt [$w.text get 1.0 end]
  #    puts $tt
  set system_encoding [encoding system]
  saveCert $typetxt [encoding convertto $system_encoding $tt]
}

# openURL:
#    Sends a command to the user's web browser to view a webpage given
#    its URL.
#
proc openURL {url} {
  global typesys
  global macos
  #  global windowsOS
  if {$::typetlf} {
 	borg activity android.intent.action.VIEW $url text/html
 	return
  }


  set windowsOS 0
  if {$typesys == "win32"} {
    set windowsOS 1
  }
  #  busyCursor .
  if {$windowsOS} {
    # On Windows, use the "start" command:
    regsub -all " " $url "%20" url
    if {[string match $::tcl_platform(os) "Windows NT"]} {
      catch {exec $::env(COMSPEC) /c start $url &}
    } else {
      catch {exec start $url &}
    }
  } elseif {$macos} {
    # On Mac OS X use the "open" command:
    catch {exec open $url &}
  } else {
    # First, check if xdg-open works:
    if {! [catch {exec xdg-open $url &}] } {
      #lauch default browser seems ok, nothing more to do
    } elseif {[file executable [auto_execok firefox]]} {
      # Mozilla seems to be available:
      # First, try -remote mode:
      if {[catch {exec /bin/sh -c "$::auto_execs(firefox) -remote 'openURL($url)'"}]} {
        # Now try a new Mozilla process:
        catch {exec /bin/sh -c "$::auto_execs(firefox) '$url'" &}
      }
    } elseif {[file executable [auto_execok iceweasel]]} {
      # First, try -remote mode:
      if {[catch {exec /bin/sh -c "$::auto_execs(iceweasel) -remote 'openURL($url)'"}]} {
        # Now try a new Mozilla process:
        catch {exec /bin/sh -c "$::auto_execs(iceweasel) '$url'" &}
      }
    } elseif {[file executable [auto_execok mozilla]]} {
      # First, try -remote mode:
      if {[catch {exec /bin/sh -c "$::auto_execs(mozilla) -remote 'openURL($url)'"}]} {
        # Now try a new Mozilla process:
        catch {exec /bin/sh -c "$::auto_execs(mozilla) '$url'" &}
      }
    } elseif {[file executable [auto_execok www-browser]]} {
      # Now try a new Mozilla process:
      catch {exec /bin/sh -c "$::auto_execs(www-browser) '$url'" &}
    } elseif {[file executable [auto_execok netscape]]} {
      # OK, no Mozilla (poor user) so try Netscape (yuck):
      # First, try -remote mode to avoid starting a new netscape process:
      if {[catch {exec /bin/sh -c "$::auto_execs(netscape) -raise -remote 'openURL($url)'"}]} {
        # Now just try starting a new netscape process:
        catch {exec /bin/sh -c "$::auto_execs(netscape) '$url'" &}
      }
    } else {
      foreach executable {iexplorer opera lynx w3m links epiphan galeon
      konqueror mosaic amaya browsex elinks} {
        set executable [auto_execok $executable]
        if [string length $executable] {
          # Is there any need to give options to these browsers? how?
          set command [list $executable $url &]
          catch {exec /bin/sh -c "$executable '$url'" &}
          break
        }
      }
    }
  }
  #  unbusyCursor .
}

proc readdistr {urldistr w} {
  global typesys
  global myHOME
  set dir [tk_chooseDirectory -initialdir $myHOME -title "Каталог для дистрибутива" -parent $w]
  if {$typesys == "win32" } {
    if { "after#" == [string range $dir 0 5] } {
      set dir ""
    }
  }
  if {$dir == ""} {
    return
  }
  .topclock configure -text "Загрузка дистрибутива"
  .topclock.lclock configure -text "Начался процесс загрузки\n\nдистрибутива\n\n[file tail $urldistr]\n\nПодождите некоторое время!"
  place .topclock -in $w -relx 0.1 -rely 0.2
  after 100
  update

  set filedistr [readca $urldistr]
  if {$filedistr != ""} {
    set f [file join $dir [file tail $urldistr]]
    set fd [open $f w]
    chan configure $fd -translation binary
    puts -nonewline $fd $filedistr
    close $fd
    tk_messageBox -title "Загрузить дистрибутив" -icon info -message "Дистрибутив сохранен в файле\n$f"
  } else {
    tk_messageBox -title "Загрузить дистрибутив" -icon info -message "Не удалось загрузить дистрибутив \n$urldistr"
  }
  place forget .topclock
}


proc aboutUtil {w type parse_csr} {
  variable asnraw
  global typesys
  global dn_fields_ru

  if {$type == 0 } {
    set title {Об утилите cryptoarmpkcs}
  } elseif {$type == 2} {
    set title "Криптографические механизмы токена"
  } elseif {$type == 1} {
    set title {Содержимое запроса на сертификат}
    array set csr_parse $parse_csr
    #	parray csr_parse
  } elseif {$type == 7} {
    set title {Выпуск сертификата}
    array set csr_parse $parse_csr
    if {$::pointca != ""} {
      append csr_parse(extensions_bin) [createpointCA $::pointca]
    }
    #	parray csr_parse
  } elseif {$type == 3 || $type == 4 || $type == 5} {
    set title "Просмотр сертификата: \"$parse_csr\""
  } elseif {$type == 6 } {
    set title "Просмотр сертификата (PKCS12)"
  } elseif {$type == 8 || $type == 9} {
    set title "Просмотр ASN1-структуры"
  } else {
    puts "Неизвестный объект"
    return
  }
  catch {destroy $w}
wm state . withdraw
  toplevel $w -bg skyblue
  switch $typesys {
    win32        {
      wm geometry $w +200+100
      wm minsize $w 80 25
    }
    x11 {
#      wm geometry $w 80x25+200+100
#      wm geometry $w 80x25
    }
    classic - aqua {
      wm geometry $w 80x25+200+100
    }
  }

  wm title $w $title
  wm iconphoto $w icon11_24x24
  frame $w.txt -bg skyblue
  pack $w.txt -side top -expand 1 -fill both
  frame $w.butt -bg #f5f5f5 -highlightthickness 2 -highlightbackground skyblue -highlightcolor skyblue
  pack $w.butt -expand 0 -fill x -side bottom
  ttk::button $w.butt.ok -text "Ok" -command "destroy $w;global varview;set varview 1;wm state . normal"
  if {$type == 7} {
    ttk::button $w.butt.save -text "Выпуск сертификата" -command "buildCRT $w [list [array get csr_parse]]" 
  } else {
    if {$type == 8 || $type == 9} {
      ttk::button $w.butt.save -text "Сохранить" -command "savetext $w.txt 4" -style MyBorder.TButton
    } else {
      ttk::button $w.butt.save -text "Сохранить" -command "savetext $w.txt 4" -style MyBorder.TButton
    }
    if {$type == 0} {
      set ::entryd ""
      entry $w.butt.lab -textvariable ::entryd -highlightthickness 1 -highlightbackground skyblue -highlightcolor skyblue
      pack $w.butt.lab -side top  -pady {0 0} -fill x -expand 1  -padx {0 5}
    }
  }

  pack $w.butt.ok -side left -padx {4 5} -pady 2
  pack $w.butt.save -side left  -pady 2

  set worig $w
  set w $w.txt

  if {$type == 1 || $type == 7 || $type == 3 || $type == 4 || $type == 5  || $type == 6 } {
    text $w.text -setgrid true -autosep 1  -width 60 -height 20 -wrap word -bg snow -highlightthickness 1 -highlightbackground skyblue -highlightcolor skyblue

    $w.text tag configure bold -font TkDefaultFontBold
    $w.text tag configure super -offset 4p -font TkDefaultFont
    $w.text tag configure sub -offset -2p -font TkDefaultFont
    $w.text tag configure margins -lmargin1 4m -lmargin2 12m -rmargin 10m
    $w.text tag configure margins1 -lmargin1 2m -lmargin2 2.2i -rmargin 2m -spacing1 1p -spacing2 1p -spacing3 1p
    $w.text tag configure margins11 -lmargin1 2m -lmargin2 2.2i -rmargin 2m -spacing1 1p -spacing2 1p -spacing3 1p -font TkFixedFont
    $w.text tag configure margins2 -lmargin1 6m -lmargin2 2.2i -rmargin 2m -spacing1 1p -spacing2 1p -spacing3 1p
    $w.text tag configure spacing -spacing1 10p -spacing2 2p -lmargin1 12m -lmargin2 6m -rmargin 10m
    $w.text configure -tabs {1m 2.2i}
  } else {
    text $w.text -width 60 -height 20 -setgrid true -wrap word -bg #f5f5f5 -bg snow -highlightthickness 1 -highlightbackground skyblue -highlightcolor skyblue
  }
  bind $w.text <ButtonPress-3> {showTextMenu %W %x %y %X %Y}

  ttk::scrollbar $w.vsb -orient vertical -command [list $w.text yview]
  pack $w.vsb -side right -fill y  -in $w
  pack $w.text -padx {1 1} -pady {2 0} -side left -fill both -expand 1
  $w.text configure -yscrollcommand [list $w.vsb set]

  $w.text tag configure tagAbout -foreground blue -font {Roboto 10 bold italic}

  if {$type == 3} {
    ::fileWithCert $w.text $parse_csr "" $type
    return
  }
  if {$type == 4 || $type == 6} {
    ::fileWithCert $w.text $parse_csr $parse_csr $type
    return
  }
  if {$type == 5} {
    ::fileWithCert $w.text "" $parse_csr $type
    return
  }
  if {$type == 0 } {
    contentabout $w
  } elseif {$type == 2} {
    $w.text configure -background white
    $w.text insert end "\tКриптографические механизмы токена $::slotid_teklab\n\n" tagAbout
    #puts "HANDLE:ID:LAB=$::handle : $::slotid_tek : $::slotid_teklab"
    set llmech [pki::pkcs11::listmechs $::handle $::slotid_tek]
    foreach mech $llmech {
      $w.text insert end $mech
      $w.text insert end "\n"
    }
  } elseif {$type == 8 || $type == 9} {
    #type = 8 или 9 - разбор ASN1-структуры, 8 - полный (код для tag-ов) , 9 - без кода
    $w.text configure -background white
    if {$asnraw} {
      $w.text insert end "\t\tASN1-структура в расширенном формате\n\n" tagAbout
    } else {
      $w.text insert end "\t\tASN1-структура\n\n" tagAbout
    }
    #Должно быть так
    if {$type == 8} {
      set raw 1
    } else {
      set raw 0
    }
    #	update

    set ret [DER_PrettyPrint $w.text $parse_csr $raw]
    if {$ret < 0} {
      catch {$w.text tag configure rawAsn -foreground red}
      catch {$w.text insert end "\n\t\tРазбор прекращен.\n\n\tВ файле находится плохая ASN1-структура.\n\tВ полне возможно вы ошиблись с форматом файла\n\tПроверьте путь к файлу или содержимое файла.\n" rawAsn}
    }

  } else {
    #puts "Содержимое запроса"
    #parray csr_parse
    set lsub [split $csr_parse(subject) ","]
    set lsub [del_comma $lsub]
    #    puts $lsub

    $w.text insert end [mc "Subject Name"] bold
    $w.text insert end "\n"
    foreach a $lsub {
      set ind [string first "=" $a]
      if {$ind == -1 } { continue }
                        	
      set oidsub [string trim [string range $a 0 $ind-1]]
      #puts "oidsub=$oidsub"
      #puts "DN_oidsub=$dn_fields($oidsub)"
      if {[info exists dn_fields_ru($oidsub)]} {
        #		set nameoid " ($dn_fields_ru($oidsub))"
        set nameoid "$dn_fields_ru($oidsub)"
      } else {
        set nameoid ""
      }

      #	puts $nameoid
      set oidval "[mc [string trim [string range $a $ind+1 end]]]"
                        	
      #	    set oidsub "$oidsub$nameoid"
      if {$oidsub == "GIVENNAME"} {
        set oidsub "GV"
      }
      set oidsub "$nameoid ($oidsub)"
      $w.text insert end "\t$oidsub\t$oidval\n"  margins1
    }
    unset csr_parse(subject)
    $w.text insert end [mc "Public Key Info"] bold
    $w.text insert end "\n"
    if {[string range $csr_parse(pubkey_algo) 0 7] == "1.2.643." || [string range $csr_parse(pubkey_algo) 0 7] == "1 2 643 " || [string range $csr_parse(pubkey_algo) 0 7] == "ГОСТ Р 3" || [string range $csr_parse(pubkey_algo) 0 7] == "GOST R 3"} {
      set nalgo [::pki::_oid_number_to_name $csr_parse(pubkey_algo)]
      #	    $w.text insert end "\t[mc "Key Algorithm"]:\t[mc $csr_parse(pubkey_algo)]\n"  margins1
      $w.text insert end "\t[mc "Key Algorithm"]:\t$nalgo\n"  margins1
      $w.text insert end "\t[mc "Key Parameters"]:\n"  margins1
      array set ret [parse_key_gost $csr_parse(pubkeyinfo)]
      #	parray ret
      $w.text insert end "\t[mc "sign param"]:\t[mc $ret(paramkey)]\n"  margins2
      $w.text insert end "\t[mc "hash param"]:\t[mc $ret(hashkey)]\n"  margins2
      set sek 4
      if {[string range $ret(pubkey) 2 3] != 40} {
        set sek 6
      }
      set pk [edithex [string range $ret(pubkey) $sek end]]
      $w.text insert end "\t[mc "Public Key"]:\t$pk\n"  margins11
    } else {
      if {[string range $csr_parse(pubkey_algo) 0 2] == "rsa" } {
        $w.text insert end "\t[mc "Key Algorithm"]:\tRSA\n"  margins1
        $w.text insert end "\t[mc "Key Size"]:\t$csr_parse(l)\n"  margins2
        $w.text insert end "\t[mc "Public Key"]:\t[edithex $csr_parse(pubkey)]\n"  margins11
      } else {
        $w.text insert end "\t[mc "Key Algorithm"]:\t$csr_parse(pubkey_algo)\n"  margins1
        $w.text insert end "\t[mc "Key Info"]:\t[edithex $csr_parse(pubkeyinfo)]\n" margins11
      }
    }
    unset csr_parse(pubkey_algo)
    unset csr_parse(pubkeyinfo)	
    array set extcert $csr_parse(extensions)
    if {[info exists extcert(1.2.643.100.111)]} {
      #subjectSignTools
      #puts "SUBJECTSINGT=$extcert(1.2.643.100.111)"

      array set pol [subjectpol [lindex $extcert(1.2.643.100.111) 1]]
      $w.text insert end [mc "subjectSignTool"] bold
      $w.text insert end "\n"
      $w.text insert end "\t[mc "User CKZI"]:\t$pol(isspol1)\n"  margins1
      #	parray pol
      unset extcert(1.2.643.100.111)
    }
    if {[info exists extcert(id-ce-keyUsage)]} {
      $w.text insert end [mc "Key Usage"] bold
      $w.text insert end "\n"

      set ku [extku [lindex $extcert(id-ce-keyUsage) 1]]
      $w.text insert end "\t[mc "Usages"]:\t[mc [lindex $ku 0]]\n"  margins1
      for {set i 1 } { $i < [llength $ku] } {incr i} {
        $w.text insert end "\t\t[lindex $ku $i]\n"  margins1
      }
      #	puts $ku
      if {[lindex $extcert(id-ce-keyUsage) 0] == 1} {
        set critcert [mc "Yes"]
      } else {
        set critcert [mc "No"]
      }
      $w.text insert end "\t[mc "Critical"]:\t$critcert\n"  margins1
      unset extcert(id-ce-keyUsage)
    }
    if {[info exists extcert(2.5.29.37) ]} {
      $w.text insert end [mc "Extended Key Usage"] bold
      $w.text insert end "\n"
      set listusage [extkeyuse [lindex $extcert(2.5.29.37) 1]]
      set oidt [string map {" " "."} [lindex $listusage 0]]
      if {[info exists ::payoid($oidt) ]} {
        set poid " ($::payoid($oidt))"
      } else {
        set poid ""
      }
      $w.text insert end "\t[mc "Allowed Purposes"]:\t$oidt$poid\n"  margins1
      for {set i 1 } { $i < [llength $listusage] } {incr i} {
        set oidt [string map {" " "."} [lindex $listusage $i]]
        if {[info exists ::payoid($oidt) ]} {
          set poid " ($::payoid($oidt))"
        } else {
          set poid ""
        }
        $w.text insert end "\t\t$oidt$poid\n"  margins1
      }
      if {[lindex $extcert(2.5.29.37) 0] == 1} {
        set critcert [mc "Yes"]
      } else {
        set critcert [mc "No"]
      }
      $w.text insert end "\t[mc "Critical"]:\t$critcert\n"  margins1
      unset extcert(2.5.29.37)
    }

    set listext [array get extcert]
    foreach {a b} $listext {
      $w.text insert end [mc "Extension"] bold
      $w.text insert end "\n"
      $w.text insert end "\t[mc "Identifier"]:\t$a\n"  margins1
      $w.text insert end "\t[mc "Value"]:\t[edithex [lindex $b 1]]\n"  margins1
      if {[lindex $b 0] == 1} {
        set critcert [mc "Yes"]
      } else {
        set critcert [mc "No"]
      }
      $w.text insert end "\t[mc "Critical"]:\t$critcert\n"  margins1
    }
    unset csr_parse(extensions)
    unset csr_parse(extensions_bin)
    set sign_algo $csr_parse(signature_algo)
    unset csr_parse(signature_algo)
    set signat $csr_parse(signature)
    unset csr_parse(signature)
    unset csr_parse(verify)
    set attrms [array get csr_parse]
    puts "ATTRMS=$attrms"
    foreach {a b} $attrms {
      $w.text insert end [mc "Attribute"] bold
      $w.text insert end "\n"
      $w.text insert end "\t[mc "Identifier"]:\t$a\n"  margins1
      $w.text insert end "\t[mc "Value"]:\t[edithex $b]\n"  margins1
    }	
    parray csr_parse
    $w.text insert end [mc "Signature"] bold
    $w.text insert end "\n"
    $w.text insert end "\t[mc "Signature Algorithm"]\t[mc "$sign_algo)"]\n"  margins1
    $w.text insert end "\t[mc "Signature"]:\t[edithex $signat]\n"  margins11


  }

  #    wm protocol $w WM_DELETE_WINDOW ";"

  set w $worig
  catch {grab set $w}
  catch {tkwait window $w}
}

proc chainocsp {chain_hex} {
  set chain [binary format H* $chain_hex]
  set ret {}
  ::asn::asnGetSequence chain c_par_first
  while {[string length $c_par_first] > 0 } {
    #Выбираем очередную последовательность (sequence)
    ::asn::asnGetSequence c_par_first c_par
    #Выбираем oid из последовательности
    ::asn::asnGetObjectIdentifier c_par c_type
    set tas1 [::pki::_oid_number_to_name $c_type]
    #Выбираем установленное значение
    ::asn::asnGetContext c_par c_par_two
    #Ищем oid с адресом корневого сертификата
    if {$tas1 == "1.3.6.1.5.5.7.48.2" } {
      #Читаем очередной корневой сертификат
      lappend ret "CA Issuers"
      lappend ret $c_par
      #	    puts "CA (oid=$tas1)=$c_par"
    } elseif {$tas1 == "1.3.6.1.5.5.7.48.1" } {
      lappend ret "OCSP"
      lappend ret $c_par
      #	    puts "OCSP server (oid=$tas1)=$c_par"
    }
  }
  # Цепочка закончилась
  return $ret
}

proc crlpoints {crl_hex} {
  set crl [binary format H* $crl_hex]
  set ret {}
  ::asn::asnGetSequence crl p_crl_first
  set lencontspec 4
  while {[string length $p_crl_first] > 0 } {
    #Выбираем очередную последовательность (sequence)
    ::asn::asnGetSequence p_crl_first c_par
    #Пропускаем contextspecific - 0xA0
    ::asn::asnGetContext c_par context_0xa0
    ::asn::asnPeekByte c_par peek_tag
    while {$peek_tag == 0xA0} {
	::asn::asnGetContext c_par context_0xa0
	::asn::asnPeekByte c_par peek_tag
    }
    ::asn::asnGetContext c_par ux
    #	puts $c_par
    lappend ret $c_par
  }
  return $ret
}

proc altname {alt_hex} {
  set ret {}
  set listname [binary format H* $alt_hex]
  ::asn::asnGetSequence listname names
  while {[string length $names] > 0 } {
    ::asn::asnGetByte names tag
    if {$tag == 0x82 || $tag == 0x81 || $tag == 0x87} {
      #0x82 DNS Name ; 0x81 - RFC 822
      #	    puts "0x82"
      ########################
      ::asn::asnGetByte names taglen
      set len82 [format "%i" $taglen]
      #	    puts $len82
      incr len82 -1
      if {$tag == 0x82 } {
        #Читаем очередной корневой сертификат
        lappend ret "DNS Name"
      } elseif {$tag == 0x81 } {
        #		lappend ret "RFC822 Name"
        lappend ret "Email"
      } elseif {$tag == 0x87 } {
        lappend ret "IP-Address"
      } else {
        lappend ret [format "0x%2x" $tag]
      }
      if {$tag != 0x87 } {
        lappend ret [string range $names 0 $len82]
      } else {
        set ip_b [string range $names 0 $len82]
        lappend ret [ip::ToString $ip_b]
      }
      #	    puts $ret
      incr len82
      set a [string range $names $len82 end]
      set names $a
    }
  }
  return $ret
}

proc keyperiod {per_hex} {
  set per [binary format H* $per_hex]
  array set ret [list]
  ::asn::asnGetSequence per validaty
  ::asn::asnGetByte validaty tag
  if {$tag == 0x80} {
    ::asn::asnGetByte validaty tag
    set len80 [format "%i" $tag]
    incr len80 -1
    set ret(notBefore) [string range $validaty 0 $len80]
    incr len80
    set a [string range $validaty $len80 end]
    set validaty $a
    ::asn::asnGetByte validaty tag
  } else {
    set ret(notBefore) ""
  }
  if {$tag != 0x81} {
    set ret(After) ""
    return [array get ret]
  }
  ::asn::asnGetByte validaty tag
  set len81 [format "%i" $tag]
  incr len81 -1
  set ret(notAfter) [string range $validaty 0 $len81]
  incr len81
  return [array get ret]
}


proc autkeyid {autkey_hex} {
  set autkey [binary format H* $autkey_hex]
  array set ret [list]
  #########################################
  set autkey [binary format H* $autkey_hex]
  array set ret [list]
  ::asn::asnGetSequence autkey fullkey
  #Чтение KEY ID
  ::asn::asnGetContext fullkey - cont
  #    puts "LEN=[string length $fullkey]"
  binary scan $cont H* ret(authKeyID)
  while {[string length $fullkey]} {
    ::asn::asnGetByte fullkey tag1
    ::asn::asnGetLength fullkey tag
    set len80 [format "0x%x" $tag]
    set ee [string range $fullkey 0 0]
    if { $ee == 0} {
      ::asn::asnGetSequence fullkey autdn
      set ret(issuer) [::pki::x509::_dn_to_string $autdn]
      ::asn::asnGetContext fullkey - sernum
      binary scan $sernum H* ret(sernum)
      break
    }
  }

  return [array get ret]
}



proc parse_key_gost {pubkeyinfo_hex} {
  array set ret [list]

  set pubkeyinfo [binary format H* $pubkeyinfo_hex]

  ::asn::asnGetSequence pubkeyinfo pubkey_algoid
  ::asn::asnGetObjectIdentifier pubkey_algoid ret(pubkey_algo)
  ::asn::asnGetBitString pubkeyinfo pubkey

  #		"1.2.643.2.2.19" -
  #		"1.2.643.7.1.1.1.1" -
  #		"1.2.643.7.1.1.1.2"
  #	gost2001, gost2012-256,gost2012-512
  set pubkey [binary format B* $pubkey]
  binary scan $pubkey H* ret(pubkey)
  ::asn::asnGetSequence pubkey_algoid pubalgost
  #OID - параметра
  ::asn::asnGetObjectIdentifier pubalgost ret(paramkey)
  #OID - Функция хэша
  ::asn::asnGetObjectIdentifier pubalgost ret(hashkey)
  #puts "ret(paramkey)=$ret(paramkey)\n"
  #puts "ret(hashkey)=$ret(hashkey)\n"
  #parray ret
  return [array get ret]

}


proc createnick {issuer_str subject_str} {
  set cn_subject ""
  set cn_issuer ""
  set lsub [split $subject_str ","]
  set lsub [del_comma $lsub]
  #    puts $lsub
  set cn_subject "Отсутствует"
  foreach a $lsub {
    set ind [string first "=" $a]
    if {$ind == -1 } { continue }
    set oidsub [string trim [string range $a 0 $ind-1]]
    set oidval "[string trim [string range $a $ind+1 end]]"
    if {$oidsub == "CN"} {
      set cn_subject  $oidval
      break;
    }
  }
  #ISSUER
  set lsub [split $issuer_str ","]
  set lsub [del_comma $lsub]
  #    puts $lsub
  set cn_issuer "Отсутствует"
  foreach a $lsub {
    set ind [string first "=" $a]
    if {$ind == -1 } { continue }
    set oidsub [string trim [string range $a 0 $ind-1]]
    set oidval "[string trim [string range $a $ind+1 end]]"
    if {$oidsub == "CN"} {
      set cn_issuer  $oidval
      break;
    }
  }
  return "$cn_subject from $cn_issuer"
}

#-----------------------------------------------------------------------------
# asnGNTTime : Encode an GNT time string
#-----------------------------------------------------------------------------
proc ::asn::asnGNTTime {GNTtimestring} {
  # the gnt time tag is 0x18.
  #
  # BUG: we do not check the string for well formedness

  set ascii [encoding convertto ascii $GNTtimestring]
  set len [string length $ascii]
  return [binary format H2a*a* 18 [asnLength $len] $ascii]
}

proc asn::asnGetGNTTime {data_var utc_var} {
  upvar 1 $data_var data $utc_var utc

  asnGetByte data tag
  if {$tag != 0x18} {
    return -code error \
    [format "Expected GNTTime (0x18), but got %02x" $tag]
  }

  asnGetLength data length
  asnGetBytes data $length bytes

  # this should be ascii, make it explicit
  set bytes [encoding convertfrom ascii $bytes]

  binary scan $bytes a* utc

  return
}

# Parse a PKCS#10 CSR
proc ::pki::pkcs::parse_csr_gost {csr} {
  array set ret [list]
  set data $csr
  set headcsr "-----BEGIN NEW CERTIFICATE REQUEST-----"
  set tailcsr "-----END NEW CERTIFICATE REQUEST-----"
  if {[string first "-----BEGIN " $data] != -1} {
    #	set data [string map {"\015\012" "\n"} $data]
    set data [string map {"\r\n" "\n"} $data]
    if {[string first "-----BEGIN CERTIFICATE REQUEST-----" $data] != -1} {
      set headcsr "-----BEGIN CERTIFICATE REQUEST-----"
      set tailcsr "-----END CERTIFICATE REQUEST-----"
    } elseif {[string first "-----BEGIN NEW CERTIFICATE REQUEST-----" $data] != -1} {
      set headcsr "-----BEGIN NEW CERTIFICATE REQUEST-----"
      set tailcsr "-----END NEW CERTIFICATE REQUEST-----"
    } else {
      return -code error "not csr"
    }
    #puts "HEAD=$headcsr\nTAIL=$tailcsr"
    #puts "CERT=$data"
  } elseif {[string range $data 0 0] != "0"} {
    return -code error "not csr"
  }

  array set parsed_csr [::pki::_parse_pem $data $headcsr $tailcsr]
  set csr $parsed_csr(data)

  ::asn::asnGetSequence csr cert_req_seq
  ::asn::asnGetSequence cert_req_seq cert_req_info

  set cert_req_info_saved [::asn::asnSequence $cert_req_info]
  ::asn::asnGetInteger cert_req_info version
  ::asn::asnGetSequence cert_req_info name
  ::asn::asnGetSequence cert_req_info pubkeyinfo
  #LISSI
  binary scan $pubkeyinfo H* ret(pubkeyinfo)
  ::asn::asnGetSequence pubkeyinfo pubkey_algoid
  ::asn::asnGetObjectIdentifier pubkey_algoid ret(pubkey_algo)

  ################Extensi
  set extensions_list [list]

  if {$cert_req_info != ""} {
    ::asn::asnGetContext cert_req_info - extensions_ctx
    while {$extensions_ctx != ""} {
      ::asn::asnGetSequence extensions_ctx extensions
      ::asn::asnGetObjectIdentifier extensions extensions4
      #puts "parse_cert_gost: extensions4=$extensions4"
      if {$extensions4 != "1 2 840 113549 1 9 14"} {
        #Различные атрибуты, например от CAPICOM
        ::asn::asnPeekByte extensions peek_tag
        if {$peek_tag == 0x1} {
          ::asn::asnGetBoolean extensions ext_critical
        } else {
          set ext_critical false
        }
        ::asn::asnGetSet extensions ext_value_seq
        binary scan $ext_value_seq H* ext_value_seq_hex

        set ret($extensions4) $ext_value_seq_hex
        continue
      }
      ::asn::asnGetSet extensions extensions1
      #puts "parse_cert_gost: extensions4=$extensions4 1"
                        			
      if {$extensions4 == "1 2 840 113549 1 9 14"} {
        #puts "parse_cert_gost: extensions4=РАСШИРЕНИЕ"
        ::asn::asnGetSequence extensions1 extensions
        #Запоминаем расширение для подстановки в сертификат
        set ret(extensions_bin) $extensions

        while {$extensions != ""} {
          ::asn::asnGetSequence extensions extension
          ::asn::asnGetObjectIdentifier extension ext_oid
          ::asn::asnPeekByte extension peek_tag
          if {$peek_tag == 0x1} {
            ::asn::asnGetBoolean extension ext_critical
          } else {
            set ext_critical false
          }
          ::asn::asnGetOctetString extension ext_value_seq

          set ext_oid [::pki::_oid_number_to_name $ext_oid]

          set ext_value [list $ext_critical]

          switch -- $ext_oid {
            id-ce-basicConstraints {
              ::asn::asnGetSequence ext_value_seq ext_value_bin

              if {$ext_value_bin != ""} {
                ::asn::asnGetBoolean ext_value_bin allowCA
              } else {
                set allowCA "false"
              }

              if {$ext_value_bin != ""} {
                ::asn::asnGetInteger ext_value_bin caDepth
              } else {
                set caDepth -1
              }
                                                        						
              lappend ext_value $allowCA $caDepth
            }
            default {
              binary scan $ext_value_seq H* ext_value_seq_hex
              lappend ext_value $ext_value_seq_hex
            }
          }

          lappend extensions_list $ext_oid $ext_value
        }
        #puts "parse_cert_gost: extensions4=РАСШИРЕНИЕ END"
      }
    }
  }
  set ret(extensions) $extensions_list

  ###########Ext end
  ::asn::asnGetSequence cert_req_seq signature_algo_seq
  ::asn::asnGetObjectIdentifier signature_algo_seq signature_algo
  ::asn::asnGetBitString cert_req_seq signature_bitstring

  # Convert parsed fields to native types
  set signature [binary format B* $signature_bitstring]
  set ret(subject) [::pki::x509::_dn_to_string $name]
  binary scan $signature H* ret(signature)
  #puts "SIGN_ALGO=$signature_algo"
    set vercrs 1

  if {$signature_algo == "1 2 643 7 1 1 3 3"} {
    set stribog stribog512
      set digest_len 64
  } elseif {$signature_algo == "1 2 643 7 1 1 3 2"} {
    set stribog stribog256
      set digest_len 32
  } else {
    set vercrs 0
    set ret(signature_algo) [::pki::_oid_number_to_name $signature_algo]
   tk_messageBox -title "Просмотр запроса на сертификат" -message "Неизвестный алгоритм подписи:\n$signature_algo" -detail "Проверка подписи запроса невозможна" -icon info 
#    return -code error "CSR Signature not GOST"
  }
  #puts "STRIBOG=$stribog"
  set ret(verify) $vercrs

  set ret(signature_algo) [::pki::_oid_number_to_name $signature_algo]
  if {$vercrs} {
    array set infopk [parse_key_gost $ret(pubkeyinfo)]
#    parray infopk
    set parid "$infopk(paramkey)"
    set parid $::param3410($parid)
    set digest_bin [lcc_gost3411_2012 $digest_len $cert_req_info_saved]
    if {$infopk(pubkey_algo) == "1 2 643 7 1 1 1 1"} {
      set group [lcc_gost3410_2012_256_getGroupById "$parid"]
      set public_key_str [string range $infopk(pubkey) 4 end]
      set public_key_str [binary format H* $public_key_str]
      set ret(verify) [lcc_gost3410_2012_256_verify $group $public_key_str $digest_bin $signature]
    } elseif {$infopk(pubkey_algo) == "1 2 643 7 1 1 1 2"} {
      set group [lcc_gost3410_2012_512_getGroupById "$parid"]
      set public_key_str [string range $infopk(pubkey) 6 end]
      set public_key_str [binary format H* $public_key_str]
      set ret(verify) [lcc_gost3410_2012_512_verify $group $public_key_str $digest_bin $signature]
    } else {
      tk_messageBox -title "Проверка подписи" -icon error -message "Неподдерживаемый тип ключа" -detail "$infopk(pubkey_algo)"  -parent .
      ret(verify) 0
    }
  }
  #parray ret
  return [array get ret]
}


proc ::viewCert {type nick} {
  #    puts "viewCert NICK=$nick"
  puts "type=$type"
  if {$type == "pkcs11"} {
    if {$nick == ""} {
      tk_messageBox -title "Просмотр сертификата на токене" -icon info -message "Нет сертификатов"  -parent .
      return
    }
    #    puts "arrayCer=$::arrayCer($nick)"

    aboutUtil .about 3 $nick
    return
  }
  set certp7 ""
  if {$type == "pkcs7"} {
    puts "View from PKCS7=$nick"
    foreach p7t $::lp7 {
      #puts "P7=$p7t"
      array set p7 $p7t
      #parray p7
      #Ищем подписанта
      if {$p7(nickcert) == $nick} {
        set certp7 $p7(cert_hex)
      }
    }
    if {$certp7 == ""} {
      puts "Not found certificate"
      return
    }
    aboutUtil .about 4 $certp7
    return
  }
  set fcert ""
  if {$type == "file"} {
    aboutUtil .about 5 $nick
    return
  }
  if {$type == "pkcs12"} {
    if {$nick == ""} {
      tk_messageBox -title "Просмотр сертификата из PKCS12" -icon info -message "Не выбран файл с \nконтейнером PKCS12"  -parent .
      return
    }
    aboutUtil .about 6 $nick
    return
  }
}


proc ::viewCSR {file type} {
  #type 1 - view csr; 7 - create certificate
  variable dir_crt
  if {$file == ""} {
    tk_messageBox -title "Просмотр запроса на сертификат" -icon info -message "Не выбран файл с запросом на сертификат"  -parent .
    return
  }
  set mes ""
  if {$type == 7 } {
    if {$dir_crt == ""} {
      tk_messageBox -title "Выпуск сертификата" -message "Не выбран каталог для хранения сертификатов и ключей." -icon error  -parent .
      return
    }
    set mes "\nСертификат не может быть создан\n"
  }
  set fd [open $file]
  chan configure $fd -translation binary
  set data [read $fd]
  close $fd

# array set csr_parse [::pki::pkcs::parse_csr_gost $data]
  if {[catch {array set csr_parse [::pki::pkcs::parse_csr_gost $data]} rc]} {
    tk_messageBox -title "Просмотр запроса на сертификат" -icon error -message "$file" -detail "Выбранный файл не содержит запроса (parse_csr_gost) на сертификат\n$rc"  -parent .
    return
  }
  #    parray csr_parse
  if {$csr_parse(verify) != 1} {
                	
    tk_messageBox -title "Просмотр запроса на сертификат" -icon error -message "Запрос:\n$file $mes" -detail "Подпись запроса (parse_csr_gost) на сертификат не верна или не проверялась"  -parent .
    if {$type == 7 } {
      return
    }
  }

  set loadfile $file
  aboutUtil .about $type [array get csr_parse]

}


proc reverse {args} {
  set res [list]
  if {[llength $args] == 1} {
    set args [lindex $args 0]
  }
  foreach elem $args {
    set res [linsert $res 0 $elem]
  }
  return $res
}

proc clock:set var {
  global $var
  set $var "Текущее время: [clock format [clock seconds] -format {%H:%M:%S %d.%m.%Y}]"
  after 1000 [list clock:set $var]
}

proc readPw ent {
  global widget
  global yespas
  global pass
  #	puts "readPWD"
  set pass [$ent get]
  $ent delete 0 end
  set yespas "yes"
  wm state .topPinPw withdraw
}


proc page_password {}  {
#Widget for enter PIN or Password
if {1} {
    toplevel .topPinPw -borderwidth 2 -class Toplevel -relief ridge -background #39b5da -height 140 -highlightbackground gray85 -highlightcolor black
    global icon11_24x24
    wm minsize .topPinPw 400 100
#    wm geometry .topPinPw +383+258
    wm iconphoto .topPinPw icon11_24x24
    wm state .topPinPw withdraw
}
#frame .topPinPw
    labelframe .topPinPw.labFrPw -borderwidth 4 -class LabelFrame -labelanchor nw -relief groove -text "Введите PIN-код для токена и нажмите ВВОД" -foreground blue -background #eff0f1 -height 95 -width 300
    pack .topPinPw.labFrPw -anchor nw -padx 3 -pady 3 -fill both -expand 1
    entry .topPinPw.labFrPw.entryPw -background snow -show * -highlightbackground gray85 -highlightcolor skyblue -justify left -relief sunken
    entry .topPinPw.labFrPw.entryLb -background snow -highlightbackground gray85 -highlightcolor skyblue -justify left -relief sunken
    pack .topPinPw.labFrPw.entryPw -fill x -expand 1 -padx 5 -pady 5  -ipady 2
    bind .topPinPw.labFrPw.entryPw <Key-Return> {readPw .topPinPw.labFrPw.entryPw}
    bind .topPinPw.labFrPw.entryLb <Key-Return> {readPw .topPinPw.labFrPw.entryLb}
    ttk::button .topPinPw.labFrPw.butPw  -command {global yespas;set yespas "no"; wm state .topPinPw withdraw;} -text "Отмена"  -style My.TButton
    pack .topPinPw.labFrPw.butPw -pady {0 5} -sid right -padx 5
}

proc ::sign_file {w typekey} {
  global ttt
  global typesys
  variable nickCert
  global pass
  global yespas
  set yespas ""
  set pass ""
  #    puts "sign_file=$w"
  variable file_for_sign
  variable doc_for_sign
  variable typesig
  variable doc_for_sign
  if {$doc_for_sign == "" } {

#set ::retmes 0
#place .canmes -in .fn1.fr0 -relx 0.5 -rely 1.0
#vwait ::retmes

    tk_messageBox -title "Подписать документ" -detail "Не выбран документ для подписания" -icon error  -parent .
    return
  }
  if {$file_for_sign == "" } {
    tk_messageBox -title "Подписать документ" -message "Не выбрана папка для хранения ЭП" -icon error  -parent .
    return
  }

  #puts "sign_file=$nickCert"
  set cert_hex ""
  set ::dercert ""
  if {$typekey == "pkcs11"} {
    foreach certinfo_list $::certs_p11 {
      unset -nocomplain cert_parse
      array set cert_parse_der $certinfo_list
      if {$cert_parse_der(pkcs11_label) == $nickCert} {
        set cert_hex  $cert_parse_der(cert_der)
        break
      }
    }
  } elseif {$typekey == "pkcs12"} {
    set cert_hex $::certfrompfx
  } else {
    tk_messageBox -title "Подписать документ" -message "Неизвестное хранилище ключа" -icon error  -parent .
    return
  }
  if {$cert_hex == ""} {
    if {$typekey == "pkcs11"} {
      tk_messageBox -title "Подписать документ" -message "На токене отсутствует (не выбран) сертификат подписанта!" -icon error  -parent .
    } else {
      tk_messageBox -title "Подписать документ" -message "Отсутствует контейнер PKCS12 подписанта"  -icon error  -parent .
    }
    return
  }
  set fd [open $doc_for_sign]
  chan configure $fd -translation binary
  set content [read $fd]
  close $fd
  if {$content == "" } {
    tk_messageBox -title "Подписать документ" -message "Попытка подписать пустой документ:" -detail "\t$doc_for_sign" -icon error  -parent .
    return
  }
  #puts "typesig=$typesig"
  set f [file join $file_for_sign [file tail $doc_for_sign]]
  set f_sign "$f.p7s"
  if {$typekey == "pkcs11"} {
    #puts "f_sign=$f_sign"
    #Ввод PIN-кода
wm state . withdraw
    wm title .topPinPw "Токен: $::slotid_teklab"
    wm state .topPinPw normal
    wm state .topPinPw withdraw
    wm state .topPinPw normal
    raise .topPinPw
    grab .topPinPw
    focus .topPinPw.labFrPw.entryPw
    set yespass ""
    vwait yespas
    grab release .topPinPw
wm state . normal
    #Ввод пароля
    if { $yespas == "no" } {
      return 0
    }
    set yespas "no"
    set password $pass
    set pass ""
                	
    if { [pki::pkcs11::login $::handle $::slotid_tek $password] == 0 } {
      tk_messageBox -title "Подписать документ" -message "Документ подписать не удалось" -detail "Неверный PIN-код" -icon error  -parent .
      return
    }
    set password ""
    set privkey [::pki::pkcs11::listobjects $::handle $::slotid_tek  privkey]
    #puts "PRIVKEY=$privkey"
    #puts "nickCert=$nickCert"
    ######################
    foreach certinfo_list $::certs_p11 {
      unset -nocomplain cert_parse_der
      array set cert_parse_der $certinfo_list
      if {$cert_parse_der(pkcs11_label) == $nickCert} {
        set ::cert_pkcs11_id $cert_parse_der(pkcs11_id)
        #parray cert_parse_der
        break
      }
    }
    #Экспорт в текстовом виде	.saveCert.labExp.but.butSave configure -text [mc "Export"]
    set ::tekcert "pkcs11"
    ###################

    set i 0
    foreach prkey $privkey {
      if {$::cert_pkcs11_id == [lindex $prkey 3]} {
        #	    if {$nickCert == [lindex $prkey 2]} {}
        set i 1
        break
      }
    }
    if {$i == 0 } {
      tk_messageBox -title "Подписать документ" -message "Документ подписать не удалось" -detail "У сертификата \n$nickCert\n нет закрытого ключа" -icon error  -parent .
      return
    }
  }

set waitsign 1
#    wm state . withdraw
  .topclock configure -text "Подписание документа"
  .topclock.lclock configure -text "Начался процесс подписания\nдокумента из файла\n[file tail $doc_for_sign]\nПодождите некоторое время!"
  place .topclock -in $w -relx 0.1 -rely 0.2
  after 100
  update
  vwait ttt

  set err [::pkcs7_create_signeddata $content $cert_hex $typesig $f_sign $typekey]
  if {$err == 1} {
    set attrf [file attributes $doc_for_sign]
    file attributes $f_sign -permissions 00660
#Проверка на госуслугах
      set pathsign [string map {"/" "/\n"} $f_sign]

    set answer [tk_messageBox -icon question \
    -message "Документ успешно подписан." \
    -title "Подписать документ" \
    -detail "Подпись сохранена в файле:\n$pathsign\nБудете проверить на Госуслугах?" \
    -type yesno]
    place forget .topclock
    if {$answer == "yes"} {
	borg activity android.intent.action.VIEW https://www.gosuslugi.ru/pgu/eds/  text/html
    }
    set err 0
    return
  }
  if {$err != 0} {
    tk_messageBox -title "Подписать документ" -message "Документ подписать не удалось" -detail "$err" -icon error  -parent .
  }
  if {$waitsign} {
    place forget .topclock
  }
}

proc keyParam {w tpage key} {
  global wizDatacsr
  global wizDatacert
  #    global defaultpar
  #    global defaultkey
  variable opts
  global profile_options
  #Ключ генерится на токене keytok = 1
  if {$tpage == "csr" } {
    set keytok $wizDatacsr(keytok)
    set defaultkey $wizDatacsr(typekey)
    set defaultpar $wizDatacsr(parkey)
  } else {
    set keytok $wizDatacert(keytok)
    set defaultkey $wizDatacert(typekey)
    set defaultpar $wizDatacert(parkey)
  }
  #tk_messageBox -title "Тип ключа" -icon info -message "defaultkey=$defaultkey\ndefaultpar=$defaultpar\nw=$w"  -parent .
  #Ключ генерится на Lcc и хранится в файле keytok = 0
  if {$keytok == 1 } {
    set lists [listts $::handle]
    if {[llength $lists] == 0 } {
      tk_messageBox -title "Тип ключа" -icon info -message "Токены отсутствуют" -detail "Установлена генерация ключей в Lcc\nКлюч будет сохранен в файле" -parent .
      set wizDatacsr(keytok) 0
      set wizDatacert(keytok) 0
      return
    }
  }
  array set opts [array get profile_options]
  set a [string last "." $w ]
  set a [expr {$a - 1}]
  set f [string range $w 0 $a]

  #puts "keyParam f=$f"
  #puts "keyParam tpage =$tpage"
  #puts "keyParam key=$key"
  set listBits {}
  $f.c4 delete 0 end
  set key1 [$f.c3 get]

  if {$tpage == "csr" && $keytok == 1} {
    set llmech [pki::pkcs11::listmechs $::handle $::slotid_tek]
    #puts "key=$key1"
    #puts  "MECH=$llmech"
    set err -1
    switch -- $key1 {
      gost2012_256 {
        set err [string first "0x1200" $llmech]
        if {$err != -1 } {
          set err [string first "0xD4321012" $llmech]
        }
      }
      gost2012_512 {
        set err [string first "0xD4321005" $llmech]
      }	
      default {
        set err -1
      }
    }
    if {$err == -1} {
      tk_messageBox -title "Ключевая пара" -message "" -detail "$::tokeninfo\n[mc {Unsupported key type for certificate request}]\n\t$key1" -icon error  -parent $w
      return
    }
  }

  $f.c4 configure -state normal
  $f.c4 delete 0 end
  if {$key1 == "gost2012_512"} {
    set listBits {1.2.643.7.1.2.1.2.1 1.2.643.7.1.2.1.2.2 1.2.643.7.1.2.1.2.3}
    if {[lsearch $listBits $defaultpar] == -1 } {
      set defaultpar [lindex $listBits 1]
    }
    $f.c4 insert end $defaultpar
  } elseif {$key1 == "gost2012_256"} {
    set listBits {1.2.643.2.2.35.1 1.2.643.2.2.35.2  1.2.643.2.2.35.3  1.2.643.2.2.36.0 1.2.643.2.2.36.1 1.2.643.7.1.2.1.1.1 1.2.643.7.1.2.1.1.2 1.2.643.7.1.2.1.1.3 1.2.643.7.1.2.1.1.4}
    if {[lsearch $listBits $defaultpar] == -1 } {
      if {$key1 == "gost2012_256"} {
        set defaultpar [lindex $listBits 3]
      } else {
        set defaultpar [lindex $listBits 0]
      }
    }
    $f.c4 insert end $defaultpar
  } else {
    set listBits {A B C XA XB}
    $f.c4 insert 0 A
    set defaultpar ""
  }
  set defaultkey $key1
  $f.c4 configure -values $listBits
  $f.c4 configure -state readonly
}

proc doneGet {token} {
  #    puts "doneGet"
  set res1 ""
  switch -- [http::status $token] {
    error {
      puts "ERROR: [http::error $token]"
    }
    eof {
      puts "EOF reading response"
    }
    ok {
      puts "OK; code: [http::ncode $token]"
      puts " Size: [http::size $token]"
      puts " Data:"
      #               puts [http::data $token]
      set res [http::data $token]
    }
  }
  http::cleanup $token
  return $res
}

proc ::create_tsq {content oidhash} {
  #Проверяем хэш контента
  switch -- $oidhash {
    "1.2.643.7.1.1.2.2" - "1 2 643 7 1 1 2 2" {
      #    "GOST R 34.11-2012-256"
      set digest_algo "stribog256"
      set digest_len 32
    }
    "1.2.643.7.1.1.2.3" - "1 2 643 7 1 1 2 3" {
      #     "GOST R 34.11-2012-512"
      set digest_algo "stribog512"
      set digest_len 64
    }
    default {
puts "::create_tsq BAD Digest=$oidhash"
      return ""
    }
  }
#  set digest_hex    [pki::pkcs11::dgst $digest_algo $content ]
 #    puts "TST=$digest_hex"
#  set digest_bin [binary format H* $digest_hex]
  set digest_bin [lcc_gost3411_2012 $digest_len $content]

  set tsq [::asn::asnSequence \
  [::asn::asnInteger 1] \
  [::asn::asnSequence \
  [::asn::asnSequence [::asn::asnObjectIdentifier $oidhash] \
  ] \
  [::asn::asnOctetString $digest_bin] \
  ] \
  [::asn::asnBoolean true] \
  ]
  return $tsq
  #true - включить сертификат подписанта
  #		    [::asn::asnNull]
}

proc parse_crl {crl_der} {
  ::asn::asnGetSequence crl_der crl_seq
  ::asn::asnGetSequence crl_seq crl_base
  ::asn::asnPeekByte crl_base peek_tag
  if {$peek_tag == 0x02} {
    # Version number is optional, if missing assumed to be value of 0
    ::asn::asnGetInteger crl_base ret(version)
    incr ret(version)
  } else {
    set ret(version) 1
  }

  ::asn::asnGetSequence crl_base crl_full
  ::asn::asnGetObjectIdentifier crl_full ret(signtype)
  ::::asn::asnGetSequence crl_base crl_issue
  set ret(issue) [::pki::x509::_dn_to_string $crl_issue]
  binary scan $crl_issue H* ret(crl_issue_hex)
  set ret(crl_issue) [::pki::x509::_dn_to_string $crl_issue]

  ::asn::asnGetUTCTime crl_base ret(publishDate)
  return [array get ret]
}

proc parse_basic {basic_der} {
  ::asn::asnGetSequence basic_der crl_seq
  ::asn::asnGetSequence crl_seq crl_base
  ::asn::asnPeekByte crl_base peek_tag
  if {$peek_tag != 0xA1 && $peek_tag != 0xA2} {
    #0xA2 - infoteks
    puts "parse_basic Bad OCSP basic"
    return ""
  }
  set ret(typeocsp) [format {0x%2x} $peek_tag]
  ::asn::asnGetContext crl_base - bc
  binary scan $bc H* ret(ocsp_issue_hex)
  ::asn::asnGetGNTTime crl_base ret(ocspDate)
  return [array get ret]
}

proc loadocsp {urls reqoc} {
  #puts "loadocsp"
  foreach url $urls {
    set tt 0
    #Проверяем тип протокола
    if { "https://" == [string range $url 0 7]} {
      #      puts "HTTPS=$url"
      #      http::unregister https
      http::register https 443 ::tls::socket
      set tt 1
    }
    set res ""
    set token ""
    if {[catch {
      #puts "loadocsp=$url"
      if {$tt == 0} {
        set token [http::geturl $url  -type  "application/ocsp-request" -query  $reqoc]
        #      set token [http::geturl $url  -type  "application/ocsp-response" -query  $reqoc]
      } else {
        set token [http::geturl $url  -type  "application/ocsp-request" -query  $reqoc]
      }
      #	http::wait $token

    } error]} {
      puts stderr "Error while getting URL: $error"
      continue
    }
    #puts "GETURL END 3"
    #    puts [http::status $token]
    set res [doneGet $token]
    if {$res == "" } {
      continue
    }
    if {[catch { ::asn::asnGetSequence res res1 } ret] } {
      #	puts "BEDA=$res"
      tk_messageBox -title "Load OCSP" -icon info -message "Не могу получить OCSP-ответ\n$res" -detail "$ret" -parent .
      return ""
    }
    #    ::asn::asnGetSequence res res1
    set res [::asn::asnSequence $res1]
    #Читаем основной ответ
    ::asn::asnGetSequence res res1
    ::asn::asnGetEnumeration res1 succesfull
    if {$succesfull != 0} {
      puts "Error succesfull=$succesfull"
      continue
    }
    ::asn::asnGetContext res1 - resc0
    ::asn::asnGetSequence resc0 res3
    ::asn::asnGetObjectIdentifier res3 oiddata
    #puts "OIDDATA_OCSP=$oiddata"
    set oidobr  "1 3 6 1 5 5 7 48 1 1"
    #obr OCSP Basic Response
    if {$oiddata != $oidobr} {
      puts "Error oid=$oiddata"
      tk_messageBox -title "Load OCSP" -icon info -message "Плохой oid=$oiddate\n" -detail "OK=$oidobr" -parent .
      continue
    }
    ::asn::asnGetOctetString res3 derdata
    return $derdata
  }
  return ""
}


proc create_unsignattrs {certs_hex digest_algo} {
  variable createescTS
  variable chainca
  variable chaincerts
  set peekocsp1 ""
  #puts "create_unsignattrs=[llength $certs_hex]"
  set lchain ""
  set lchainref ""
  set lcrlref ""
  set lcrls ""
  set revokeRefs ""
  set digest_len 32
  set certValuesFull [binary format H* [lindex $certs_hex 0]]
  if {$digest_algo == "stribog256"} {
    set digest_oid "1 2 643 7 1 1 2 2"
    set digest_len 32
  } elseif {$digest_algo == "stribog512"} {
    set digest_oid "1 2 643 7 1 1 2 3"
    set digest_len 64
  } else {
    #Bad digest
    return -1
  }
  set ocsp 0
  set jj 0
  #Убрать
  set certtst1 [binary  format H* [lindex $certs_hex 1]]
  #Получаем все сертификаты в виде списка
  set chainca [list ]
  set listcafull [list ]
  #puts "CREAT_UNS_INCERT=[llength $certs_hex]"
  set n 0
  set chaincerts ""
  set ee 0
  foreach cert_hex $certs_hex {
    if {$cert_hex == "" } {
      break
    }
    if {$ee == 1 } {
      break
    } else {
      incr ee
    }
                	
    set chainca [list ]
    set cert [binary  format H* $cert_hex]
    append chaincerts $cert
    lappend listcafull $cert
    set listca1 [list ]
    set listca1 [chaincafromcert $cert]
    #puts "CREAT_UNS_LISTCA=[llength $listca1]"
    foreach certf $listca1 {
      set c 0
      set lcafull $listcafull
      foreach certa $lcafull {
        #puts "certf=[string length $certf]"
        #puts "certa=[string length $certa]"
        if {$certf == $certa} {
          #puts "set c 1"
          set c 1
          break
        }
      }
      #puts "set c=$c"
                            	
      if { $c == 0 } {
        lappend listcafull $certf
        append chaincerts $certf
      }
    }
  }
  #    puts "CREAT_UNS_ALLCERT=[llength $listcafull]"

  set lcrl ""
  #Цепочка сертификатов
  # ::oidcertValues             "1 2 840 113549 1 9 16 2 23"
  set chaincerts ""
  #	append certValuesFull $chaincerts

  #::revocationValues       "1 2 840 113549 1 9 16 2 24"
  #puts "revokREF"
  set revokValues [list ]
  set lrev [list ]
  set lcrl ""
  foreach certValue [reverse $listcafull] {
    if {$certtst1 == $certValue} {
      #puts "create_unsigner CERTTST"
      continue
    }
    #puts "create_unsign len_cert=[string length $certValue]"
    binary scan $certValue H* certhex
    foreach {caissuer servocsp} [ocspfromcert $certhex] {}
    #		puts "create_unsign caissuer=$caissuer"
    #		puts "create_unsign servocsp=$servocsp"
    if {[llength $servocsp ] > 0 } {
      #Работаем с ocsp
      #puts "create_unsign OCSP len_cert=[string length $certValue]"
      set ocsp 1
      set cert_ca [cafromlist $caissuer]
      binary scan $cert_ca H* cert_ca_hex
      set reqoc [create_req_ocsp $certhex $cert_ca_hex]
      set lcrlca [loadocsp $servocsp $reqoc]
      #Проблемы с OCSP-севрером
      if {$lcrlca == ""} {
        return -2
      }
      set basiccore $lcrlca
      #Выбираем сертификаты
      ::asn::asnGetSequence basiccore bc
      ::asn::asnGetSequence bc bc1
      ::asn::asnGetSequence bc bc2
      ::asn::asnGetObjectIdentifier bc2 oidbc
      ::asn::asnGetBitString bc bc3
      if {[string length $bc] > 0} {
        ::asn::asnPeekByte bc peek_tag
        if {$peek_tag == 0xA0} {
          #Сертификаты сервера OCSP
          ::asn::asnGetContext bc certsbc
          while {[string length $bc] > 0} {
            ::asn::asnGetSequence bc certbc
            ::asn::asnGetSequence certbc bc1
            set bc2 [::asn::asnSequence $bc1]
            set c 0
            set lcafull $listcafull
            foreach certa $lcafull {
              if {$bc2 == $certa} {
                set c 1
                break
              }
            }

            if { $c == 0 } {
              #################
              if {0} {
                array set crt_parse [pki::x509::parse_cert $bc2]
                array set extcert $crt_parse(extensions)
                if {[info exists extcert(2.5.29.37) ]} {
                  set listusage [extkeyuse [lindex $extcert(2.5.29.37) 1]]
                  set oc 0
                  set i 0
                  #		    for {set i 0 } { $i < [llength $listusage] } {incr i} {}
                  if {[llength $listusage] == 1} {
                    set oidt [string map {" " "."} [lindex $listusage $i]]
                    #puts "OIDT=$oidt"
                    if {"1.3.6.1.5.5.7.3.9" == $oidt} {
                      set oc 1
                    }
                  }
                  if {$oc == 0} {
                    lappend listcafull $bc2
                  }
                }
                }
              lappend listcafull $bc2
              ###############

              #puts "create_unsign BC len_cert=[string length $bc2]"
              }
            }
          }
        }

      #puts "create_unsignattrs=Whis OCSP=$oidbc"
      } else {
      set ocsp 0
      set lcrlca [loadcrl $certhex 1]
      #puts "create_unsignattrs=loadCRL 2"
      if { [string range $lcrlca 0 9 ] == "-----BEGIN" } {
        array set parsed_crl [::pki::_parse_pem $lcrlca "-----BEGIN X509 CRL-----" "-----END X509 CRL-----"]
        set lcrlca $parsed_crl(data)
      }
    }
    #puts "create_unsignattrs=loadCRL 2_1"
    if {$lcrlca != ""} {
      set y 0
      foreach rev $lrev {
        if {$rev == $lcrlca} {
          set y 1
          break
        }
      }
      if {$y == 1} {
        continue
      }
      lappend lrev $lcrlca
      set lcrlca1 [::asn::asnContextConstr $ocsp \
      [::asn::asnSequence \
      $lcrlca \
      ] \
      ]
      append lcrl $lcrlca1
      #ЭТО ПРОВЕРИТЬ
      lappend revokValues $lcrlca1
      if {$certtst1 == ""} {
        break
      }
    }
    }
  set lcrls $lcrl
  # ::oidrevocationRefs         "1 2 840 113549 1 9 16 2 22"
  #puts "revokREF1"
  foreach revokValue1 $revokValues {
    set peekocsp ""

    asn::asnPeekByte revokValue1 tag
    set ocsp 0
    if {$tag == 0xA1} {
      #			puts "Это OCSP"
      ::asn::asnGetContext revokValue1 -- revokValue2
      ::asn::asnGetSequence revokValue2 revokValue
      set ocsp 1
    } elseif {$tag == 0xA0} {
      #			puts "Это CRL"
      ::asn::asnGetContext revokValue1 -- revokValue2
      ::asn::asnGetSequence revokValue2 revokValue
      set ocsp 0
    } else {
      puts "Это не CRL и не OCSP=$tag"
      #Ошибка revokeValue
      return -3
    }

#    set digcrl_hex [::pki::pkcs11::dgst $digest_algo $revokValue]
#    set digcrl [binary format H* $digcrl_hex]
    set digcrl [lcc_gost3411_2012 $digest_len $revokValue]

    if {$ocsp == 0} {
      #		    puts "Это CRL 1"
      array set pcrl [parse_crl $revokValue]
      #parray pcrl
      set name [binary format H* $pcrl(crl_issue_hex)]
      set revokeRef [asn::asnSequence \
      [::asn::asnSequence \
      [::asn::asnSequence \
      [::asn::asnObjectIdentifier $digest_oid] \
      ] \
      [::asn::asnOctetString $digcrl] \
      ] \
      [::asn::asnSequence \
      [::asn::asnSequence \
      $name \
      ] \
      [::asn::asnUTCTime $pcrl(publishDate)] \
      ] \
      ]
    } else {
      array set pocsp [parse_basic $revokValue]
      	puts "Это OCSP typeocsp=$pocsp(typeocsp)"
      #parray pocsp
      set name [binary format H* $pocsp(ocsp_issue_hex)]
      set peekocsp $pocsp(typeocsp)
      set typeocsp $ocsp
      if {$pocsp(typeocsp) == "0xa2"} {
        #"0xa"2 - infoteks
        set peekocsp1 $pocsp(typeocsp)
        set typeocsp 2
      }
      set revokeRef [asn::asnSequence \
      [::asn::asnSequence \
      [::asn::asnContextConstr $typeocsp \
      $name \
      ] \
      [::asn::asnGNTTime $pocsp(ocspDate)] \
      ] \
      [::asn::asnSequence \
      [::asn::asnSequence \
      [::asn::asnObjectIdentifier $digest_oid] \
      ] \
      [::asn::asnOctetString $digcrl] \
      ] \
      ]
    }
    if {$peekocsp != "0xa2"} {
      set revokeR [::asn::asnSequence \
      [::asn::asnContextConstr $ocsp \
      [::asn::asnSequence \
      [::asn::asnSequence \
      $revokeRef \
      ] \
      ] \
      ] \
      ]
      append revokeRefs $revokeR

    } else {
      set revokeR [::asn::asnContextConstr $ocsp \
      [::asn::asnSequence \
      [::asn::asnSequence \
      $revokeRef \
      ] \
      ] \
      ]
      asn::asnGetSequence revokeRefs rrr
      append rrr $revokeR
      set revokeRefs [asn::asnSequence  $rrr]
    }
    #      append revokeRefs $revokeR
  }

  #Ссылка на сертификат подписанта не нужна?
  # ::oidCertificateRefs        "1 2 840 113549 1 9 16 2 21"
  foreach certValue $listcafull {
    if {$jj == 0} {
      incr jj
      continue
    }
    binary scan $certValue H* cert_hex
#    set digcert_hex [::pki::pkcs11::dgst $digest_algo $certValue]
#    set digcert [binary format H* $digcert_hex]
    set digcert [lcc_gost3411_2012 $digest_len $certValue]
#    array set infopk [pki::pkcs11::pubkeyinfo $cert_hex ]
#    set name [binary format H* $infopk(issuer)]
    set cert_der [binary format H* $cert_hex]
    array set pc1 [pki::x509::parse_cert $cert_der]
    set name [binary format H* $pc1(issuer_hex)]
#    set infopk(serial_number) [binary format H* $pc1(serial_number_hex)]
    set infopk(serial_number) $pc1(serial_number_hex)
    set certref [::asn::asnSequence \
    [::asn::asnSequence \
    [::asn::asnSequence \
    [::asn::asnObjectIdentifier $digest_oid] \
    ] \
    [::asn::asnOctetString $digcert] \
    ] \
    [::asn::asnSequence \
    [::asn::asnSequence \
    [::asn::asnContextConstr 4 \
    $name \
    ] \
    ] \
    [binary format H* $infopk(serial_number)] \
    ] \
    ]
    append lchainref $certref
  }

  # ::oidcertValues             "1 2 840 113549 1 9 16 2 23"
  set certValuesFull ""
  set zz 0
  foreach cert $listcafull {
    if {$zz == 0 } {
      incr zz
      continue
    }
    append certValuesFull $cert
  }
  append certValuesFull [lindex $listcafull 0]
        	
  set lchain [::asn::asnSequence \
  [::asn::asnObjectIdentifier $::oidcertValues] \
  [::asn::asnSet \
  [::asn::asnSequence $certValuesFull]
  ] \
  ]

  # ::oidCertificateRefs        "1 2 840 113549 1 9 16 2 21"
  set lchainref [::asn::asnSequence \
  [::asn::asnObjectIdentifier $::oidCertificateRefs] \
  [::asn::asnSet \
  [::asn::asnSequence $lchainref]
  ] \
  ]


  #::revocationValues       "1 2 840 113549 1 9 16 2 24"
  if {$createescTS == 2} {
    set lcrl [::asn::asnSequence \
    [::asn::asnObjectIdentifier $::revocationValues] \
    [::asn::asnSet \
    [::asn::asnSequence \
    $lcrl \
    ] \
    ] \
    ]

    # ::oidrevocationRefs         "1 2 840 113549 1 9 16 2 22"
    set lcrlref [::asn::asnSequence \
    [::asn::asnObjectIdentifier $::oidrevocationRefs] \
    [::asn::asnSet \
    [::asn::asnSequence \
    $revokeRefs \
    ] \
    ] \
    ]

  } else {
    set lcrl ""
    set lcrlref ""
  }

  return [list $lchain $lchainref $lcrl $lcrlref]
  }


proc ::pkcs7_create_signeddata {content certs_hex typesign file_for_sign typekey} {
  set lcerts ""
  set listdigest ""
  set listsigner ""
  foreach cert_hex $certs_hex {
    set cert [binary  format H* $cert_hex]
    append lcerts $cert
    array set addsigner [create_new_signer $cert_hex $content $typekey]
    if {![info exists addsigner(listdigest)]} {
      #Что-то плохо с добавлением
      tk_messageBox -title "Подписание документа" -icon error -message [mc "Cannot add signer (digest)"]
      #      puts "Cannot add signer (digest)"
      return 0
    }
    if {![info exists addsigner(listsigner)]} {
      #Что-то плохо с добавлением
      tk_messageBox -title "Подписание документа" -icon error -message [mc "Cannot add signer (signer)"]
      #      puts "Cannot add signer (signer)"
      return 0
    }
    append listsigner $addsigner(listsigner)
    append listdigest $addsigner(listdigest)
  }

  if {$typesign == 0} {
    set context_for_sing [::asn::asnObjectIdentifier $::oidData]
  } else {
    set context_for_sing1 [::asn::asnObjectIdentifier $::oidData]
    set context_for_sing2     [::asn::asnContextConstr 0 \
    [::asn::asnOctetString $content] \
    ]
    set context_for_sing "$context_for_sing1$context_for_sing2"
  }

  set p7_signed [::asn::asnSequence \
  [::asn::asnObjectIdentifier $::oidSignedData] \
  [::asn::asnContextConstr 0 \
  [::asn::asnSequence \
  [::asn::asnInteger 1] \
  [::asn::asnSet $listdigest] \
  [::asn::asnSequence $context_for_sing] \
  [::asn::asnContextConstr 0 $lcerts] \
  [::asn::asnSet $listsigner] \
  ] \
  ] \
  ]

  set fd [open $file_for_sign w]
  chan configure $fd -translation binary
  puts -nonewline $fd $p7_signed
  close $fd
  #puts $cert
  return 1
}

proc validaty_cert_from_crl {crl sernum issuer} {
  #puts "SERN=$sernum"
  array set ret [list]
  if { [string range $crl 0 9 ] == "-----BEGIN" } {
    array set parsed_crl [::pki::_parse_pem $crl "-----BEGIN X509 CRL-----" "-----END X509 CRL-----"]
    set crl $parsed_crl(data)
  }
  ::asn::asnGetSequence crl crl_seq
  ::asn::asnGetSequence crl_seq crl_base
  ::asn::asnPeekByte crl_base peek_tag
  if {$peek_tag == 0x02} {
    # Version number is optional, if missing assumed to be value of 0
    ::asn::asnGetInteger crl_base ret(version)
    incr ret(version)
  } else {
    set ret(version) 1
  }

  ::asn::asnGetSequence crl_base crl_full
  ::asn::asnGetObjectIdentifier crl_full ret(signtype)
  ::::asn::asnGetSequence crl_base crl_issue
  set ret(issue) [::pki::x509::_dn_to_string $crl_issue]
  if {$ret(issue) != $issuer } {
    set ret(error) "Bad Issuer"
    return [array get ret]
  }
  binary scan  $crl_issue H*  ret(issue_hex)
  ::asn::asnGetUTCTime crl_base ret(publishDate)
  ::asn::asnGetUTCTime crl_base ret(nextDate)
  #puts "publishDate=$ret(publishDate)"
  #Список сертификатов отозванных
  ::asn::asnPeekByte crl_base peek_tag
  if {$peek_tag != 0x30} {
    #Список сертификатов отозванных пустой
    return [array get ret]
  }

  ::asn::asnGetSequence crl_base lcert
  while {$lcert != ""} {
    ::asn::asnGetSequence lcert lcerti
    #Разбираем i-й сертификат
    ::asn::asnGetBigInteger lcerti ret(sernumrev)
    set ret(sernumrev) [::math::bignum::tostr $ret(sernumrev)]
    #puts "$sernum $ret(sernumrev)"
    if {$ret(sernumrev) != $sernum} {
      continue
    }
    ::asn::asnGetUTCTime lcerti ret(revokeDate)
    if {$lcerti == ""} {
      puts "NO reasone"
    } else {
      ::asn::asnGetSequence lcerti lcertir
      ::asn::asnGetSequence lcertir reasone
      ::asn::asnGetObjectIdentifier reasone ret(reasone)
      ::asn::asnGetOctetString reasone reasone2
      ::asn::asnGetEnumeration reasone2 ret(reasoneData)
    }
    break;	
  }
  return [array get ret]
}


proc loadcrl {cert_hex type} {
  global typesys
  global macos
  #type 1 - вернуть CRL
  global count
  global loadfile
  global myHOME
  if {$cert_hex == "" } {
    return
  }
  set cert [binary format H* $cert_hex]
  #    set valid [cert_valid_date]
  #    puts "VALID=$valid"
  #    if {[lindex $valid 0] == 0} {
  #	set ms [mc [lindex $valid 1]]
  #        set answer [tk_messageBox -icon question \
  #                -message "$ms.\n[mc Continue]?" \
  #                -title [mc "Load CRL"] \
  #                -type yesno]
  #        if {$answer != "yes"} {
  #    	    return
  #        }
  #    }
  array set cert_parse [::pki::x509::parse_cert $cert]
  array set extcert $cert_parse(extensions)
  #parray cert_parse
  #parray extcert
  set listcrl ""
  if {[info exists extcert(2.5.29.31)]} {
    set listcrl [crlpoints [lindex $extcert(2.5.29.31) 1]]
    set listcrl  $listcrl
    unset extcert(2.5.29.31)
  }
  #puts "listcrl=$listcrl"
  #CRL для подписи
  if {$type == 1} {
    set filecrl ""
    set pointcrl ""
    foreach pointcrl $listcrl {
      set filecrl [readca $pointcrl]
      if {$filecrl != ""} {
        #puts "listcrl point=$pointcrl"
        break
      }
      #Прочитать CRL не удалось. Берем следующую точку с CRL
    }
    return $filecrl
  }


  if {$listcrl == "" } {
    if {$cert_parse(issuer) == $cert_parse(subject)} {
      set ms [mc "This is a root self-signed certificate"]
      set dt [mc "The validity of a self-signed certificate is determined by the owner"]
      tk_messageBox -title [mc "Load chain CA"] -icon info -message $ms -detail $dt
      return
    }
    set message "[mc {Cannot load CRL}]\n[mc {You specify the file with the CRL}]?"
    set answer [tk_messageBox -icon question \
    -message $message \
    -title [mc "Load CRL"] \
    -detail [mc "Unable to verify certificate validity"] \
    -type yesno]

    if {$answer != "yes"} {
      return
    }
    set typeFile {
      {"CRL"    .crl}
      {"DER-формат]"    .cer}
      {"PEM-формат"    .pem}
      {"Любой тип"    *}
    }
    #	set typeFile [subst $typeFile]
    set titleS "Выберите файл с CRL"
    if {$macos} {
      set ft ""
    } else {
      set ft $typeFile
    }

    set filecrl [tk_getOpenFile -title $titleS -filetypes $ft -initialdir "$myHOME"]
    if {$filecrl == ""} {
      return
    }
    set f [open $filecrl r]
    chan configure $f -translation binary
    set crl [read $f]
    close $f

    array set valcert [validaty_cert_from_crl $crl $cert_parse(serial_number) $cert_parse(issuer)]
    if {[info exists valcert(error)]} {
      tk_messageBox -title [mc "Load CRL"] -icon info -message "[mc {CRL from auther published}]\n$filecrl" -detail $valcert(issue)
      return
    }
    if {![info exists valcert(revokeDate)]} {
      #Сертификат не отозван
      set valc "[mc {Certificate valid}] \(N=$cert_parse(serial_number)\)"
    } else {
      set t [string trimright $valcert(revokeDate) "Z"]
      set year "20[string range $t 0 1]"
      set month [string range $t 2 3]
      set day [string range $t 4 5]
      set hour [string range $t 6 7]
      set minute [string range $t 8 9]
      set second [string range $t 10 11]
      #	puts  "$day $month $year $hour $minute"
      set revdate "$day/$month/$year $hour:$minute:$second"
      set valc "[mc {Certificate revoked}] \(N=$valcert(sernumrev)\): $revdate"
    }
    set t [string trimright $valcert(publishDate) "Z"]
    set year "20[string range $t 0 1]"
    set month [string range $t 2 3]
    set day [string range $t 4 5]
    set hour [string range $t 6 7]
    set minute [string range $t 8 9]
    set second [string range $t 10 11]
    set publishdate "$day/$month/$year $hour:$minute:$second"
    set t [string trimright $valcert(nextDate) "Z"]
    set year "20[string range $t 0 1]"
    set month [string range $t 2 3]
    set day [string range $t 4 5]
    set hour [string range $t 6 7]
    set minute [string range $t 8 9]
    set second [string range $t 10 11]
    set nextdate "$day/$month/$year $hour:$minute:$second"

    set valc "$valc\n[mc {CRL release date}]: $publishdate\n[mc {Next CRL issue date}]: $nextdate"
    tk_messageBox -title [mc "Load CRL"] -icon info -message "[mc {Load CRL from}]\n$filecrl" -detail $valc
    return
    }
  set dir [tk_chooseDirectory -initialdir $myHOME -title [mc "Select a directory to save the CRL"]]
  if {$typesys == "win32" } {
    if { "after#" == [string range $dir 0 5] } {
      set dir ""
    }
  }
  if {$dir == ""} {
    return
  }
  set filecrl ""
  set pointcrl ""
  foreach pointcrl $listcrl {
    set filecrl [readca $pointcrl]
    if {$filecrl != ""} {
      set f [file join $dir [file tail $pointcrl]]
      set fd [open $f w]
      chan configure $fd -translation binary
      puts -nonewline $fd $filecrl
      close $fd
      set filecrl $f
      break
    }
    #Прочитать CRL не удалось. Берем следующую точку с CRL
  }
  if {$filecrl == ""} {
    set message "[mc {Cannot load CRL}]\n[mc {You specify the file with the CRL}]"
    set answer [tk_messageBox -icon question \
    -message $message \
    -title [mc "Load CRL"] \
    -detail [mc "Unable to verify certificate validity"] \
    -type yesno]

    if {$answer != "yes"} {
      return
    }
    set typeFile {
      {"CRL"    .crl}
      {"DER-формат"    .cer}
      {"PEM-формат"    .pem}
      {"Любой тип"    *}
    }
    set titleS "Выберите файл с CRL"
    if {$macos} {
      set ft ""
    } else {
      set ft $typeFile
    }

    set filecrl [tk_getOpenFile -title $titleS -filetypes $ft -initialdir "$myHOME"]
    if {$filecrl == ""} {
      return
    }
    #	tk_messageBox -title [mc "Load CRL"] -icon error -message [mc "Cannot load CRL"] -detail [mc "Unable to verify certificate validity"]
    #	return
  }

  set ss "[mc {File with CRL}]:\n$filecrl"
  set f [open $filecrl r]
  chan configure $f -translation binary
  set crl [read $f]
  close $f

  #set cert_parse(serial_number) 4604
  #Отозванный сертификат ekey
  #set cert_parse(serial_number) 330
  array set valcert [validaty_cert_from_crl $crl $cert_parse(serial_number) $cert_parse(issuer)]
  if {[info exists valcert(error)]} {
    tk_messageBox -title [mc "Load CRL"] -icon info -message "[mc {CRL from auther published}]\n$filecrl" -detail $valcert(issue)
    return
  }
  #    parray valcert
  set revdate ""
  if {![info exists valcert(revokeDate)]} {
    #Сертификат не отозван
    set valc "[mc {Certificate valid}] \(N=$cert_parse(serial_number)\)"
  } else {
    set t [string trimright $valcert(revokeDate) "Z"]
    set year "20[string range $t 0 1]"
    set month [string range $t 2 3]
    set day [string range $t 4 5]
    set hour [string range $t 6 7]
    set minute [string range $t 8 9]
    set second [string range $t 10 11]
    #	puts  "$day $month $year $hour $minute"
    set revdate "$day/$month/$year $hour:$minute:$second"
    set valc "[mc {Certificate revoked}] \(N=$valcert(sernumrev)\): $revdate"
    if {[info exists valcert(reasone)]} {
      set valc "$valc\n[mc {Revocation reason code}]: $valcert(reasoneData)"
    }
  }
  set t [string trimright $valcert(publishDate) "Z"]
  set year "20[string range $t 0 1]"
  set month [string range $t 2 3]
  set day [string range $t 4 5]
  set hour [string range $t 6 7]
  set minute [string range $t 8 9]
  set second [string range $t 10 11]
  set publishdate "$day/$month/$year $hour:$minute:$second"
  set t [string trimright $valcert(nextDate) "Z"]
  set year "20[string range $t 0 1]"
  set month [string range $t 2 3]
  set day [string range $t 4 5]
  set hour [string range $t 6 7]
  set minute [string range $t 8 9]
  set second [string range $t 10 11]
  set nextdate "$day/$month/$year $hour:$minute:$second"

  set valc "$valc\n[mc {CRL release date}]: $publishdate\n[mc {Next CRL issue date}]: $nextdate"
  tk_messageBox -title [mc "Load CRL"] -icon info -message "[mc {Load CRL from}]\n$pointcrl \n$ss" -detail $valc
}




proc ::parse_pkcs7 {type p7file sfile} {
  #puts "START parse_pkcs7=$type"
  variable typesig
  if {$type == "file"} {
    #puts "parse_pkcs7=$p7file, sfile=$sfile"
    set fd [open $p7file]
    chan configure $fd -translation binary
    set p7 [read $fd]
    close $fd
    if {$p7 == "" } {
      puts "Bad file with p7=$p7file"
      return -3
    }
    set p7_seq ""
    if { [string range $p7 0 9 ] == "-----BEGIN" } {
      set p7_1 [string map {"\r\n" "\n"} $p7]
      array set parsed_p7 [::pki::_parse_pem $p7_1 "-----BEGIN PKCS7-----" "-----END PKCS7-----"]
      set p7_seq $parsed_p7(data)
    } else {
      #FORMAT DER
      if {[string range $p7 0 0] != "0"} {
        return -2
      }
      set p7_seq $p7
    }
  } elseif {$type == "der" } {
    set p7_seq $p7file
    if {$p7_seq == "" } {
      puts "Bad pkcs7=NULL"
      return -3
    }
  } else {
    puts "Bad type=$type"
    return -3
  }
  #Файл p7s der в hex-е
  binary scan $p7_seq  H* p7s_hex

  array set ret [list]
  asn::asnGetSequence p7_seq pkcs7
  ::asn::asnGetObjectIdentifier pkcs7 oidpkcs7
  if {$oidpkcs7 != "1 2 840 113549 1 7 2" && $oidpkcs7 != "1.2.840.113549.1.7.2"} {
    puts "oid != \"1.2.840.113549.1.7.2\"\n$oidpkcs7"
    return ""
  }

  #puts $oidpkcs7

  ::asn::asnGetContext pkcs7 - asn_cont
  asn::asnGetSequence asn_cont asn_cont1
  ::asn::asnPeekByte asn_cont1 peek_tag
  if {$peek_tag == 0x02} {
    # Version number is optional, if missing assumed to be value of 0
    ::asn::asnGetInteger asn_cont1 ret(version)
    #puts "VAR=$ret(version)"		
  } else {
    set ret(version) 1
    #puts "def VAR=$ret(version)"		
  }
  asn::asnGetSet asn_cont1 asn_cont2
  #p7b
  if {[string length $asn_cont2] > 0} {

    asn::asnGetSequence asn_cont2 asn_cont3
    ::asn::asnGetObjectIdentifier asn_cont3 oidhash
    #puts "OIDHASH=$oidhash"
    asn::asnGetSequence asn_cont1 asn_cont4
    ::asn::asnGetObjectIdentifier asn_cont4 oiddata
    #puts "OIDDATA=$oiddata"
    if {[string length $asn_cont4] > 0 } {
      set ret(attached) 1

      ::asn::asnGetContext asn_cont4 - octcontext
      ##############
      ::asn::asnPeekByte octcontext peek_tag
      ::asn::asnPeekByte octcontext peek_tag1 1
      if {$peek_tag == 0x24 && $peek_tag1 == 0x80} {
        set contextVar1 $octcontext
        ::asn::asnGet24OctetString contextVar1 octcontext
        #		puts "p7dParse=0x240x80"
      }
      #################

      ::asn::asnGetOctetString octcontext context
      binary scan $context  H* ret(context_hex)
      #	set context_hex [edithex $ret(context_hex)]
      #	set lll [string length $context]
      #	puts "attached signature, len context=$lll "

    } else {
      #	puts "detached signature"
      set ret(attached) 0
      set context ""
      if {$sfile != ""} {
        if {![file exists $sfile]} {
          puts "Content File $sfile not exist"
          set ret(context_hex) ""
        } else {
          #		puts "Loading content file: $sfile"
          set fd [open $sfile]
          chan configure $fd -translation binary
          set data [read $fd]
          close $fd
          if {$data == "" } {
            puts "Bad file with certificate=$file"
            set ret(context_hex) ""
            set context $data
          } else {
            set context $data
            binary scan $context  H* ret(context_hex)
          }
        }
      }
    }
    #Проверяем хэш контента
    switch -- $oidhash {
      "1.2.643.7.1.1.2.2" - "1 2 643 7 1 1 2 2" {
        #    "GOST R 34.11-2012-256"
        set digest_algo "stribog256"
        set digest_len 32
      }
      "1.2.643.7.1.1.2.3" - "1 2 643 7 1 1 2 3" {
        #     "GOST R 34.11-2012-512"
        set digest_algo "stribog512"
        set digest_len 64
      }
      "1.2.643.2.2.9" - "1 2 643 2 2 9" {
        #    "GOST R 34.10-2001 with GOST R 34.11-94"
        set digest_algo "gostr3411"
      }
      default {
        puts "Cannot veridy content\nUnknown digestalgo=$oidhash"
        #		return -1
      }
    }
    set aa [dict create pkcs11_handle $::handle pkcs11_slotid $::slotid_tek]
    if {$context != ""} {
	set digest_mes_bin [lcc_gost3411_2012 $digest_len $context]
	binary scan $digest_mes_bin H* digest_mes_hex
    } else {
      set digest_mes_hex ""
    }
    #p7b
  } else {
    #puts "YES P7B"
    asn::asnGetSequence asn_cont1 p7data
    ::asn::asnGetObjectIdentifier p7data oiddata
    #puts "OIDDATA_P7B=$oiddata"
  }

  set i 0
  ::asn::asnPeekByte asn_cont1 peek_tag
  set lcerts [list]
  if {$peek_tag == 0xA0} {
    ::asn::asnGetContext asn_cont1 - listcert
    while {[string length $listcert] > 0 } {
      asn::asnGetSequence listcert cert
      set cert [asn::asnSequence $cert]
      binary scan $cert  H* cert_hex
      lappend lcerts  $cert_hex
      incr i
    }
  }
  #puts "LCERTS=$lcerts"
  ::asn::asnPeekByte asn_cont1 peek_tag
  set lcrls [list]
  if {$peek_tag == 0xA1} {
    ::asn::asnGetContext asn_cont1 - listcrl
    while {[string length $listcrl] > 0 } {
      asn::asnGetSequence listcrl crl
      set crl [asn::asnSequence $crl]
      lappend lcrls [::pki::_encode_pem $crl "-----BEGIN CRL-----" "-----END CRL-----"]
      incr i
    }
  }
  #puts "LCRLS=$lcrls"

  asn::asnGetSet asn_cont1 signerinfos
  set i1 0

  set linfos {}
  while {[string length $signerinfos] > 0 } {

    asn::asnGetSequence signerinfos signerinfo
    ::asn::asnGetInteger signerinfo ret(versigninfo)
    #puts "ret(versigninfo)=$ret(versigninfo)"		
    asn::asnGetSequence signerinfo sid
    asn::asnGetSequence sid	name
    set ret(issuer_str) [::pki::x509::_dn_to_string $name]
    set name [asn::asnSequence $name]
    binary scan $name  H* ret(issuer)
    ::asn::asnGetBigInteger sid ret(serial_number_dec)
    set ret(serial_number) [asn::asnBigInteger $ret(serial_number_dec)]
    binary scan $ret(serial_number)  H* ret(serial_number)
    #Добавляем nick для сертификата CN_Subject from CN_issuer
    set yescert 0
    foreach cert $lcerts {
      #puts "CERT=$cert"
#      array set infopk [pki::pkcs11::pubkeyinfo $cert ]
      set cert_bin [binary  format H* $cert]
      array set infopk [pki::x509::parse_cert $cert_bin]
      #		parray infopk

      
      if {$infopk(issuer_hex) == $ret(issuer) && $infopk(serial_number_hex) == $ret(serial_number)} {
        set yescert 1
        set ret(cert_hex) $cert
        break
      }
    }
    if {$yescert != 1} {
#      puts "Not found certificate"
#      puts "issuer=$ret(issuer_str)\nSN=$ret(serial_number_dec)"
      set ret(nickcert) ""
      set ret(cert_hex) ""
    } else {
      #		puts "Found certificate"
      #		puts "issuer=$ret(issuer_str)\nSN=$ret(serial_number_dec)"
#      set subject [binary format H* $infopk(subject)]
      set subject [binary format H* $infopk(subject_hex)]
      ::asn::asnGetSequence subject sub1
      set subject_str [pki::x509::_dn_to_string $sub1]
      #		puts "subject=$subject_str\nSN=$ret(serial_number_dec)"
      set ret(nickcert) [createnick $ret(issuer_str) $subject_str]
      #		puts "ret(nickcert)=$ret(nickcert)"
    }

    asn::asnGetSequence signerinfo digestalgo
    ::asn::asnGetObjectIdentifier digestalgo oiddigestalgo
    #puts "ISSUER=$ret(issuer)"
    #puts "SERIAL_NUMBER=[lindex $ret(serial_number) 2]"
    #puts "OIDDIGESTALGO=$oiddigestalgo"
    set ret(digestalgo) $oiddigestalgo
    ::asn::asnPeekByte signerinfo peek_tag
    if {$peek_tag == 0xA0} {
      #Для подсчета хэша 0xA0 надо заменить на 0x31 в 0-ой позиции

      ::asn::asnGetContext signerinfo - signedattrs
      #!!!!
      set signerinfoMy [::asn::asnContext 0 $signedattrs]
      binary scan $signerinfoMy  H* ret(signerinfo)

      set i2 0
      while {$signedattrs != ""} {
        asn::asnGetSequence signedattrs signedattr
        ::asn::asnGetObjectIdentifier signedattr oidtypeattr
        # ESS signing-certificate-v2
        switch -- $oidtypeattr {
          "1 2 840 113549 1 9 3" {
            asn::asnGetSet signedattr typedate
            ::asn::asnGetObjectIdentifier typedate oidtypedate
            #puts "oidtypedate=$oidtypedate"
          }
          "1 2 840 113549 1 9 4" {
            asn::asnGetSet signedattr messagedigest
            ::asn::asnGetOctetString messagedigest messagedigest
            binary scan $messagedigest  H* ret(messageDigest)
            set ret(messageDigestTek) $digest_mes_hex
            #puts "messageDigest=$ret(messageDigest)"
            #puts "digest_mes_hex=$digest_mes_hex"
          }
          "1 2 840 113549 1 9 5" {
            asn::asnGetSet signedattr signedtime
            binary scan $signedtime  H* ret(signedtime_derhex)
            ::asn::asnGetUTCTime signedtime ret(signedTime)
            #puts "ret(signedTine)=$ret(signedTime)"
          }
          "1 2 840 113549 1 9 16 2 47" {
            asn::asnGetSet signedattr signedcertv2
            binary scan $signedcertv2  H* ret(signedtcertv2)
            #puts "signedtcertv2=$ret(signedtcertv2)"

          }
          "1 2 840 113549 1 9 16 2 12" {
            asn::asnGetSet signedattr signingCertificate
            binary scan $signingCertificate  H* ret(signingCertificate)
            #puts "signingCertificate=$ret(signingCertificate)"

          }

          default {
            puts "DEFAULT signer oidtypeattr=$oidtypeattr"
            asn::asnGetSet signedattr signeddefault
            binary scan $signeddefault  H* ret(signeddefault)
            #puts "DEFAULT Value=$ret(signeddefault)"
          }
        }
        #puts "oidtypeattr=$oidtypeattr"
        incr i2
      }
      #puts "I2=$i2"
                        	
    }
    asn::asnGetSequence signerinfo signaturealgo
    ::asn::asnGetObjectIdentifier signaturealgo oidsignaturealgo
    #puts "OIDSignatureALGO=$oidsignaturealgo"
    ::asn::asnGetOctetString signerinfo ret(signature)
    binary scan $ret(signature)  H* ret(signature)
    #puts "Signature=$ret(signature)"
    incr i1
    set ret(esctimeStamp) 0
    set ret(timeStamp) 0
    if {[string length $signerinfo] == 0} {
      lappend linfos [array get ret]
      continue
    }
    ::asn::asnPeekByte signerinfo peek_tag

    if {$peek_tag == 0xA1} {
      ::asn::asnGetContext signerinfo - unsignedattrs
      #puts "unsignedattrs"
      set i3 0
      while {$unsignedattrs != ""} {
        asn::asnGetSequence unsignedattrs signedattr
        set signedattr2save $signedattr
        ::asn::asnGetObjectIdentifier signedattr oidtypeattr
        switch -- $oidtypeattr {
          "1 2 840 113549 1 9 16 2 14" {
            #puts "id-aa-timeStampToken=$oidtypeattr"
            set ret(tst_der) $signedattr2save
            asn::asnGetSet signedattr timestamp
            binary scan $timestamp  H* ret(p7timestamp_hex)
            set  ret(timeStamp) 1
            set tst [parse_pkcs7 "der" "$timestamp" ""]
            foreach {tstcert tstcrls tstp7} $tst {}
            foreach tstp7t $tstp7 {
              #puts "P7=$p7t"
              array set tp7 $tstp7t
              set ret(tstdigest) $tp7(digestalgo)
              set ret(tstinfo) $tp7(context_hex)
              #puts "TST"
              #parray tp7
            }

          }
          "1 2 840 113549 1 9 16 2 21" {
            #puts "id-aa-ets-CertificateRefs=$oidtypeattr"
            set ret(certRefs_der) $signedattr2save
          }
          "1 2 840 113549 1 9 16 2 22" {
            #puts "id-aa-ets-revocationRefs=$oidtypeattr"
            set ret(revokeRefs_der) $signedattr2save
          }
          "1 2 840 113549 1 9 16 2 23" {
            #puts "id-aa-ets-certValues=$oidtypeattr"
            asn::asnGetSet signedattr certValues
            set i4 0
            asn::asnGetSequence certValues certValues1
            while {$certValues1 != ""} {
              asn::asnGetSequence certValues1 certValue
              set certValue [asn::asnSequence $certValue]
              binary scan $certValue  H* cert_hex
              lappend lcerts  $cert_hex
              incr i4
              #timeStampToken
              set yescert 0
              #		array set infopk [pki::pkcs11::pubkeyinfo $cert_hex  [list pkcs11_handle $::handle pkcs11_slotid $::slotid_tek]]
#              array set infopk [pki::pkcs11::pubkeyinfo $cert_hex ]
    	      set cert_bin [binary  format H* $cert_hex]
    	      array set infopk [pki::x509::parse_cert $cert_bin]
              #		parray infopk
              if {$infopk(issuer_hex) == $ret(issuer) && $infopk(serial_number_hex) == $ret(serial_number)} {
                set yescert 1
                set ret(cert_hex) $cert_hex
              }
              if {$yescert == 1 && $ret(nickcert) == ""} {
                set ret(nickcert) "Server TSP"
              }

            }
            set ret(lcerts) $lcerts
            #				puts "I4=$i4"
          }
          "1 2 840 113549 1 9 16 2 24" {
            #puts "id-aa-ets-revocationValues=$oidtypeattr"
          }
          "1 2 840 113549 1 9 16 2 25" {
            #puts "id-aa-ets-esctimeStamp=$oidtypeattr"
            set ret(esctimeStamp) 1
            asn::asnGetSet signedattr esctimestamp
            binary scan $esctimestamp  H* ret(p7esctimestamp_hex)
            set esctst [parse_pkcs7 "der" "$esctimestamp" ""]
            foreach {tstcert tstcrls tstp7} $esctst {}
            foreach tstp7t $tstp7 {
              #puts "P7esc=$tstp7t"
              array set tp7 $tstp7t
              set ret(tstdigest) $tp7(digestalgo)
              set ret(esctstinfo) $tp7(context_hex)
              #puts "escTST"
              #parray tp7
            }

          }
          default {
            puts "DEFAULT oidtypeattr=$oidtypeattr"
            asn::asnGetSet signedattr signeddefault
            binary scan $signeddefault  H* ret(signeddefault)
            puts "DEFAULT Value=$oidtypeattr"
          }
        }
        incr i3
        incr ::I
      }
      #puts "I3=$i3"
                        	
    } else {
      puts "BEDA UNSIGN"

    }
    #parray ret
    #puts "LINFIS_RET=$linfos"
    lappend linfos [array get ret]
                	
  }
  #puts "I1=$i1"
  #puts "LINFOS=$linfos"
  #puts "LCERTS=$lcerts"
  #puts "LCRLS=$lcrls"
  set ::p7s_hex $p7s_hex
  return [list $lcerts $lcrls $linfos]
}

proc list_to_dn_tc26 {name} {
  set ret ""
  foreach {oid_name value} $name {
    if {$oid_name == "INN" || $oid_name == "OGRN" || $oid_name == "OGRNIP" || $oid_name == "SNILS" } {
      set asnValue [::asn::asnNumericString $value]
    } elseif {[string tolower $oid_name] == "email"} {
      set value_em [string map {"@" "A"} $value]
      set ll [string is graph $value_em]
      if {$ll == 1} {
        #			set asnValue [::asn::asnIA5String $value]
        set asnValue [::asn::asnEncodeString 16 $value]
      } else {
        set asnValue [::asn::asnUTF8String $value]
      }
    } elseif {![regexp {[^ A-Za-z0-9'()+,.:/?=-]} $value]} {
      set asnValue [::asn::asnPrintableString $value]
    } else {
      set asnValue [::asn::asnUTF8String $value]
    }

    append ret [::asn::asnSet \
    [::asn::asnSequence \
    [::asn::asnObjectIdentifier [::pki::_oid_name_to_number $oid_name]] \
    $asnValue \
    ] \
    ] \
  }

  return $ret
}

proc create_req_ocsp {cert_user_hex cert_ca_hex} {
  set cert [binary  format H* $cert_user_hex]
  array set parsecert [pki::x509::parse_cert $cert]
  set certca [binary  format H* $cert_ca_hex]
  array set parseca [pki::x509::parse_cert $certca]
  #parray parseca
  catch {set pubkey_algo_number [::pki::_oid_name_to_number $parsecert(pubkey_algo)]}
  if {![info exists pubkey_algo_number]} {
    set pubkey_algo_number $parsecert(pubkey_algo)
  }
  #puts "PUBKEY_ALGO=$pubkey_algo_number"
  switch -- $pubkey_algo_number {
    "1.2.643.7.1.1.1.1" - "1 2 643 7 1 1 1 1" {
      #    "GOST R 34.10-2012-256"
      set digest_algo "stribog256"
      set digest_oid "1 2 643 7 1 1 2 2"
      set digest_len 32
    }
    "1.2.643.7.1.1.1.2" - "1 2 643 7 1 1 1 2" {
      #     "GOST R 34.10-2012-512"
      set digest_algo "stribog512"
      set digest_oid "1 2 643 7 1 1 2 3"
      set digest_len 64
    }
    default {
      puts "Cannot veridy create signature\nUnknown pubkey algo=$pubkey_algo_number"
      return ""
    }
  }
#  array set infopkuser [pki::pkcs11::pubkeyinfo $cert_user_hex)  ]
  set cert_der [binary format H* $cert_user_hex]
  array set infopkuser [pki::x509::parse_cert $cert_der]
#  array set infopk [pki::pkcs11::pubkeyinfo $cert_ca_hex) ]
  set cert_der [binary format H* $cert_ca_hex]
  array set infopk [pki::x509::parse_cert $cert_der]
 
  #parray infopk
  #От чего считать хэш ключа- включать в состав 0440 или 048180  ВКЛЮЧАТЬ
#  set pkca  [binary format H* $infopk(pubkey)]
  array set pk [parse_key_gost $infopk(pubkeyinfo_hex)]
  set pkca  [binary format H* $pk(pubkey)]
#puts "pk(pubkey)=$pk(pubkey)"

  if {$infopkuser(issuer_hex) != $infopk(subject_hex)} {
    puts "Bad CA issuer!=subject"
    return ""
  }
  set issueruser [binary format H* $infopk(subject_hex)]
#  set issuerNamehash_hex [::pki::pkcs11::dgst $digest_algo $issueruser]
#  set issuerNamehash [binary format H* $issuerNamehash_hex]
  set issuerNamehash [lcc_gost3411_2012 $digest_len $issueruser]
#  set issuerKeyhash_hex [::pki::pkcs11::dgst $digest_algo $pkca]
#  set issuerKeyhash [binary format H* $issuerKeyhash_hex]
  set issuerKeyhash [lcc_gost3411_2012 $digest_len $pkca]
  #puts "issuerNamehash_hex=$issuerNamehash_hex"
  #puts "issuerKeyhash_hex =$issuerKeyhash_hex"
  #puts $infopk(pubkey)
  set req_ocsp \
  [::asn::asnSequence \
  [::asn::asnSequence \
  [::asn::asnSequence \
  [::asn::asnSequence \
  [::asn::asnSequence \
  [::asn::asnSequence \
  [::asn::asnObjectIdentifier $digest_oid] \
  [::asn::asnNull]
  ] \
  [::asn::asnOctetString $issuerNamehash] \
  [::asn::asnOctetString $issuerKeyhash] \
  [binary format H* $infopkuser(serial_number_hex)] \
  ] \
  ] \
  ] \
  ] \
  ]
  return $req_ocsp
}


proc pkcs7_add_unsign {p7s certtst digest_algo} {
  #puts "pkcs7_add_unsign=$digest_algo"
  set unsattrtst [create_unsignattrs [list $certtst ""] $digest_algo]
  if {[llength $unsattrtst] == 1} {
    tk_messageBox -title "Подписание документа" -icon info -message [mc "Cannot create unsigned attributes for TST=$unsattrtst"] -detail "Возможно надо выбрать другой сервер щтампов времени"
    set list_for_unstst ""
    #		return ""
  } else {
    foreach {tstchain tstchainref tstcrl tstcrlref} $unsattrtst {}
    set list_for_unstst [::asn::asnContextConstr 1 \
    $tstcrlref \
    $tstchainref \
    $tstcrl \
    $tstchain \
    ]
  }

  asn::asnGetSequence p7s pkcs7
  ::asn::asnGetObjectIdentifier pkcs7 oidSignedData
  ::asn::asnGetContext pkcs7 - asn_cont
  ::asn::asnGetSequence asn_cont asn_cont1
  ::asn::asnPeekByte asn_cont1 peek_tag
  if {$peek_tag == 0x02} {
    # Version number is optional, if missing assumed to be value of 0
    ::asn::asnGetInteger asn_cont1 version
    #puts "VER TST=$version"		
  } else {
    set version 1
    #puts "default TST VER=$version"		
  }
  ::asn::asnGetSet asn_cont1 listdigest
  ::asn::asnGetSequence asn_cont1 context_for_sign
  set asn_cont4 $context_for_sign
  ::asn::asnGetObjectIdentifier asn_cont4 oiddata
  #puts "TST OIDDATA=$oiddata"
  if {[string length $asn_cont4] > 0 } {
    #	    puts "attached signature"
    ::asn::asnGetContext asn_cont4 - octcontext
    ::asn::asnGetOctetString octcontext context
  } else {
    #	    puts "detached signature"
    set context ""
  }

  ::asn::asnGetContext asn_cont1 - cert
  ::asn::asnGetSet asn_cont1 listsigner

  asn::asnGetSequence listsigner signerinfo
  set listsigner [asn::asnSequence $signerinfo \
  $list_for_unstst \
  ]

  set p7_signed [::asn::asnSequence \
  [::asn::asnObjectIdentifier $oidSignedData] \
  [::asn::asnContextConstr 0 \
  [::asn::asnSequence \
  [::asn::asnInteger $version] \
  [::asn::asnSet $listdigest] \
  [::asn::asnSequence $context_for_sign] \
  [::asn::asnSet $listsigner] \
  ] \
  ] \
  ]

  return $p7_signed
}

proc saveCert { typesave cont} {
  variable file_for_sign
  global macos
  global myHOME
  if {$cont == "" } {
    tk_messageBox -title "Экспорт" -icon info -message "Нечего экспортировать" -parent .
    return
  }

  set typeCertDer {
    {"Экспорт сертификата в DER формате"    .der}
    {"Экспорт сертификата в DER формате"    .cer}
    {"Любой"    *}
  }
  set typeCertPem {
    {"Экспорт сертификата в PEM формате"   .pem}
    {"Экспорт сертификата в PEM формате"    .crt}
    {"Любой"    *}
  }
  set typeP7S {
    {"PKCS#7 в DER-формате"    .p7s}
    {"Любой"    *}
  }
  set typeFileTXT {
    {"Экспорт просматриваемого"   .txt}
    {"Любой"    *}
  }
  set typeFileAll {
    {"Любой"    *}
  }
  set tit "Экспорт сертификата"
  set mbad "Экспорт сертификата не удался в файл"
  set mok "Сертификат сохранен в файле"
  set encodePem $typesave
  set tsav "."
  if { $typesave == 1 } {
    set typeCert [subst $typeCertPem]
    set typeTitle "Экспорт сертификата в PEM формате"
  } elseif { $typesave == 0 } {
    set typeCert [subst $typeCertDer]
    set typeTitle "Экспорт сертификата в DER формате"
  } elseif { $typesave == 2 }  {
    set typeCert [subst $typeFileAll]
    set typeTitle "Экспорт контента"
    set tit "Экспорт контента"
    set mbad "Экспорт контента не удался в файл"
    set mok "Контент сохранен в файле"
  } elseif { $typesave == 3 }  {
    set typeCert [subst $typeP7S]
    set typeTitle "Экспорт TimeStampToken"
    set encodePem 0
  } elseif { $typesave == 4 }  {
    set typeCert [subst $typeFileTXT]
    set typeTitle "Экспорт просматриваемого"
    set tit "Экспорт просматриваемого"
    set mbad "Экспорт просматриваемого не удался в файл"
    set mok "Содержимое сохранено в файле"
    set tsav ".about"
  } else {
    return
  }
  if {$macos} {
    set ft ""
  } else {
    set ft $typeCert
  }

  set file [tk_getSaveFile -title "$typeTitle"  -filetypes $ft  -initialdir "$myHOME"]
  if { $file == "" } {
    return;
  }
  set x [catch {set fid [open $file w+]}]
  set y [catch {puts $fid "#http://soft.lissi.ru\n"}]
  set z [catch {close $fid}]
  if { $x || $y || $z || ![file exists $file] || ![file isfile $file] || ![file readable $file] } {
    tk_messageBox -icon error  -message "Невозможно записать сертификат в этот файл:\n \"$file\""
    return
  }
  file delete -force $file
  #Собственно запись в файл
  #Разобраться с PEM
  if {$encodePem == 1} {
    set cert [::pki::_encode_pem $cont "-----BEGIN CERTIFICATE-----" "-----END CERTIFICATE-----"]
  } else {
    set cert $cont
  }
  set fd [open $file w]
  chan configure $fd -translation binary
  puts -nonewline $fd $cert
  close $fd

  if {![file exists $file]} {
    tk_messageBox -title $tit -icon error -message "$mbad\n $file" 
    return
  }
  if {![file size $file]} {
    tk_messageBox -title $tit -icon error -message "$mbad\n $file" 
    return
  }
  tk_messageBox -title $tit  -icon info  -message "$mok\n\"$file\""
}

proc cafromlist {lurls} {
  foreach c_par $lurls {
    #Выбираем очередной  url
    #адрес корневого сертификата
    #Читаем очередной корневой сертификат
    #puts "readca=$c_par"
    set certca [readca $c_par]
    if {$certca == ""} {
      #Прочитать сертификат не удалось. Ищем следующую точку с сертификатом
      continue
    } else {
      set asndata [cert2der $certca]
      if {[string first "p7b" $c_par] != -1} {
        puts "P7B !!!"
        set tst [parse_pkcs7 "der" "$asndata" ""]
        foreach {tstcerts tstcrls tstp7} $tst {}
        set certtst ""
        foreach tstcert $tstcerts {
          set asndata [binary format H* $tstcert]
          break
        }
      }
      return $asndata
    }
  }
  return ""
}


proc create_new_signer {cert_hex content typekey} {
  global ttt
  variable createTimeStamp
  variable createescTS
  variable varescTS
  global yespas
  global pass
  array set ret [list]
  set listdigest ""
  set listsigner ""
  set cert [binary  format H* $cert_hex]
  array set parsecert [pki::x509::parse_cert $cert]
  #parray parsecert
  catch {set pubkey_algo_number [::pki::_oid_name_to_number $parsecert(pubkey_algo)]}
  if {![info exists pubkey_algo_number]} {
    set pubkey_algo_number $parsecert(pubkey_algo)
  }
  #puts "PUBKEY_ALGO=$pubkey_algo_number"
  switch -- $pubkey_algo_number {
    "1.2.643.7.1.1.1.1" - "1 2 643 7 1 1 1 1" {
      #    "GOST R 34.10-2012-256"
      set digest_algo "stribog256"
      set digest_len 32
      set digest_oid "1 2 643 7 1 1 2 2"
      set signature_oid "1 2 643 7 1 1 3 2"
      set ckm "CKM_GOSTR3410"
    }
    "1.2.643.7.1.1.1.2" - "1 2 643 7 1 1 1 2" {
      #     "GOST R 34.10-2012-512"
      set digest_algo "stribog512"
      set digest_len 64
      set digest_oid "1 2 643 7 1 1 2 3"
      set signature_oid "1 2 643 7 1 1 3 3"
      set ckm "CKM_GOSTR3410_512"
    }
    default {
      puts "Cannot veridy create signature\nUnknown pubkey algo=$pubkey_algo_number"
      return [array get ret]
    }
  }
  set listdigest1 [::asn::asnSequence \
  [::asn::asnObjectIdentifier $digest_oid] \
  [::asn::asnNull] \
  ]
  set listdigest "$listdigest$listdigest1"
if {0} {
  set aa [dict create pkcs11_handle $::handle pkcs11_slotid $::slotid_tek]
  if {$typekey == "pkcs11"} {
    array set infopk [pki::pkcs11::pubkeyinfo $cert_hex  [list pkcs11_handle $::handle pkcs11_slotid $::slotid_tek]]
  } else {
    array set infopk [pki::pkcs11::pubkeyinfo $cert_hex ]
  }
}
  if {$typekey == "pkcs11"} {
    array set infopk [pki::pkcs11::pubkeyinfo $cert_hex  [list pkcs11_handle $::handle pkcs11_slotid $::slotid_tek]]
  } 

  #parray infopk
  # "1 2 840 113549 1 9 16 2 47" - signedtcertv2
#puts "create_new_signer digest_algo=$digest_algo"
#  set cert_digest_hex [pki::pkcs11::dgst $digest_algo $cert]
#  set cert_digest [binary  format H* $cert_digest_hex]
  set cert_digest [lcc_gost3411_2012 $digest_len $cert]
#  set name [binary format H* $infopk(issuer)]
  set name [binary format H* $parsecert(issuer_hex)]
  set certv2 [::asn::asnSequence \
  [::asn::asnSequence \
  [::asn::asnSequence \
  [::asn::asnSequence \
  [::asn::asnObjectIdentifier $digest_oid] \
  ] \
  [::asn::asnOctetString $cert_digest] \
  [::asn::asnSequence \
  [::asn::asnSequence \
  [::asn::asnContextConstr 4 \
  $name \
  ] \
  ] \
  [::asn::asnBigInteger [math::bignum::fromstr $parsecert(serial_number)]] \
  ] \
  ] \
  ] \
  ]

  #	set digest_hex    [pki::pkcs11::digest $digest_algo $content  $aa]
#  set digest_hex    [pki::pkcs11::dgst $digest_algo $content]
#  set digest_content [binary  format H* $digest_hex]
  set digest_content [lcc_gost3411_2012 $digest_len $content]

  set list_for_sign [::asn::asnContextConstr 0 \
  [::asn::asnSequence \
  [::asn::asnObjectIdentifier $::oidAttributeContentType] \
  [::asn::asnSet \
  [::asn::asnObjectIdentifier $::oidData] \
  ] \
  ] \
  [::asn::asnSequence \
  [::asn::asnObjectIdentifier $::oidAttributeSigningTime] \
  [::asn::asnSet \
  [::asn::asnUTCTime [clock format [clock seconds]  -format {%y%m%d%H%M%SZ} -gmt true]] \
  ] \
  ] \
  [::asn::asnSequence \
  [::asn::asnObjectIdentifier $::oidAttributeMessageDigest] \
  [::asn::asnSet \
  [::asn::asnOctetString $digest_content] \
  ] \
  ] \
  [::asn::asnSequence \
  [::asn::asnObjectIdentifier $::::oidsigningCertificateV2] \
  [::asn::asnSet $certv2]  \
  ] \
  ]
        	
  #################
  binary scan  $list_for_sign H* listsigner_hex

  #puts "listsigner_HEX=$listsigner_hex"

  set listsigner_for_digest_hex "31[string range $listsigner_hex 2 end]"
  #puts "listsigner_for_digest=$listsigner_for_digest_hex"
  set listsigner_for_digest [binary format H* $listsigner_for_digest_hex]
  #    set digestsign_hex    [pki::pkcs11::digest $digest_algo $listsigner_for_digest  $aa]
#  set digestsign_hex    [pki::pkcs11::dgst $digest_algo $listsigner_for_digest ]
  set digestsign_bin [lcc_gost3411_2012 $digest_len $listsigner_for_digest]
  binary scan  $digestsign_bin H* digestsign_hex


  if {$typekey == "pkcs11"} {
    set aa [dict create pkcs11_handle $::handle pkcs11_slotid $::slotid_tek]
    lappend aa "pkcs11_id"
    #CKA_ID сертификата вычисляем по открытому ключу
    if {$::cert_pkcs11_id == ""} {
	lappend aa $infopk(pkcs11_id)
    } else {
    #CKA_ID сертификата берем с токенв
	lappend aa $::cert_pkcs11_id
    }
    #puts "digestsign_hex=$digestsign_hex"
    #puts "digestsign_hex=[string length $digestsign_hex]"
    puts "SIGN=start; $aa"
    set sign_content_hex  [pki::pkcs11::sign $ckm $digestsign_hex  $aa]
    #puts "SIGN=$sign_content_hex"
    lappend aa "pubkeyinfo"
    lappend aa $infopk(pubkeyinfo)

    if {[catch {set verify [pki::pkcs11::verify $digestsign_hex $sign_content_hex $aa]} res] } {
      puts "BEDA=$res"
      return [array get ret]
    }
    if {$verify != 1} {
      puts "BAD SIGNATURE=$verify"
      return ""
    }
    #puts "SIGNATURE OK=$verify"
  } elseif {$typekey == "pkcs12"} {
    set digestsign [binary  format H* $digestsign_hex]
    set lenkey [string length $::private_key_str]
    # generate random bytes for signature
    set rnd_ctx [lrnd_random_ctx_create ""]
    set rnd_bytes [lrnd_random_ctx_get_bytes $rnd_ctx $lenkey]
# public key generation for verify
    if { $lenkey == 32 } {
      set sign_content [lcc_gost3410_2012_256_sign $::group $::private_key_str $digestsign $rnd_bytes]
#Публичный ключ получаем из закрытого
	set public_key_str [lcc_gost3410_2012_256_createPublicKey $::group $::private_key_str]
# signature verification
	set signature_ok [lcc_gost3410_2012_256_verify $::group $public_key_str $digestsign $sign_content]
    } elseif {$lenkey == 64 } {
      set sign_content [lcc_gost3410_2012_512_sign $::group $::private_key_str $digestsign $rnd_bytes]
#Публичный ключ получаем из закрытого
      set public_key_str [lcc_gost3410_2012_512_createPublicKey $::group $::private_key_str]
# signature verification
      set signature_ok [lcc_gost3410_2012_512_verify $::group $public_key_str $digestsign $sign_content]
#    puts "signature_ok: $signature_ok"
    } else {
      puts "BAD key=$lenkey"
      return ""
    }
#    puts "signature_ok: $signature_ok"
    if {$signature_ok != 1} {
	puts "Bad signature=$signature_ok"
	return ""
    }

    binary scan  $sign_content H*  sign_content_hex
  } else {
    puts "Bad type storage key=$typekey"
    return ""
  }
  set sign_content [binary  format H* $sign_content_hex]
  set list_for_unsign ""
  if {$createescTS} {
    set stamp ""
    set escstamp ""
    #puts "Первый штамп"
    set tsr [::create_tsq $sign_content $digest_oid]
    #puts "Первый штамп END"
    set url $::tekTSP
    #Проверяем тип протокола
    if { "https://" == [string range $url 0 7]} {
#      puts "HTTPS=$url"
      http::register https 443 ::tls::socket
    }
    if {[catch {
      set token [http::geturl $url  -type  "application/timestamp-query" -query  $tsr  -binary 1]
      #             -timeout 300000
      #		http::wait $token
      #puts "GETURL END 1"
      set stampfull [doneGet $token]
      if {0} {
        set fd [open "ADD_STAMPFULL.der" w]
        chan configure $fd -translation binary
        puts -nonewline $fd $stampfull
        close $fd
      }

      ::asn::asnGetSequence stampfull stamp

    } error]} {
      puts stderr "Error while getting URL: $error"
      tk_messageBox -title "Новый подписант, TST" -icon error -message "Ошибка при чтении URL:\n$url" -detail $error
      return ""
    }
    #::oidtimeStampToken             "1 2 840 113549 1 9 16 2 14"
    #УБИРАЕМ ВЕРСИЮ ???
    ::asn::asnGetSequence stamp version
    if {[string length $stamp] == 0} {
      tk_messageBox -title "Новый подписант, TST"  -icon error -message  "Получили пустой штамп времени"  -detail "URL:$url"
      return ""
    }
    #Ищем издателя TST
    set tst [parse_pkcs7 "der" "$stamp" ""]
    foreach {tstcert tstcrls tstp7} $tst {}
    set certtst ""
    foreach tstp7t $tstp7 {
      #puts "P7=$p7t"
      array set tp7 $tstp7t
      set certtst $tp7(cert_hex)
      #parray tp7
    }
                	
    #Цепочка сертификатов и crl для TST
    #puts "TST add UNSIGN=$digest_algo"
    set stamp [pkcs7_add_unsign $stamp $certtst $digest_algo]
    #puts "TST add UNSIGN END"

    #Упаковываем штамп времени TST
    set tspstamp [::asn::asnSequence \
    [::asn::asnObjectIdentifier $::oidtimeStampToken] \
    [::asn::asnSet $stamp ] \
    ]

    #Цепочка сертификатов и crl
    set unsignattrs [create_unsignattrs [list $cert_hex $certtst] $digest_algo]
    if {[llength $unsignattrs] == 1} {
      tk_messageBox -title "Подписание документа" -icon info -message "Проблеиы с OSCP-сервером ($unsignattrs)" -parent .
      return ""
    }
    foreach {lchain lchainref lcrl lcrlref} $unsignattrs {}

    set esctspstamp  ""
    if {$createescTS == 2} {
      if {$lchainref == "" } {
        tk_messageBox -title "Подписание документа" -icon info -message [mc "No certificate chain"]
        return ""
      }
                        	
      #Второй штамр
      set cont2esc $sign_content
      ::asn::asnGetSequence tspstamp temp
      append cont2esc $temp
      set tspstamp [::asn::asnSequence $temp]
      ::asn::asnGetSequence lchainref temp
      append cont2esc $temp
      set lchainref [::asn::asnSequence $temp]
      ::asn::asnGetSequence lcrlref temp
      append cont2esc $temp
      set lcrlref [::asn::asnSequence $temp]
      set escstamp ""
      #puts "Второй штамп"
      set esctsr [::create_tsq $cont2esc $digest_oid]
      #puts "Второй штамп END"
      set url $::tekTSP
      #Проверяем тип протокола
      if { "https://" == [string range $url 0 7]} {
#        puts "HTTPS=$url"
        http::register https 443 ::tls::socket
      }
      if {[catch {
        set token [http::geturl $url  -type  "application/timestamp-query" -query  $esctsr  -binary 1]
        #		http::wait $token
        #             -timeout 300000
        #puts "GETURL END 2"
        set escstampfull [doneGet $token]
        ::asn::asnGetSequence escstampfull escstamp
      } error]} {
        puts stderr "Error while getting URL: $error"
        tk_messageBox -title [mc "Create new signer, escTS"] -icon error -message [mc "Error while getting URL:\n$url"] -detail $error
        return ""
      }
      # ::oidesctimeStamp           "1 2 840 113549 1 9 16 2 25"
      #УБИРАЕМ ВЕРСИЮ У esc???
      ::asn::asnGetSequence escstamp version

      set esctspstamp [::asn::asnSequence \
      [::asn::asnObjectIdentifier $::oidesctimeStamp] \
      [::asn::asnSet $escstamp ] \
      ]
    }

    set list_for_unsign [::asn::asnContextConstr 1 \
    $lcrlref \
    $lchainref \
    $esctspstamp \
    $lcrl \
    $tspstamp \
    $lchain \
    ]

  }

  #################

  set listsigner1 [::asn::asnSequence \
  [::asn::asnInteger 1] \
  [::asn::asnSequence \
  $name \
  [::asn::asnBigInteger [math::bignum::fromstr $parsecert(serial_number)]] \
  ] \
  [::asn::asnSequence \
  [::asn::asnObjectIdentifier $digest_oid] \
  [::asn::asnNull] \
  ] \
  $list_for_sign \
  [::asn::asnSequence \
  [::asn::asnObjectIdentifier $pubkey_algo_number] \
  ] \
  [::asn::asnOctetString $sign_content] \
  $list_for_unsign \
  ]
  set listsigner "$listsigner$listsigner1"
  set ret(listsigner) $listsigner
  set ret(listdigest) $listdigest
  return [array get ret]
}

proc ::pki::pkcs7_add_signeddata {content cert_hex typekey p7s_hex} {
  #puts "P7S_HEX=$p7s_hex"
  set p7s [binary  format H* $p7s_hex]
  asn::asnGetSequence p7s pkcs7
  ::asn::asnGetObjectIdentifier pkcs7 oidSignedData
  ::asn::asnGetContext pkcs7 - asn_cont
  ::asn::asnGetSequence asn_cont asn_cont1
  ::asn::asnPeekByte asn_cont1 peek_tag
  if {$peek_tag == 0x02} {
    # Version number is optional, if missing assumed to be value of 0
    ::asn::asnGetInteger asn_cont1 version
    #puts "VER=$version"		
  } else {
    set version 1
    #puts "default VER=$version"		
  }
  ::asn::asnGetSet asn_cont1 listdigest
  ::asn::asnGetSequence asn_cont1 context_for_sign
  set asn_cont4 $context_for_sign
  ::asn::asnGetObjectIdentifier asn_cont4 oiddata
  #puts "OIDDATA=$oiddata"
  if {[string length $asn_cont4] > 0 } {
    #	    puts "attached signature"
    ::asn::asnGetContext asn_cont4 - octcontext
    ::asn::asnGetOctetString octcontext context
    #puts "CONTEXT=$context"		
    if  {$context != $content} {
      puts "Bad content!!!!"
      return 0
    }
  } else {
    #	    puts "detached signature"
    set context $content
  }

  ::asn::asnGetContext asn_cont1 - cert
  ::asn::asnGetSet asn_cont1 listsigner

  array set addsigner [create_new_signer $cert_hex $context $typekey]
  if {![info exists addsigner(listdigest)]} {
    #Что-то плохо с добавлением
    #    puts "Cannot add signer (digest)"
    tk_messageBox -title "Добавить новую подпись" -icon error -message [mc "Cannot add signer (digest)"]
    return 0
  }
  if {![info exists addsigner(listsigner)]} {
    #Что-то плохо с добавлением
    #	    puts "Cannot add signer (signer)"
    tk_messageBox -title "Добавить новую подпись" -icon error -message [mc "Cannot add signer (signer)"]
    return 0
  }
  #puts "OK for ADD"
  set certnew [binary  format H* $cert_hex]

  set p7_signed [::asn::asnSequence \
  [::asn::asnObjectIdentifier $oidSignedData] \
  [::asn::asnContextConstr 0 \
  [::asn::asnSequence \
  [::asn::asnInteger $version] \
  [::asn::asnSet $listdigest$addsigner(listdigest)] \
  [::asn::asnSequence $context_for_sign] \
  [::asn::asnContextConstr 0 $certnew$cert] \
  [::asn::asnSet $listsigner$addsigner(listsigner)] \
  ] \
  ] \
  ]

  return $p7_signed
}


proc ocspfromcert {cert_hex} {
  set asndata [binary  format H* $cert_hex]
  if {$asndata == "" } {
    #    puts "ocspfromcert=not cert"
    return [list {} {}]
  }
  array set cert_parse [::pki::x509::parse_cert $asndata]
  array set extcert $cert_parse(extensions)
  if {![info exists extcert(1.3.6.1.5.5.7.1.1)]} {
    #В сертификате нет расширений
    #    puts "ocspfromcert=not extend"
    return [list {} {}]
  }

  set a [lindex $extcert(1.3.6.1.5.5.7.1.1) 0]

  #Читаем ASN1-последовательность расширения в Hex-кодировке
  set b [lindex $extcert(1.3.6.1.5.5.7.1.1) 1]
  #Переводим в двоичную кодировку
  set chain [binary format H* $b]


  set ret {}
  ::asn::asnGetSequence chain c_par_first
  set caissuer {}
  set servocsp {}
  while {[string length $c_par_first] > 0 } {
    #Выбираем очередную последовательность (sequence)
    ::asn::asnGetSequence c_par_first c_par
    #Выбираем oid из последовательности
    ::asn::asnGetObjectIdentifier c_par c_type
    set tas1 [::pki::_oid_number_to_name $c_type]
    #Выбираем установленное значение
    ::asn::asnGetContext c_par c_par_two
    #Ищем oid с адресом корневого сертификата
    if {$tas1 == "1.3.6.1.5.5.7.48.2" } {
      #Читаем очередной корневой сертификат
      lappend caissuer $c_par
      #	    puts "CA (oid=$tas1)=$c_par"
    } elseif {$tas1 == "1.3.6.1.5.5.7.48.1" } {
      lappend servocsp $c_par
      #	    puts "OCSP server (oid=$tas1)=$c_par"
    }
  }
  # Цепочка закончилась
  return [list $caissuer $servocsp]
}



proc chainfromcert {cert dir} {
  variable chaincerts
  global count
  if {$cert == "" } {
    puts "XAend=not cert"
    return
  }
  set asndata [cert2der $cert]
  if {$asndata == "" } {
    #Файл содержит все что угодно, только не сертификат
    puts "XAend=bad CRL"
    return -1
  }
  array set cert_parse [::pki::x509::parse_cert $asndata]
  array set extcert $cert_parse(extensions)
  if {![info exists extcert(1.3.6.1.5.5.7.1.1)]} {
    #В сертификате нет расширений
    puts "XAend=bad CRL 1"
    return 0
  }

  set a [lindex $extcert(1.3.6.1.5.5.7.1.1) 0]
  #Читаем ASN1-последовательность расширения в Hex-кодировке
  set b [lindex $extcert(1.3.6.1.5.5.7.1.1) 1]
  #Переводим в двоичную кодировку
  set c [binary format H* $b]
  #Sequence 1.3.6.1.5.5.7.1.1
  ::asn::asnGetSequence c c_par_first
  #Цикл перебора значений в засширении 1.3.6.1.5.5.7.1.1
  while {[string length $c_par_first] > 0 } {
    #Выбираем очередную последовательность (sequence)
    ::asn::asnGetSequence c_par_first c_par
    #Выбираем oid из последовательности
    ::asn::asnGetObjectIdentifier c_par c_type
    set tas1 [::pki::_oid_number_to_name $c_type]
    #Выбираем установленное значение
    ::asn::asnGetContext c_par c_par_two
    #Ищем oid с адресом корневого сертификата
    if {$tas1 == "1.3.6.1.5.5.7.48.2" } {
      #Читаем очередной корневой сертификат
      #puts "readca=$c_par"
      set certca [readca $c_par]
      if {$certca == ""} {
        #Прочитать сертификат не удалось. Ищем следующую точку с сертификатом
        continue
      } else {
        #Сохраняем корневой сертификат в указанном каталоге
        if {$dir != ""} {
          set f [file join $dir [file tail $c_par]]
          set fd [open $f w]
          chan configure $fd -translation binary
          puts -nonewline $fd $certca
          close $fd
          lappend ::listcert $f
        } else {
          set asndata [cert2der $certca]
          if {[string first "p7b" $c_par] != -1} {
            puts "P7B !!!"
            set tst [parse_pkcs7 "der" "$asndata" ""]
            #puts "P7B parse_pkcs7 END"
            foreach {tstcerts tstcrls tstp7} $tst {}
            set certtst ""
            foreach tstcert $tstcerts {
              set asndata [binary format H* $tstcert]
              break
            }
          }
          append chaincerts $asndata
          set certca $asndata
        }
        incr count
        #		puts "cert $count from $c_par"
        #ПОДЫМАЕМСЯ по ЦЕПОЧКЕ СЕРТИФИКАТОВ ВВЕРХ
        chainfromcert $certca $dir
        continue
      }
    } elseif {$tas1 == "1.3.6.1.5.5.7.48.1" } {
      #	    puts "OCSP server (oid=$tas1)=$c_par"
    }
  }
  # Цепочка закончилась
  #puts "XAend=$count"
  return $count
}


proc chaincafromcert {cert} {
  variable chainca
  global count
  if {$cert == "" } {
    return $chainca
  }
  set asndata [cert2der $cert]
  #    set asndata $cert
  if {$asndata == "" } {
    #Файл содержит все что угодно, только не сертификат
    return $chainca
  }
  array set cert_parse [::pki::x509::parse_cert $asndata]
  array set extcert $cert_parse(extensions)
  if {![info exists extcert(1.3.6.1.5.5.7.1.1)]} {
    #В сертификате нет расширений
    return $chainca
  }

  set a [lindex $extcert(1.3.6.1.5.5.7.1.1) 0]
  #Читаем ASN1-последовательность расширения в Hex-кодировке
  set b [lindex $extcert(1.3.6.1.5.5.7.1.1) 1]
  #Переводим в двоичную кодировку
  set c [binary format H* $b]
  #Sequence 1.3.6.1.5.5.7.1.1
  ::asn::asnGetSequence c c_par_first
  #Цикл перебора значений в засширении 1.3.6.1.5.5.7.1.1
  while {[string length $c_par_first] > 0 } {
    #Выбираем очередную последовательность (sequence)
    ::asn::asnGetSequence c_par_first c_par
    #Выбираем oid из последовательности
    ::asn::asnGetObjectIdentifier c_par c_type
    set tas1 [::pki::_oid_number_to_name $c_type]
    #Выбираем установленное значение
    ::asn::asnGetContext c_par c_par_two
    #Ищем oid с адресом корневого сертификата
    if {$tas1 == "1.3.6.1.5.5.7.48.2" } {
      #Читаем очередной корневой сертификат
      #puts "readca=$c_par"
      set certca [readca $c_par]
      if {$certca == ""} {
        #Прочитать сертификат не удалось. Ищем следующую точку с сертификатом
        continue
      } else {
        #Сохраняем корневой сертификат в списке
        set asndata [cert2der $certca]
        if {[string first "p7b" $c_par] != -1} {
          #			puts "P7B !!!"
          set tst [parse_pkcs7 "der" "$asndata" ""]
          #puts "P7B parse_pkcs7 END"
          foreach {tstcerts tstcrls tstp7} $tst {}
          set certtst ""
          foreach tstcert $tstcerts {
            set asndata [binary format H* $tstcert]
            break
          }
        }
        lappend chainca $asndata
        set certca $asndata
        #ПОДЫМАЕМСЯ по ЦЕПОЧКЕ СЕРТИФИКАТОВ ВВЕРХ
        chaincafromcert $certca
        continue
      }
    } elseif {$tas1 == "1.3.6.1.5.5.7.48.1" } {
      #	    puts "OCSP server (oid=$tas1)=$c_par"
    }
  }
  # Цепочка закончилась
  return $chainca
}

proc readca {url} {
  set cer ""
  #Проверяем тип протокола
  if { "https://" == [string range $url 0 7]} {
#    puts "HTTPS=$url"
    http::register https 443 ::tls::socket
  }
  #Читаем сертификат в бинарном виде
  if {[catch {set token [http::geturl $url -binary 1]
    #получаем статус выполнения функции
    #	http::wait $token
    update
    set ere [http::status $token]
    if {$ere == "ok"} {
      #Получаем код возврата с которым был прочитан сертификат
      set code [http::ncode $token]
      if {$code == 200} {
        #Сертификат успешно прочитан и будет созвращен
        set cer [http::data $token]
      } elseif {$code == 301 || $code == 302} {
        #Сертификат перемещен в другое место, получаем его
	update
        set newURL [dict get [http::meta $token] Location]
        #puts "newURL=$newURL"
        #Читаем сертификат с другого сервера
        set cer [readca $newURL]
      } else {
        #Сертификат не удалось прочитать
        set cer ""
      }
    }
  } error]} {
    #Сертификат не удалось прочитать, нет узла в сети
    set cer ""
  }
  return $cer
}

proc ::renamecert {pkcs11_id} {
  global yespas
  global pass
  variable nickCert
  if {[llength $::listx509] < 1} {
    return
  }
  #    puts "RENAMECERT nickTok=$::slotid_teklab"
  #Ввод МЕТКИ
  set yespas ""
  set pass ""
  set titpin "Токен: $::slotid_teklab"
wm state . withdraw
  wm title .topPinPw $titpin
  wm state .topPinPw normal
  wm state .topPinPw withdraw
  wm state .topPinPw normal
  raise .topPinPw
  grab .topPinPw
  .topPinPw.labFrPw configure -text "Введите метку для сертификата"
  pack forget .topPinPw.labFrPw.entryPw
  pack forget .topPinPw.labFrPw.butPw
  pack .topPinPw.labFrPw.entryLb -fill x -expand 1 -padx 5 -pady 5  -ipady 2
  pack .topPinPw.labFrPw.butPw -pady {0 5} -sid right -padx 5

  .topPinPw.labFrPw.entryLb insert end  $nickCert

  focus .topPinPw.labFrPw.entryLb
  set yespas ""
  vwait yespas
  grab release .topPinPw
  pack forget .topPinPw.labFrPw.entryLb
  pack forget .topPinPw.labFrPw.butPw
  pack .topPinPw.labFrPw.entryPw -fill x -expand 1 -padx 5 -pady 5  -ipady 2
  pack .topPinPw.labFrPw.butPw -pady {0 5} -sid right -padx 5
  .topPinPw.labFrPw.entryLb delete 0 end
  .topPinPw.labFrPw.entryPw delete 0 end
  .topPinPw.labFrPw.entryPw configure -show *
  .topPinPw.labFrPw configure -text "Введите PIN-код и нажмите ВВОД"
wm state . normal
  if { $yespas == "no" } {
    return
  }
  set newlab $pass
  set yesno "no"
  #    puts "RENAME=$pkcs11_id"
  #    puts "NEWLAB=$newlab"
  #Ввод PIN-кода
  set yespas ""
  set pass ""
  set titpin "Токен: $::slotid_teklab"
  wm title .topPinPw $titpin
wm state . withdraw
  wm state .topPinPw normal
  wm state .topPinPw withdraw
  wm state .topPinPw normal
  raise .topPinPw
  grab .topPinPw
  focus .topPinPw.labFrPw.entryPw
  set yespas ""
  vwait yespas
  grab release .topPinPw
wm state . normal
  if { $yespas == "no" } {
    return
  }
  set yesno "no"
  puts "nickTok=$::slotid_teklab"
  set lists [listts $::handle]
  if {[llength $lists] == 0} {
    tk_messageBox -title "Переименовать" -icon info -message "Нет подключенных токенов\n"
    return
  }

  set uu [dict create pkcs11_handle $::handle]
  dict set uu pkcs11_slotid $::slotid_tek
  lappend uu "pkcs11_id"
  lappend uu $pkcs11_id
  lappend uu "pkcs11_label"
  lappend uu $newlab
  if { [pki::pkcs11::login $::handle $::slotid_tek $pass] == 0 } {
    tk_messageBox -title "Переименовать" -icon info -message "Плохой PIN-код"
    unset uu
    return
  }
  #puts "PKCS11ID=$::pkcs11id"
  #puts "PKCS11_LAB=$newlab"

  pki::pkcs11::rename all $uu
  pki::pkcs11::logout $::handle $::slotid_tek
  #puts "Установлена метка $newlab"
  unset uu
  tk_messageBox -title "Переименовать" -icon info -message "Метка сертификата \n$pkcs11_id" -detail "$newlab"
  updatetok

}

proc ::workOpCertP11 {opnum} {
  global yespas
  global pass
  variable nickCert
  set c ".st.fr1.fr2_list4"
  #    puts "WORKOP:c=$c"
  set i 0
  if {$nickCert == ""} {
    tk_messageBox -title "Работа с сертификатом" -icon error -message "Не выбран сертификат на токене" -parent .
    return
  }
  if {[llength $::certs_p11] < 1} {
    tk_messageBox -title "Работа с сертификатом" -icon error -message "Сертификаты отсутствуют на токене" -parent .
    return
  }
  set cert_derhex ""
  foreach certinfo_list $::certs_p11 {
    unset -nocomplain cert_parse
    array set cert_parse_der $certinfo_list
    if {$cert_parse_der(pkcs11_label) == $nickCert} {
      set cert_derhex $cert_parse_der(cert_der)
      break
    }
  }
  #parray cert_parse_der
  if {$cert_derhex == ""} {
    tk_messageBox -title "Работа с сертификатом" -icon error -message "Проблемы с сертификатом на токене" -parent .
    return
  }

  switch $opnum {
    0 {
      puts "opnum=$opnum"
      set err [verifysign $cert_derhex "pkcs11"]
      #	    puts "CERIFYSYGN=$err"
      return
    }
    1 {
      #    puts "opnum=$opnum"
      loadcrl $cert_derhex 0
    }
    2 {
      set certder [binary format H* $cert_derhex]
      saveCert 1 $certder
      return
    }
    3 {
      set certder [binary format H* $cert_derhex]
      saveCert 0 $certder
      return
    }
    4 {
      #    puts "opnum=$opnum"
      #Удалить сертификат с токена
      set lists [listts $::handle]
      if {[llength $lists] == 0} {
        tk_messageBox -title [mc "Delete certificate"] -icon info -message "[mc {Tokens not present}]\n"
        return
      }
      set find 0
      foreach {lab token_slotid} $lists {
        if {$lab == $::slotid_teklab } {
          set find 1
          break
        }
      }
      if {$find == 0} {
        tk_messageBox -title [mc "Delete certificate"] -icon info -message "[mc {Token not find}]: $::slotid_teklab\n"
        return
      }
      #Ввод PIN-кода
      set yespas ""
      set pass ""
      set titpin "[mc {Token}]: $::slotid_teklab"
      wm title .topPinPw $titpin
      wm state .topPinPw normal
wm state . withdraw
      wm state .topPinPw withdraw
      wm state .topPinPw normal
      raise .topPinPw
      grab .topPinPw
      focus .topPinPw.labFrPw.entryPw
      vwait yespas
      grab release .topPinPw
wm state . normal
      if { $yespas == "no" } {
        return
      }
      set yesno "no"
      set uu [dict create pkcs11_handle $::handle]
      dict set uu pkcs11_slotid $token_slotid
      lappend uu "pkcs11_id"
      lappend uu $cert_parse_der(pkcs11_id)
      set answer [tk_messageBox -icon question -message "Удалить ключевую пару\nДа/Нет?" -title "Удаление" -type yesno]

      #puts "Password=$pass"
      if { [pki::pkcs11::login $::handle $token_slotid $pass] == 0 } {
        #		  puts "Bad password"
        tk_messageBox -title [mc "Delete certificate"] -icon info -message "[mc {Bad PIN-code}]\n"
        unset pass
        return
      }
      if {$answer != "yes"} {
        pki::pkcs11::delete cert $uu
        #		pki::pkcs11::logout $::handle $token_slotid
      } else {
        pki::pkcs11::delete all $uu
        pki::pkcs11::logout $::handle $::slotid_tek
      }
      unset pass
      ::updatetok
      return
  }
    4 {
      puts "opnum=$opnum"
                        	
    }
    5 {
      ::renamecert $cert_parse_der(pkcs11_id)
      return
    }
    default {
      puts "workOpCertP11: Unknown operation=$opnum"
    }
}
}


proc ::workOpCert {} {
    global yespas
    global pass
    variable src_fn
    variable opcert
    variable cert_fn
    variable nickCert
    set c ".st.fr1.fr2_list4"
#    puts "WORKOP:c=$c"
    set i 0
    if {$cert_fn == ""} {
	tk_messageBox -title "Работа с сертификатом" -icon error -message "Не выбран файл с сертификатом" -parent .
	return
    }
    set fd [open $cert_fn]
    chan configure $fd -translation binary
    set data [read $fd]
    close $fd
    set asndata [cert2der $data]
    if {$asndata == "" } {
	puts "Bad file with certificate=$file"
	return
    }
    binary scan $asndata H* cert_hex

    switch $opcert {
	0 {
#    puts "opcert=$opcert"
	    set err [verifysign $cert_fn "file"]
	    puts "CERIFYSYGN=$err"
	    return
	}
	1 {
#    puts "opcert=$opcert"
	    loadcrl $cert_hex 0
	}
	2 {
	    ::viewCert "file" $cert_fn
	}
	3 {
#    puts "opcert=$opcert"
	    set err [verifysign $cert_fn "file"]
	    if {$err == 0} {
#Передумали
		return
	    }
	    if {$err != 1} {
#		tk_messageBox -title [mc "Работа с сертификатом"] -icon error -message [mc "Сертификат не прошел проверку"] -parent .
		return
	    }
#DER в бинарнике
	    if {[catch {array set cert_parse [::pki::x509::parse_cert $asndata]} rc]} {
		tk_messageBox -title "Загрузка сертификата" -icon error -message "$cert_fn" -detail "Выбранный файл не содержит сертификата"
		return
	    }
	    set id_new_hex ""
    	    if {$::pkcs11_module == ""} {
    		tk_messageBox -title "Импорт сертификата на токен" -icon error -message "Выберите библиотеку PKCS#11 для токена"
    		return
    	    }
	    if {$::certegais == 1} {
		set tekt [clock format [clock seconds] -format {%y%m%d%H%M}]
		set labcert [nickforegais $cert_parse(subject)]

		if {$labcert == "" } {
		    tk_messageBox -title "Загрузка сертификата" -icon error -message "$tekt \n$cert_fn" -detail "Выбранный файл не содержит сертификата для ЕГАИС"
		    return
		}
#		set labcert "$tekt-$labcert"
#		puts "LABCERT_0=$labcert"
		set labcert [string trimleft $labcert "0"]
		set labcert "-$labcert"
#		puts "LABCERT=$labcert"
	    } else {
		set labcert [createnick $cert_parse(issuer) $cert_parse(subject)]
	    }

#puts "labcert=$labcert"
#Ввод PIN-кода
	    set yespas ""
	    set pass ""
	    set titpin "[mc {Token}]: $::slotid_teklab"
	    wm title .topPinPw $titpin
wm state . withdraw
	    wm state .topPinPw normal
	    wm state .topPinPw withdraw
	    wm state .topPinPw normal
	    raise .topPinPw
	    grab .topPinPw
	    focus .topPinPw.labFrPw.entryPw
	    set yespas ""
	    vwait yespas
	    grab release .topPinPw
wm state . normal
	    if { $yespas == "no" } {
		return
	    }
	    set yesno "no"

	    set uu [dict create pkcs11_handle $::handle]
	    dict set uu pkcs11_slotid $::slotid_tek
#	    puts "LISTforP11=$uu"
	    if { [pki::pkcs11::login $::handle $::slotid_tek $pass] == 0 } {
		tk_messageBox -title "Импорт сертификата" -icon info -message "[mc {Bad PIN}]"
		return
	    }
############Проверяем наличие сертификата на токене по классике и как у ЕГАИС-а##################
	    array set infopk [pki::pkcs11::pubkeyinfo $cert_hex) ] 
	    set allobjs [::pki::pkcs11::listobjects $::handle $::slotid_tek "cert"]
#    catch {::pki::pkcs11::logout $::handle $::slotid_tek}
	    set cert 0
#puts "LABCERT_1=$labcert"
	    binary scan $labcert H* labcert_hex
#puts "LABCERT_1_hex=$labcert_hex"
	    foreach obj $allobjs {
		foreach {type handle label id} $obj {
#puts "LabPrKey=$label"
#puts "LabPrKey id=$id"
		    set id_len [string length $id]
		    if {$id_len == 40} {
			if {$id == $infopk(pkcs11_id)} {
			    set cert 1
			    break
			}
		    } else {
			if {[string first $labcert_hex $id] != -1} {
			    set cert 1
			    break
			}
		    }
		}
		if {$cert == 1 } {
		    break
		}
	    }
	    if {$cert == 1} {
		tk_messageBox -title "Импорт сертификата" -icon info -message "Сертификат уже уствновлен" \
			 -detail "Если вы хотите его переустановить, что сначало удалите старый экземпляр"
		return
	    }


################################################
	    if {$::certegais != 1} {
		lappend uu "pkcs11_label"
		lappend uu $labcert
		if {[catch {set pkcs11id [pki::pkcs11::importcert $cert_hex $uu]} res] } {
		    tk_messageBox -title "Импорт сертификата" -icon info -message [mc "Cannot import this certificate\n"] -detail $res 
		    return 
		}
		set uu [dict create pkcs11_handle $::handle]
		dict set uu pkcs11_slotid $::slotid_tek
		lappend uu "pkcs11_id"
		lappend uu $pkcs11id
		lappend uu "pkcs11_label"
		lappend uu "$labcert"
		pki::pkcs11::rename all $uu
		set id_new_hex $pkcs11id
#puts "Установлена метка $labcert"
	    } else {
########
#Получаем метку ключа, которая станет новым CKA_ID тройки
		set allobjs [::pki::pkcs11::listobjects $::handle $::slotid_tek "privkey"]
#    catch {::pki::pkcs11::logout $::handle $::slotid_tek}
		set prkey 0
puts "LABCERT_1=$labcert"
		foreach obj $allobjs {
		    foreach {type handle label id} $obj {
puts "LabPrKey=$label"
puts "LabPrKey id=$id"
			set id_len [string length $id]
			if {$id_len == 40} {
			    if {$id == $infopk(pkcs11_id)} {
				set prkey 1
				binary scan $label H* id_new_hex
				break
			    }
			} else {
			    if {[string first $labcert $label] != -1} {
				set prkey 1
				binary scan $label H* id_new_hex
				break
			    }
			}
		    }
		    if {$prkey == 1} {
			break
		    }
		}
		if {$prkey == 0} {
		    unset uu
		    set uu [dict create pkcs11_handle $::handle]
		    dict set uu pkcs11_slotid $::slotid_tek
		    lappend uu "pkcs11_id"
		    lappend uu $pkcs11id
		    pki::pkcs11::delete cert $uu
		    tk_messageBox -title "Импорт сертификата" -icon info -message "Нет закрытого ключа на этом токене\n для вашего сертификата" \
			 -detail "Сертификат не установлен\nЕсли вы все же хотите его установить, снимите пометку\n \"Сертификат для ЕГАИС\""
		    unset uu
		    return
		}
		lappend uu "pkcs11_label"
		lappend uu $label
		if {[catch {set pkcs11id [pki::pkcs11::importcert $cert_hex $uu]} res] } {
		    tk_messageBox -title "Импорт сертификата" -icon info -message [mc "Cannot import this certificate\n"] -detail $res 
		    return 
		}
		unset uu
		set uu [dict create pkcs11_handle $::handle]
		dict set uu pkcs11_slotid $::slotid_tek
		lappend uu "pkcs11_id"
		lappend uu $pkcs11id
		lappend uu "pkcs11_label"
		lappend uu "Certificate"
		pki::pkcs11::rename cert $uu
puts "LabPrKey id old=$pkcs11id"
puts "LabPrKey id_new=$id_new_hex"
########
		unset uu
		set uu [dict create pkcs11_handle $::handle]
		dict set uu pkcs11_slotid $::slotid_tek
		lappend uu "pkcs11_id"
		lappend uu $pkcs11id
		lappend uu "pkcs11_id_new"
		lappend uu "$id_new_hex"
		pki::pkcs11::rename all $uu
		set labcert "Certificate"
	    }
	    pki::pkcs11::logout $::handle $::slotid_tek
	    ::updatetok
	    set cnfromca [createnick $cert_parse(issuer) $cert_parse(subject)]
	    tk_messageBox -title "Импорт сертификата" -icon info -message "Сертификат \n$cnfromca\nимпортирован на токен:\n$::slotid_teklab" \
		     -detail "Метка сертификата (CKA_LABEL):\n$labcert\nCKA_ID (hex-формат):\n$id_new_hex"
	    return
	}
	default {
	    puts "Unknown operation=$opcert"
	}
    }
}


proc ::workOpP12 {} {
  variable pfx_fn
  global yespas
  global pass
  variable friendly
  variable src_fn
  variable top12
  variable exp12
  variable ts12
  variable cert_fn
  variable nickCert
  variable file_for_sign
#  puts "WORKOpP12:top12=$top12;typesave=$ts12"
  set i 0
  if {$::certfrompfx == ""} {
    tk_messageBox -title "Работа с PKCS12" -icon error -message "Не выбран файл с контейнером" -parent .
    return
  }
  set cert_hex $::certfrompfx

  switch $top12 {
    0 {
      if {$::pkcs11_module == ""} {
        tk_messageBox -title "Импорт сертификата на токен" -icon error -message "Выберите библиотеку PKCS#11 для токена"
        return
      }
      #    puts "opcert=$opcert"
      set err [verifysign $cert_hex "pkcs11"]
      if {$err == 0} {
        #Передумали
        return
      }
      if {$err != 1} {
        #		tk_messageBox -title [mc "Работа с сертификатом"] -icon error -message [mc "Сертификат не прошел проверку"] -parent .
        return
      }
      #DER в бинарнике
      set asndata [binary format H* $cert_hex]
      if {[catch {array set cert_parse [::pki::x509::parse_cert $asndata]} rc]} {
        tk_messageBox -title [mc "Load certificate from PKCS12"] -icon error -message "$friendly" -detail [mc "The selected file does not contain a certificate"]
        return
      }

      set labcert [createnick $cert_parse(issuer) $cert_parse(subject)]
      #puts "labcert=$labcert"
      #Ввод PIN-кода
      set yespas ""
      set pass ""
      set titpin "[mc {Token}]: $::slotid_teklab"
      wm title .topPinPw $titpin
wm state . withdraw
      wm state .topPinPw normal
      wm state .topPinPw withdraw
      wm state .topPinPw normal
      raise .topPinPw
      grab .topPinPw
      focus .topPinPw.labFrPw.entryPw
      set yespas ""
      vwait yespas
      grab release .topPinPw
wm state . normal
      if { $yespas == "no" } {
        return
      }
      set yesno "no"

      set uu [dict create pkcs11_handle $::handle]
      dict set uu pkcs11_slotid $::slotid_tek
      lappend uu "pkcs11_label"
      lappend uu $labcert
      puts "LISTforP11=$uu"
                        	
      if {[catch {set pkcs11id [pki::pkcs11::importcert $cert_hex $uu]} res] } {
        tk_messageBox -title "Импорт из контейнера PKCS#12" -icon info -message "Не удалось импортировать сертификат из PKCS#12\n" -detail $res
        return
      }

      unset uu
      set uu [dict create pkcs11_handle $::handle]
      dict set uu pkcs11_slotid $::slotid_tek
      lappend uu "pkcs11_id"
      lappend uu $pkcs11id
      lappend uu "pkcs11_label"
      lappend uu "$labcert"
      if { [pki::pkcs11::login $::handle $::slotid_tek $pass] == 0 } {
        tk_messageBox -title "Импорт из контейнера PKCS#12" -icon info -message "Плохой PIN-код"
        return
      }
      pki::pkcs11::rename all $uu
      pki::pkcs11::logout $::handle $::slotid_tek
      #puts "Установлена метка $labcert"
                        	
      ::updatetok
      tk_messageBox -title "Импорт из контейнера PKCS#12" -icon info -message "Импорт из контейнера PKCS#12 \n$pkcs11id" -detail "$labcert"
      return
    }
    1 {
      #Ввод PIN-кода
      if {$::pkcs11_module == ""} {
        tk_messageBox -title "Импорт закрытого ключа на токен" -icon error -message "Выберите библиотеку PKCS#11 для токена"
        return
      }
      set yespas ""
      set pass ""
      set titpin "[mc {Token}]: $::slotid_teklab"
      wm title .topPinPw $titpin
wm state . withdraw
      wm state .topPinPw normal
      wm state .topPinPw withdraw
      wm state .topPinPw normal
      raise .topPinPw
      grab .topPinPw
      focus .topPinPw.labFrPw.entryPw
      set yespas ""
      vwait yespas
      grab release .topPinPw
wm state . normal
      if { $yespas == "no" } {
        return
      }
      set yesno "no"
      #DER в бинарнике
      set asndata [binary format H* $cert_hex]
      array set infopk [pki::pkcs11::pubkeyinfo $cert_hex  [list pkcs11_handle $::handle pkcs11_slotid $::slotid_tek]]
      #parray infopk
      array set cert_parse [::pki::x509::parse_cert $asndata]
      set labcert [createnick $cert_parse(issuer) $cert_parse(subject)]

      binary scan $::private_key_str H* private_key_str_hex
      binary scan $::public_key_str H* public_key_str_hex
      set asnhash [::asn::asnObjectIdentifier $::gost3411Paramset]
      binary scan $asnhash H* asnhash_hex
      set asnsign [::asn::asnObjectIdentifier $::gost3410Paramset]
      binary scan $asnsign H* asnsign_hex
      set asnsign1 $asnsign
      set asnhash1 $asnhash
      ::asn::asnGetObjectIdentifier asnsign1 oidparsign
      ::asn::asnGetObjectIdentifier asnhash1 oidparhash
      set par "pkcs11_id=$infopk(pkcs11_id)\nlabcert=$labcert\npubkey_algo=$cert_parse(pubkey_algo) ([::pki::_oid_name_to_number $cert_parse(pubkey_algo)])\nprivate_key=xxx...xxx\npublic_key=$public_key_str_hex\n\
      paramhash=$asnhash_hex ($oidparhash)\nparamsign=$asnsign_hex ($oidparsign)"
      tk_messageBox -title "Импорт закрытого ключа" -icon info -message "Импорт закрытого ключа из PKCS#12 на токен \n$::slotid_teklab" -detail "Информация о ключе\n$par\nfriendlyName=$friendly"
      if { [pki::pkcs11::login $::handle $::slotid_tek $pass] == 0 } {
        tk_messageBox -title [mc "Import certificate from PKCS12"] -icon error -message "[mc {Bad PIN}]"
        return
      }
      set uu [dict create pkcs11_handle $::handle]
      dict set uu pkcs11_slotid $::slotid_tek
      dict set uu pkcs11_label $labcert
      dict set uu pkcs11_id $infopk(pkcs11_id)
      dict set uu priv_value $private_key_str_hex
      if {$exp12 == 0} {
        dict set uu priv_export "true"
      } else {
        dict set uu priv_export "false"
      }
      dict set uu pub_value $public_key_str_hex
      dict set uu gosthash $asnhash_hex
      dict set uu gostsign $asnsign_hex
                        	
      #	    set impkey [pki::pkcs11::importkey $uu ]
      if {[catch {set impkey [pki::pkcs11::importkey $uu ]} res] } {
        set impkey 0
      }

      if {$impkey} {
        unset uu
        set uu [dict create pkcs11_handle $::handle]
        dict set uu pkcs11_slotid $::slotid_tek
        lappend uu "pkcs11_id"
        lappend uu $infopk(pkcs11_id)
        lappend uu "pkcs11_label"
        lappend uu "$labcert"
        pki::pkcs11::rename all $uu
        tk_messageBox -title "Импорт из контейнера PKCS#12" -icon info -message "Ключевая пара успешно импортирована" -detail "CKA_LABEL: $labcert\nCKA_ID: $infopk(pkcs11_id)"
      } else {
        tk_messageBox -title "Импорт из контейнера PKCS#12" -icon error -message "Импор ключевой пары не удался" -detail "$res"
      }
      unset uu
      return
    }
    2 {
	if {$file_for_sign == "" } {
	    tk_messageBox -title "Экспорт сертификата" -message "Не выбрана папка для сертификата" -icon error  -parent .
	    return
	}
	set certder [binary format H* $cert_hex]
	set f [file join $file_for_sign [file rootname [file tail $pfx_fn]]]
	if {$ts12 == 1} {
	    set fs "$f.pem"
	    set cert [::pki::_encode_pem $certder "-----BEGIN CERTIFICATE-----" "-----END CERTIFICATE-----"]
	} else {
	    set cert $certder
	    set fs "$f.der"
	}
	set x [catch {set fid [open $fs w+]}]
	set y [catch {puts $fid "#http://soft.lissi.ru\n"}]
	set z [catch {close $fid}]
	if { $x || $y || $z || ![file exists $fs] || ![file isfile $fs] || ![file readable $fs] } {
	    tk_messageBox -parent . -icon error  -message "Невозможно записать сертификат в этот файл:\n \"$fs\""
	    return
	}
	file delete -force $fs
	set fd [open $fs w]
	chan configure $fd -translation binary
	puts -nonewline $fd $cert
	close $fd
	set tit "Экспорт сертификатаа"
	if {![file exists $fs]} {
	    tk_messageBox -title $tit -icon error -message "Ошибка записи файла\n $fs" -parent .
	    return
	}
	if {![file size $fs]} {
	    tk_messageBox -title $tit -icon error -message "Ошибка записи файла\n $fs" -parent .
	    return
	}
	tk_messageBox -title $tit -icon info -message "Сертифмкат сохранен в файле" -detail "$fs" -parent .

#      saveCert $ts12 $certder
      return
    }

    default {
      puts "Unknown operation=$top12"
    }
  }
}

proc ::workOp {} {
  global typesys
  variable createTimeStamp
  variable createescTS
  variable varescTS
  global yespas
  global pass
  global myHOME
  variable ::lcerts
  variable src_fn
  variable nickCert
  variable typeop
  variable typesave
  variable p7s_fn
  set c ".st.fr1.fr2_list2"
  #    puts "typeop=$typeop"
  #    puts "WORKOP:c=$c"
  set i 0
  if {$p7s_fn == ""} {
    tk_messageBox -title [mc "Работа с PKCS7"] -icon error -message [mc "Не выбран файл с электронной подписью"] -parent .
    return
  }
  array set p7 []
  foreach p7t $::lp7 {
    array set p7 $p7t
    if {$::signedCert == $p7(nickcert)} {
      set i 1
      break
    }
  }
  if {$i != 1 && $typeop != 4} {
    tk_messageBox -title [mc "Работа с PKCS7"] -icon error -message [mc "Перегрузите файл с электронной подписью"] -parent .
    return
  }
  switch $typeop {
    0 {
      if {$src_fn == "" } {
        tk_messageBox -title "Проверка подписи" -icon info -message [mc "Не выбран документ для проверки"] -parent .
        return
      }
      if {$p7(messageDigestTek) != ""} {
        if {$p7(messageDigestTek) != $p7(messageDigest)} {
          tk_messageBox -title "Проверка подписи" -icon info -message "Файл с подписью поврежден" -detail "или неподдерживаемая подпись\n$p7(digestalgo)" -parent .
          return
        }
      }
      set file $src_fn
      if {![file exists $file]} {
        tk_messageBox -title "Проверка подписи" -icon info -message "Файла с документом не существует" -parent .
        return
      }
      #puts "Loading content file: $file"
      set fd [open $file]
      chan configure $fd -translation binary
      set data [read $fd]
      close $fd
      binary scan $data  H* ret(context_hex)
      #Проверяем хэш контента
      set oidhash $p7(digestalgo)
      switch -- $oidhash {
        "1.2.643.7.1.1.2.2" - "1 2 643 7 1 1 2 2" {
          #    "GOST R 34.11-2012-256"
          set digest_algo "stribog256"
	  set digest_len 32
        }
        "1.2.643.7.1.1.2.3" - "1 2 643 7 1 1 2 3" {
          #     "GOST R 34.11-2012-512"
          set digest_algo "stribog512"
	  set digest_len 64
        }
        default {
          tk_messageBox -title "Проверка подписи" -icon info -message "Невозможно проверить контент" -detail "Не известный алгоритм:\n\t$oidhash" -parent .
          return
        }
      }
#      set aa [dict create pkcs11_handle $::handle pkcs11_slotid $::slotid_tek]
#      set digest_mes_hex    [pki::pkcs11::digest $digest_algo $data $aa]
      set digest_mes_bin [lcc_gost3411_2012 $digest_len $data]
      binary scan $digest_mes_bin H* digest_mes_hex

      if {$digest_mes_hex != $p7(messageDigest) } {
        tk_messageBox -title "Проверка подписи" -icon info -message "Подпись не от указанного документа" -parent .
        return
      }
      if {$p7(cert_hex) == ""} {
        tk_messageBox -title "Проверка подписи" -icon info -message "Отсутствует сертификат подписанта" -parent .
        return
      }

      set p7signerinfo "31[string range $p7(signerinfo) 2 end]"
      set signerinfo [binary format H* $p7signerinfo]
#      set signerinfo_hex    [pki::pkcs11::digest $digest_algo $signerinfo $aa]
      set signerinfo_bin [lcc_gost3411_2012 $digest_len $signerinfo]
      binary scan $signerinfo_bin H* signerinfo_hex

      set p7cert_bin [binary format H* $p7(cert_hex)]
      array set p7certparse [::pki::x509::parse_cert $p7cert_bin]
      array set infopk [parse_key_gost $p7certparse(pubkeyinfo_hex)]
#parray infopk
    set parid "$infopk(paramkey)"
    set parid $::param3410($parid)
#puts "parid=\"$parid\""

    set signature_str [binary format H* $p7(signature)]
    if {$infopk(pubkey_algo) == "1 2 643 7 1 1 1 1"} {
      set group [lcc_gost3410_2012_256_getGroupById "$parid"]
      set public_key_str [string range $infopk(pubkey) 4 end]
      set public_key_str [binary format H* $public_key_str]
      set verify [lcc_gost3410_2012_256_verify $group $public_key_str $signerinfo_bin $signature_str]
    } elseif {$infopk(pubkey_algo) == "1 2 643 7 1 1 1 2"} {
      set group [lcc_gost3410_2012_512_getGroupById "$parid"]
      set public_key_str [string range $infopk(pubkey) 6 end]
      set public_key_str [binary format H* $public_key_str]
      set verify [lcc_gost3410_2012_512_verify $group $public_key_str $signerinfo_bin $signature_str]
    } else {
      tk_messageBox -title "Проверка подписи" -icon error -message "Неподдерживаемый тип ключа" -detail "$infopk(pubkey_algo)"  -parent .
      return
    }


      if {$verify != 1} {
        tk_messageBox -title "Проверка подписи" -icon error -message "Подпись не прошла проверку"  -parent .
      } else {
        tk_messageBox -title "Проверка подписи" -icon info -message "Подпись документа верна" -detail "$::dateSign\n$::dateSignTST" -parent .
      }
  }
    1 {
      if {$p7(attached) == 0} {
        tk_messageBox -title "Извлечение подписанного документа" -icon info -message "Подпись отсоединенная. Документ отсутствует." -parent .
        return
      }
      set cont [binary  format H* $p7(context_hex)]
      saveCert 2 $cont
    }
    2 {
      #puts "WORKOP save cert:c=$c"
      #puts "typesave=$typesave"
      set ::dercert [binary  format H* $p7(cert_hex)]
      if {$::dercert == ""} {
        tk_messageBox -title "Извлечение сертификата подписанта" -icon info -message "Сертификат подписанта отсутствует" -parent .
        return
      }
      saveCert $typesave $::dercert
    }
    3 {
#В данной версии этот пункт не нужен
      #puts "sifn_file=$nickCert"
      #puts "varescTS=$varescTS createescTS=$createescTS"
      set createescTS $varescTS
      #puts "varescTS=$varescTS createescTS=$createescTS"
      set  ::tekTSP $::tekTSPadd

      if {$src_fn == "" } {
        #		tk_messageBox -title [mc "Verify signature"] -icon info -message [mc "Signed detached. Not content"] -parent .
        tk_messageBox -title "Добавить подпись" -icon info -message "Не выбран документ для проверки" -parent .
        return
      }
      if {$::p7s_hex == "" } {
        tk_messageBox -title "Добавить подпись" -icon info -message "Не выбран файл с электронной подписью" -parent .
        return
      }
      set file $src_fn
      if {![file exists $file]} {
        tk_messageBox -title "Добавить подпись" -icon info -message "Файл с документом не существует" -parent .
        return
      }
      #puts "sifn_file=$nickCert"
      ##################
      #Ввод PIN-кода
      wm title .topPinPw "[mc {Token}]: $::slotid_teklab"
      wm state .topPinPw normal
      wm state .topPinPw withdraw
      wm state .topPinPw normal
      raise .topPinPw
      grab .topPinPw
      focus .topPinPw.labFrPw.entryPw
      set yespass ""
      vwait yespas
      grab release .topPinPw
      if { $yespas == "no" } {
        return 0
      }
      set yespas "no"
      set password $pass
      set pass ""
                        	
      if { [pki::pkcs11::login $::handle $::slotid_tek $password] == 0 } {
        tk_messageBox -title "Добавить подпись" -message "Документ подписать не удалось" -detail "Неверный PIN-код" -icon error  -parent .
        return
      }
      set password ""
      set privkey [::pki::pkcs11::listobjects $::handle $::slotid_tek  privkey]
      #	    puts "PRIVKEY=$privkey"
      set i 0
      foreach prkey $privkey {
        if {$nickCert == [lindex $prkey 2]} {
          set i 1
          break
        }
      }
      if {$i == 0 } {
        tk_messageBox -title "Добавить подпись" -message "Документ подписать не удалось" -detail "У сертификата \n$nickCert\n нет закрытого ключа" -icon error  -parent .
        catch {::pki::pkcs11::logout $::handle $::slotid_tek}
        return
      }
      #####################
      set cert_derhex ""
      foreach certinfo_list $::certs_p11 {
        unset -nocomplain cert_parse
        array set cert_parse_der $certinfo_list
        if {$cert_parse_der(pkcs11_label) == $nickCert} {
          set cert_derhex  $cert_parse_der(cert_der)
          break
        }
      }
      if {$cert_derhex == ""} {
        tk_messageBox -title "Добавить подпись" -message "На токене отсутствует сертификат подписанта:" -detail "\t$nickCert" -icon error  -parent .
        catch {::pki::pkcs11::logout $::handle $::slotid_tek}
        return
      }
      ####################################
      array set infopk [pki::pkcs11::pubkeyinfo $cert_derhex  [list pkcs11_handle $::handle pkcs11_slotid $::slotid_tek]]
      foreach p7t $::lp7 {
        array set p7 $p7t
        if {$infopk(issuer) == $p7(issuer) && $infopk(serial_number) == $p7(serial_number)} {
          tk_messageBox -title "Добавить подпись" -icon error -message "Уже имеется подпись для выбранного сертификата:" -detail $nickCert  -parent .
          catch {::pki::pkcs11::logout $::handle $::slotid_tek}
          return
        }
      }

      ##############################

      #puts "Loading content file for add_signature: $file"
      set fd [open $file]
      chan configure $fd -translation binary
      set content [read $fd]
      close $fd
      .topclock configure -text "Подписание документа"
      .topclock.lclock configure -text "Начался процесс подписания\n\nдокумента из файла\n\n[file tail $src_fn]\n\nПодождите некоторое время!"
      place .topclock -in $w -relx 0.1 -rely 0.2
      after 100
      update
                        	
      set pkcs7_new [::pki::pkcs7_add_signeddata $content $cert_derhex "pkcs11"  $::p7s_hex]
      catch {::pki::pkcs11::logout $::handle $::slotid_tek}
      if {$pkcs7_new == 0 } {
        tk_messageBox -title "Добавить подпись" -icon error -message "Не удалось добавить подпись"  -parent .
	place forget .topclock
        return
      }
      set fd [open $p7s_fn w]
      chan configure $fd -translation binary
      puts -nonewline $fd $pkcs7_new
      #puts -nonewline $fd $ret(contextforsign)
      close $fd
##################
      set pathsign [string map {"/" "/\n"} $p7s_fn]
#      set pathsign $p7s_fn

      tk_messageBox -icon question -title "Добавление подписи" -message "Подпись добавлена." -detail "Файл с подписями:\n$pathsign" 
      place forget .topclock
    }
    4 {
      variable ::lcerts
      variable typesave
      if {[llength $::lcerts] == 0 } {
        tk_messageBox -title "Сохранить сертификаты" -icon info -message "Нет сертификатов" -detail "File=$p7s_fn" -parent .
        return
      }
      set dir [tk_chooseDirectory -initialdir $myHOME -title "Выберите папку для сертификатов"]
      #puts "Сохранить все сертификаты в каталоге=$dir"
      if {$typesys == "win32" } {
        if { "after#" == [string range $dir 0 5] } {
          set dir ""
        }
      }
      if {$dir == ""} {
        return ""
      }
      set i 0
      set f [file tail $p7s_fn]
      set f [file rootname $f]
      set lfile ""
      if {$typesave} {
        set ext ".pem"
      } else {
        set ext ".der"
      }
      foreach cert_h $::lcerts {
                                		
        set cert [binary format H* $cert_h]
        set f1 "[file join $dir $f].cert$i$ext"
        append lfile "$f1.cert$i$ext\n"
        if {$typesave} {
          set cert [::pki::_encode_pem $cert "-----BEGIN CERTIFICATE-----" "-----END CERTIFICATE-----"]
        }
        set fd [open $f1 w]
        chan configure $fd -translation binary
        puts -nonewline $fd $cert
        close $fd
        incr i
      }
      tk_messageBox -title "Сохранить сертификаты" -icon info -message "Сертификаты сохранены в папке:\n\t$dir" -detail "$lfile" -parent .
    }
    5 {
      #Извлечь p7 со штампом времени
      if {$p7(timeStamp) != 1} {
        tk_messageBox -title "Сохранить метку времени" -icon info -message "Метка времени отсутствует" -parent .
        return
      }
      set p7tst [binary format H* $p7(p7timestamp_hex)]
      saveCert 3 $p7tst
    }
    default {
      puts "Unknown operation"
    }
}
}


proc ::loadchain {cert type} {
  global count
  global typesys
  global loadfile
  global myHOME
  set chaincert {}

  if {$cert == "" } {
    tk_messageBox -title "Загрузка цепочки сертификатов" -icon info -message "Сертификат не выбран"
    return -1
  }
  set data $cert
  set dir [tk_chooseDirectory -initialdir $myHOME -title "Выбор каталога для цепочки"]
  if {$typesys == "win32" } {
    if { "after#" == [string range $dir 0 5] } {
      set dir ""
    }
  }
  if {$dir == ""} {
    return ""
  }
  set ::listcert {}
  set count 0
  set depth [chainfromcert $data $dir]
  #    puts "DEPTH=$depth"
  #    puts $::listcert
  if {$depth == -1} {
    puts "Bad file with certificate=$file"
    return ""
  }
  set lenchain [llength $::listcert]
  set a ""
  set a "Файпы с сертификатами УЦ:\n\n"
  set caforver ""
  foreach b $::listcert {
    set caforver $b
    set a "$a  $b\n"
  }
  if {$type == "chain"} {
    tk_messageBox -title "Загрузка цепочки сертификатов" -icon info -message "Длина цепочки сертификатов УЦ - $lenchain" -detail $a
  }
  return $::listcert
}

proc ::verifysign {cert type} {
    global pass
    global yespas
    global ::nickTok
    global myHOME
    variable nickCert
    if {$type == "file"} {

	set fd [open $cert]
	chan configure $fd -translation binary
	set data [read $fd]
	close $fd
	set asndata [cert2der $data]
    } elseif {$type == "pkcs11"} {
	set asndata [binary format H* $cert]
    }
    if {$asndata == "" } {
	tk_messageBox -title "Проверка сертификата" -icon error -message "Файл $cert" -detail "Выбранный файл не содержит сертификата"
	return -1
    }

    if {[catch {array set cert_parse [::pki::x509::parse_cert $asndata]} rc]} {
	if {$type == "file"} {
	    tk_messageBox -title "Проверка сертификата" -icon error -message "$cert" -detail "Выбранный файл не содержит сертификата"
	    return -1
	} else {
	    tk_messageBox -title "Проверка сертификата" -icon error -message "$nickCert" -detail "Выбранный nick не связан с сертификатом"
	    return -1
	}
    }
    set cert_user $asndata
    set ::tekcert "file"

    set lcaforver [::loadchain $cert_user "ver"]
    set caforver [lindex $lcaforver 0]
#puts "caforver=$caforver"
    if {$caforver == "" } {
#	if {$cert_parse(issuer) == $cert_parse(subject)} {}
	if {$cert_parse(issuer) != $cert_parse(issuer)} {
	    set ms "Это корневой самоподписанный сертификат"
	    set dt "Валидность самоподписанного сертификата определяется владельцем"
	    tk_messageBox -title "Проверка подписи" -icon info -message $ms -detail $dt
	    set cert_CA $cert_user
	} else {
    	    set message "Невозможно загрузить сертификат издателя\nВы укажите файл с сертификатом издателя ?"
    	    set answer [tk_messageBox -icon question \
                -message $message \
                -title "Загрузка сертификата УЦ" \
                -detail "Невозможно проверить подпись сертификата" \
                -type yesno]

    	    if {$answer != "yes"} {
    		return 0
    	    }
    	    set typeFile {
		{"[mc {Certificate to DER format}]"    .der}
		{"[mc {Certificate to DER format}]"    .cer}
		{"[mc {Certificate to PEM format}]"    .pem}
		{"[mc {Certificate to PEM format}]"    .crt}
		{"[mc {All}]"    *}
	    }
	    set typeFile [subst $typeFile]
	    set titleS "Выбор файла с сертификатом УЦ"
	    set caforver [tk_getOpenFile -title $titleS -filetypes $typeFile -initialdir "$myHOME"]
	    if {$caforver == ""} {
		return 0
	    }
	    set fd [open $caforver]
	    chan configure $fd -translation binary
	    set data [read $fd]
	    close $fd
	    set cert_CA [cert2der $data]
	    set lcaforver $caforver
	}
    } else {
	set fd [open $caforver]
	chan configure $fd -translation binary
	set data [read $fd]
	close $fd
	set cert_CA [cert2der $data]
    }
    array set cert_parse_user [::pki::x509::parse_cert $cert_user]
    array set cert_parse_CA [::pki::x509::parse_cert $cert_CA]
    if {![info exists cert_parse_CA]} {
	tk_messageBox -title "Проверка подписи" -icon error -message "Плохой сертификат УЦ=$caforver"
	return 
    }
#Проверяем издателя
    if {$cert_parse_user(issuer) != $cert_parse_CA(subject)} {
	tk_messageBox -title "Проверка подписи" -icon info -message "Может быть Чужой сертификат УЦ=$caforver" \
		-detail "\"$cert_parse_user(issuer)\" != \"$cert_parse_CA(subject)\""
#	return
    }


    set tbs_cert [binary format H* $cert_parse_user(cert)]
#puts "SIGN_ALGO1=$cert_parse(signature_algo)"
    catch {set signature_algo_number [::pki::_oid_name_to_number $cert_parse_user(signature_algo)]}
    if {![info exists signature_algo_number]} {
	set signature_algo_number $cert_parse_user(signature_algo)
    }
#puts "SIGN_ALGO=$signature_algo_number"
    switch -- $signature_algo_number {
	"1.2.643.7.1.1.3.2" - "1 2 643 7 1 1 3 2" {
#     "GOST R 34.10-2012-256 with GOSTR 34.11-2012-256"
	    set digest_algo "stribog256"
	    set digest_len 32
	}
	"1.2.643.7.1.1.3.3" - "1 2 643 7 1 1 3 3" { 
#    "GOST R 34.10-2012-512 with GOSTR 34.11-2012-512"
	    set digest_algo "stribog512"
	    set digest_len 64
	}
        default {
	    tk_messageBox -title "Проверка подписи" -icon info -message "Невозможно проверить подпись" -detail "Неизвестный алгоритм подписи:\n\t$signature_algo_number" -parent .
	    return
	}
    }
#Посчитать хэш от tbs-сертификата!!!!
#    set digest_hex    [pki::pkcs11::digest $digest_algo $tbs_cert  $aa]
    set digest_bin [lcc_gost3411_2012 $digest_len $tbs_cert]
#Получаем asn-структуру публичного ключа
#Создаем список ключевых элементов

    binary scan $cert_CA H* cert_CA_hex
#################
      array set certparse [::pki::x509::parse_cert $cert_CA]
      array set infopk [parse_key_gost $certparse(pubkeyinfo_hex)]
#parray infopk
    set parid "$infopk(paramkey)"
    set parid $::param3410($parid)
#puts "parid=\"$parid\""
    set signature_str [binary format H* $cert_parse_user(signature)]
    if {$infopk(pubkey_algo) == "1 2 643 7 1 1 1 1"} {
      set group [lcc_gost3410_2012_256_getGroupById "$parid"]
      set public_key_str [string range $infopk(pubkey) 4 end]
      set public_key_str [binary format H* $public_key_str]
      set verify [lcc_gost3410_2012_256_verify $group $public_key_str $digest_bin $signature_str]
    } elseif {$infopk(pubkey_algo) == "1 2 643 7 1 1 1 2"} {
      set group [lcc_gost3410_2012_512_getGroupById "$parid"]
      set public_key_str [string range $infopk(pubkey) 6 end]
      set public_key_str [binary format H* $public_key_str]
      set verify [lcc_gost3410_2012_512_verify $group $public_key_str $digest_bin $signature_str]
    } else {
      tk_messageBox -title "Проверка подписи" -icon error -message "Неподдерживаемый тип ключа" -detail "$infopk(pubkey_algo)"  -parent .
      return
    }

##################
#Цепочка
    set lca ""
    set lenchain 0
    foreach b $lcaforver {
	set lca "$lca  $b\n"
	incr lenchain
    }
    set lenchain [llength $lcaforver]
    if {$verify != 1} {
	tk_messageBox -title "Проверка подписи" -icon info -message "Подпись сертификата" -detail "Электронная подпись плохая"
    } else {
	tk_messageBox -title "Проверка подписи" -icon info -message "Электронная подпись математически корректная" -detail "Длина цепочки сертификатов - $lenchain\n$lca"
    }
    return $verify
}


proc trace_signedcert {name index op } {
  set c ".fn2"
  variable varTypeSign
  variable varescTS
  upvar 1 $name nick
#  puts "trace_signedcert=$nick"
  foreach p7t $::lp7 {
    #puts "P7=$p7t"
    array set p7 $p7t
    #parray p7
    if {$nick == $p7(nickcert)} {
      set varTypeSign $p7(attached)
      set varescTS [expr $p7(esctimeStamp) + $p7(timeStamp)]
      set ::dateSign ""
      if {[info exists p7(signedTime)]} {
        set ::dateSign "Документ подписан: "
        set tt_utc [clock scan $p7(signedTime) -format {%y%m%d%H%M%SZ} -gmt 1]
        set ::dateSign "$::dateSign [clock format $tt_utc -format  {%H:%M:%S %d.%m.%Y}]"
        #puts "trace_signedcert=$::dateSign"
      }

      if {$p7(attached) == 0} {
	$c.lfr0.chb0 configure -text "Отсоединенная"
        tk_messageBox -title "Работа с PKCS7" -icon info -message "Подпись отсоединенная." -detail "Укажите путь с подписанному документу\nvarescTS=$varescTS" -parent .
      } else {
	$c.lfr0.chb0 configure -text "Присоединенная"
      }
      set ::dateSignTST "Метка времени получена: метка не получалась"
      if {[info exists p7(tstinfo)]} {
        switch -- $p7(tstdigest) {
          "1.2.643.7.1.1.2.2" - "1 2 643 7 1 1 2 2" {
            #    "GOST R 34.11-2012-256"
            set digest_algo "stribog256"
            set digest_len 32
          }
          "1.2.643.7.1.1.2.3" - "1 2 643 7 1 1 2 3" {
            #     "GOST R 34.11-2012-512"
            set digest_algo "stribog512"
            set digest_len 64
          }
          default {
            puts "Cannot veridy TST\nUnknown digestalgo=$p7(tstdigest)"
            return
          }
        }
        set signbin [binary format H* $p7(signature)]
#        set digest_hex    [pki::pkcs11::dgst $digest_algo $signbin ]
	set digest_bin [lcc_gost3411_2012 $digest_len $signbin]
	binary scan  $digest_bin H* digest_hex


        #puts "trace_signedcertTST=$p7(tstinfo)"
        set tstfull [binary format H* $p7(tstinfo)]
        asn::asnGetSequence tstfull tst
        ::asn::asnGetInteger tst version
        ::asn::asnGetObjectIdentifier tst oidDigest1
        #puts "oidDigest1=$oidDigest1"
        asn::asnGetSequence tst tst1
        asn::asnGetSequence tst1 tst2
        ::asn::asnGetObjectIdentifier tst2 oidDigest2
        #puts "oidDigest2=$oidDigest2"
        switch -- $oidDigest2 {
          "1.2.643.7.1.1.2.2" - "1 2 643 7 1 1 2 2" {
            #    "GOST R 34.11-2012-256"
            set digest_tsp "stribog256"
            set digest_tsp_len 32
          }
          "1.2.643.7.1.1.2.3" - "1 2 643 7 1 1 2 3" {
            #     "GOST R 34.11-2012-512"
            set digest_tsp "stribog512"
            set digest_tsp_len 64
          }
          default {
            puts "Cannot veridy TST\nUnknown digesttsp=$oidDigest2"
            return
          }
        }
        ::asn::asnGetOctetString tst1 digsign
        ::asn::asnGetBigInteger tst num1
        ::asn::asnGetGNTTime tst timetst
        #puts "timetst=$timetst"

        set ::dateSignTST "Метка времени получена: "
        set tt_utc [clock scan $timetst -format {%Y%m%d%H%M%SZ} -gmt 1]
        set ::dateSignTST "$::dateSignTST [clock format $tt_utc -format  {%H:%M:%S %d.%m.%Y}]"
                                		
        set signbin [binary format H* $p7(signature)]
#        set digest_hex    [pki::pkcs11::dgst $digest_algo $signbin ]
	set digest_bin [lcc_gost3411_2012 $digest_len $signbin]
	binary scan  $digest_bin H* digest_hex

#        set digesttsp_hex    [pki::pkcs11::dgst $digest_tsp $signbin ]
	set digesttsp_bin [lcc_gost3411_2012 $digest_tsp_len $signbin]
	binary scan  $digesttsp_bin H* digesttsp_hex

        binary scan $digsign H* digsign_hex
        if {$digsign_hex != $digesttsp_hex} {
          tk_messageBox -title "Работа с PKCS7" -icon error -message "Проверка штампа времени" -detail "Штамп времени не от этой подписи" -parent .
          set ::dateSignTST "Метка времени: Метка чужая"
        }

      }
      set ::dateSignEscTS "Метка утверждена: метка не получалась"
      if {[info exists p7(esctstinfo)]} {
        switch -- $p7(tstdigest) {
          "1.2.643.7.1.1.2.2" - "1 2 643 7 1 1 2 2" {
            #    "GOST R 34.11-2012-256"
            set digest_algo "stribog256"
            set digest_len 32
          }
          "1.2.643.7.1.1.2.3" - "1 2 643 7 1 1 2 3" {
            #     "GOST R 34.11-2012-512"
            set digest_algo "stribog512"
            set digest_len 64
          }
          default {
            puts "Cannot veridy TST\nUnknown digestalgo=$p7(tstdigest)"
            return
          }
        }
        set signbin [binary format H* $p7(signature)]
#        set digest_hex    [pki::pkcs11::dgst $digest_algo $signbin ]
	set digest_bin [lcc_gost3411_2012 $digest_len $signbin]
	binary scan  $digest_bin H* digest_hex

        #		set ::dateSignTST "Дата получения метки времени: Метка времени присутствует"
        #puts "trace_signedcertTST=$p7(tstinfo)"
        set tstfull [binary format H* $p7(esctstinfo)]
        asn::asnGetSequence tstfull tst
        ::asn::asnGetInteger tst version
        ::asn::asnGetObjectIdentifier tst oidDigest1
        #puts "oidDigest1=$oidDigest1"
        asn::asnGetSequence tst tst1
        asn::asnGetSequence tst1 tst2
        ::asn::asnGetObjectIdentifier tst2 oidDigest2
        #puts "oidDigest2=$oidDigest2"
        switch -- $oidDigest2 {
          "1.2.643.7.1.1.2.2" - "1 2 643 7 1 1 2 2" {
            #    "GOST R 34.11-2012-256"
            set digest_tsp "stribog256"
            set digest_tsp_len 32
          }
          "1.2.643.7.1.1.2.3" - "1 2 643 7 1 1 2 3" {
            #     "GOST R 34.11-2012-512"
            set digest_tsp "stribog512"
            set digest_tsp_len 64
          }
          default {
            puts "Cannot veridy TST\nUnknown digesttsp=$oidDigest2"
            return
          }
        }
        ::asn::asnGetOctetString tst1 digsign
        ::asn::asnGetBigInteger tst num1
        ::asn::asnGetGNTTime tst timetst
        #puts "timeescts=$timetst"

        set ::dateSignEscTS "Метка утверждена: "
        set tt_utc [clock scan $timetst -format {%Y%m%d%H%M%SZ} -gmt 1]
        set ::dateSignEscTS "$::dateSignEscTS [clock format $tt_utc -format  {%H:%M:%S %d.%m.%Y}]"
        #puts "ПРОВЕРКА escTS=$::dateSignEscTS"
        set signbin [binary format H* $p7(signature)]
        append signbin $p7(tst_der)
        append signbin $p7(certRefs_der)
        append signbin $p7(revokeRefs_der)
        #puts "digest_tsp=$digest_tsp"
        #puts "digest_algo=$digest_algo"
#        set digest_hex    [pki::pkcs11::dgst $digest_algo $signbin ]
	set digest_bin [lcc_gost3411_2012 $digest_len $signbin]
	binary scan  $digest_bin H* digest_hex

#        set digesttsp_hex    [pki::pkcs11::dgst $digest_tsp $signbin ]
	set digesttsp_bin [lcc_gost3411_2012 $digest_tsp_len $signbin]
	binary scan  $digesttsp_bin H* digesttsp_hex

        binary scan $digsign H* digsign_hex
        if {$digsign_hex != $digesttsp_hex} {
          tk_messageBox -title "Работа с PKCS7" -icon error -message "Проверка штампа времени" -detail "Штамп escTS не от этой подписи" -parent .
        }
      }
                        	
      break
    }
  }

}


proc trace_p7s {name index op} {
  variable p7s_fn
  variable varTypeSign
  variable ::listx509
  variable ::lcerts
  variable varTypeSign
  variable varescTS
  
#  set c ".st.fr1.fr2_list2"
  set c ".fn2"
  #    puts "TRACE_P7S"
  upvar 1 $name p7s
  #Что подписывали
  #puts "C=[$c.e2.entry get]"
  #parray p7s
  #puts "FILE_P7S=$p7s($index)"
  #puts "FILE_P7S=$p7s"
  #puts "INDEX=$index"
  #puts "OP=$op"
  set lp7s [::parse_pkcs7 "file" $p7s ""]
  #puts "LP7S=$lp7s"
  if {$lp7s == -1} {
    tk_messageBox -title "Работа с PKCS7" -icon info -message "Подпись с неподдерживаемым хэшем" -parent .
    return
  }
  foreach {::lcerts lcrls ::lp7} $lp7s {}
  if {![info exists ::lp7]} {
    tk_messageBox -title "Работа с PKCS7" -icon info -message "Файл не содержит подписи" -parent .
    set p7s_fn ""
    return
  }

  if {[llength [lindex $::lp7 0]] == 1} {
    puts "P7 BAD=$lp7"
    return
  }
  #puts "CERTS=$lcerts"

  set ::listx509 {}
  set i 0
  set ::signedCert ""
  foreach p7t $::lp7 {
    #puts "P7=$p7t"
    array set p7 $p7t
    #parray p7
    if {$i == 0} {
      set varTypeSign $p7(attached)
      set ::signedCert $p7(nickcert)
      incr i
    }
    #Ищем подписанта
    lappend ::listx509 $p7(nickcert)
  }
  #puts "lnicks=$::listx509"
  $c.frc.listCert configure -values $::listx509
#puts "varescTS=$varescTS"
    switch $varescTS {
	0 {
	    $c.lfr0.chb1 configure -text "CAdes-BES"
	}
	1 {
	    $c.lfr0.chb1 configure -text "CAdes-T"
	}
	2 {
	    $c.lfr0.chb1 configure -text "CAdes-XLT1"
	}
	default {
	    $c.lfr0.chb1 configure -text "Непонятно"
	}
    }
#puts "varTypeSign=$varTypeSign"
    switch $varTypeSign {
	0 {
	    $c.lfr0.chb0 configure -text "Отсоединенная"
	}
	1 {
	    $c.lfr0.chb0 configure -text "Присоединенная"
	}
	default {
	    $c.lfr0.chb0 configure -text "Непонятно"
	}
    }
}

proc trace_pfx {name index op} {
  global param3410
  variable friendly
  variable pfx_fn
  global yespas
  global pass
  variable varTypeSign
  variable ::listx509
  variable ::lcerts
  set c ".st.fr1.fr2_list8"
  #    puts "TRACE_PFX"
  upvar 1 $name pfx
  if {$pfx == ""} {

    return
  }
  set file [open $pfx]
  fconfigure $file -translation binary
  set indata [read $file]
  close $file
wm state . withdraw
  wm title .topPinPw "Введите пароль для PKCS#12"
  wm state .topPinPw normal
  wm state .topPinPw withdraw
  wm state .topPinPw normal
  .topPinPw.labFrPw configure -text "Введите пароль для \"[file tail $pfx]\""
  raise .topPinPw
  focus .topPinPw.labFrPw.entryPw
  grab .topPinPw
  set yespass ""
  vwait yespas
  grab release .topPinPw
wm state . normal


  #Ввод пароля
  .topPinPw.labFrPw configure -text "Введите PIN-код и нажмите ВВОД"
  if { $yespas == "no" } {
    set pfx_fn ""
    set friendly ""
    set ::certfrompfx ""
    return 0
  }
  set yespas "no"
  set password $pass
  set pass ""

  set p12er [catch {array set dCertKey [::GostPfx::pfxGetSingleCertKey $indata "$password" $::nomacver]} rp12]
  #    set p12er [catch {array set dCertKey [::GostPfx::pfxGetSingleKeyPair $indata $password 1]}]
  #    array set dCertKey [::GostPfx::pfxGetSingleCertKey $indata $password]
  if {$p12er} {
    tk_messageBox -title "Работа с PKCS12" -icon error -message "Это не PKCS12 (или старый PKCS12) или плохой пароль" -detail "Если вы уверены в пароле, то попробуйе отключить проверку mac (кнопка nomac)"  -parent .
    set pfx_fn ""
    set friendly ""
    set ::certfrompfx ""
    return
  }

  #    if {[dict exists $dCertKey certificate]} {}
  if {[info exists dCertKey(certificate)]} {
    if {[info exists dCertKey(friendlyName)]} {
      set friendly $dCertKey(friendlyName)
    } else {
      set friendly "Создать"
    }
    binary scan $dCertKey(certificate) H* ::certfrompfx
    set keyValue_hex ""
    if {[info exists dCertKey(keyValue)]} {
      set keyValueRev [string reverse $dCertKey(keyValue)]
      binary scan $keyValueRev H* keyValueRev_hex
      binary scan $dCertKey(keyValue) H* keyValue_hex
      set ::private_key_str $dCertKey(keyValue)
      #tk_messageBox -title "Работа с PKCS12" -icon info -message "Длина закрытого ключа" -detail "[string length $::private_key_str]"  -parent .
    }
    #	parray param3410
    set parid $param3410($dCertKey(gost3410Paramset))
    puts "TRACE_PFX parid=$parid"
    if {$dCertKey(keyAlg) == "1 2 643 7 1 1 1 1"} {
      set ::group [lcc_gost3410_2012_256_getGroupById "$parid"]
      #set public_key_str [gost3410_2012_256_createPublicKey $group $private_key_str]
      set public_key_str [lcc_gost3410_2012_256_createPublicKey $::group $dCertKey(keyValue)]
      binary scan $public_key_str H* public_key_str_hex
      set x_str [string range $public_key_str 0 31]
      set y_str [string range $public_key_str 32 63]
      binary scan $x_str H* x_str_hex
      binary scan $y_str H* y_str_hex
      #tk_messageBox -title "Работа с PKCS12" -icon info -message "Publickey 256=$public_key_str_hex" -detail "x_str=$x_str_hex\ny_str=$y_str_hex"  -parent .

    } elseif {$dCertKey(keyAlg) == "1 2 643 7 1 1 1 2"} {
      set ::group [lcc_gost3410_2012_512_getGroupById "$parid"]
      set public_key_str [lcc_gost3410_2012_512_createPublicKey $::group $dCertKey(keyValue)]
      binary scan $public_key_str H* public_key_str_hex
      set x_str [string range $public_key_str 0 63]
      set y_str [string range $public_key_str 64 128]
      binary scan $x_str H* x_str_hex
      binary scan $y_str H* y_str_hex
      #tk_messageBox -title "Работа с PKCS12" -icon info -message "Publickey 512=$public_key_str_hex" -detail "x_str=$x_str_hex\ny_str=$y_str_hex"  -parent .
    } else {
      tk_messageBox -title "Работа с PKCS12" -icon error -message "Неподдерживаемый тип ключа" -detail "$dCertKey(keyAlg)"  -parent .
      return
    }
    set ::public_key_str $public_key_str
    set ::gost3410Paramset  $dCertKey(gost3410Paramset)
    set ::gost3411Paramset  $dCertKey(gost3411Paramset)
    #	set privkey "keyAlg: $dCertKey(keyAlg)\ngost3410Paramset: $dCertKey(gost3410Paramset)\ngost3410Paramset: $parid\ngost3411Paramset: $dCertKey(gost3411Paramset)\nkeyValue: $keyValue_hex\nkeyValueRev: $keyValueRev_hex"
    #	tk_messageBox -title "Работа с PKCS12" -icon info -message "$friendly" -detail "$privkey"  -parent .
  } else {
    tk_messageBox -title "Работа с PKCS12" -icon error -message "Файл $pfx \nне содержит контейнер PKCS12" -parent .
  }
  return
}

proc addsignature {} {
    global yespas
    global pass
    variable nickCert
    variable p7s_fn
    variable src_fn
    variable storage
    set mesp11 "Вы хотите подписать документ \
сертификатом, хранящемся \
на токене PKCS11. \n\
   Если вы уверены, что правильно \
выбрали сертификат, то нажмите \
кнопку \"Да\".\n\
В противном случае нажмите \
кнопку \"Нет\"\n"
    set mesp12 "Вы хотите подписать документ \
сертификатом из защищенного \
контейнера PKCS12.\n\
   Если вы уверены, что правильно\
выбрали контейнер на вкладке\n\
\"Подписать документ\",\n\
или \"Работаем с PKCS12/PFX\", \
то нажмите кнопку \"Да\".\n\
В противном случае нажмите\
кнопку \"Нет\""
    if {$p7s_fn == ""} {
	tk_messageBox -title "Добавить подпись" -icon error -message [mc "Не выбран файл с электронной подписью"] -parent .
	return
    }
    if {$src_fn == "" } {
        tk_messageBox -title "Добавить подпись" -icon info -message "Не выбран документ для подписи" -parent .
        return
    }

    if {$storage == 0} {
	set mes $mesp11
    } else {
	set mes $mesp12
    }
    set answer [tk_messageBox -title "Добавить подпись" -icon question -message "Добавление новой подписи" -detail $mes -type yesno -parent .]
#wm state . normal
    if {$answer != "yes"} {
      puts "Передумали"
      return
    }
    set certforsign ""
    set typekey ""
puts "Добавляем подпись"
    if {$storage == 0} {
#Все как для PKCS12 c учетом выборки сертификата с токена - см. строку 5136 третий пункт
#    	    infotoken
#    	    return
      ##################
      #Ввод PIN-кода
wm state . withdraw
      wm title .topPinPw "Токен: $::slotid_teklab"
      wm state .topPinPw normal
      wm state .topPinPw withdraw
      wm state .topPinPw normal
      raise .topPinPw
      grab .topPinPw
      focus .topPinPw.labFrPw.entryPw
      set yespass ""
      vwait yespas
      grab release .topPinPw
wm state . normal
      if { $yespas == "no" } {
        return 0
      }
      set yespas "no"
      set password $pass
      set pass ""
                        	
      if { [pki::pkcs11::login $::handle $::slotid_tek $password] == 0 } {
        tk_messageBox -title "Добавить подпись" -message "Документ подписать не удалось" -detail "Неверный PIN-код" -icon error  -parent .
        return
      }
      set password ""
      set privkey [::pki::pkcs11::listobjects $::handle $::slotid_tek  privkey]
      #	    puts "PRIVKEY=$privkey"
      set i 0
      foreach prkey $privkey {
        if {$nickCert == [lindex $prkey 2]} {
          set i 1
          break
        }
      }
      if {$i == 0 } {
        tk_messageBox -title "Добавить подпись" -message "Документ подписать не удалось" -detail "У сертификата \n$nickCert\n нет закрытого ключа" -icon error  -parent .
        catch {::pki::pkcs11::logout $::handle $::slotid_tek}
        return
      }
      #####################
      set cert_derhex ""
      foreach certinfo_list $::certs_p11 {
        unset -nocomplain cert_parse
        array set cert_parse_der $certinfo_list
        if {$cert_parse_der(pkcs11_label) == $nickCert} {
          set cert_derhex  $cert_parse_der(cert_der)
          break
        }
      }
      if {$cert_derhex == ""} {
        tk_messageBox -title "Добавить подпись" -message "На токене отсутствует сертификат подписанта:" -detail "\t$nickCert" -icon error  -parent .
        catch {::pki::pkcs11::logout $::handle $::slotid_tek}
        return
      }
      ####################################
      array set infopk [pki::pkcs11::pubkeyinfo $cert_derhex  [list pkcs11_handle $::handle pkcs11_slotid $::slotid_tek]]
      foreach p7t $::lp7 {
        array set p7 $p7t
        if {$infopk(issuer) == $p7(issuer) && $infopk(serial_number) == $p7(serial_number)} {
          tk_messageBox -title [mc "Add signature"] -icon error -message [mc "Уже имеется подпись для выбранного сертификата:"] -detail $nickCert  -parent .
          catch {::pki::pkcs11::logout $::handle $::slotid_tek}
          return
        }
      }

      ##############################

	set certforsign $cert_derhex
	set typekey "pkcs11"
    } else {
#Добавка подписи на базе PKCS#12
	if {$::certfrompfx == "" } {
          tk_messageBox -title "Добавить подпись" -icon error -message "Не выбран контейнер PKCS12." \
             -detail "Зайдите на вкладку\n\"Работаем с PKCS12/PFX\"\n и выберите контейнер" -parent .
	    return
	}
	set certbin [binary format H* $::certfrompfx]
	array set infopk [pki::x509::parse_cert $certbin]
	foreach p7t $::lp7 {
	    array set p7 $p7t
    	    if {$infopk(issuer_hex) == $p7(issuer) && $infopk(serial_number_hex) == $p7(serial_number)} {
        	tk_messageBox -title "Добавить подпись" -icon info -message "Уже имеется подпись для\nвыбранного сертификата."  -parent .
        	return
    	    }
	}
	set certforsign $::certfrompfx
	set typekey "pkcs12"
    }

      #puts "Loading content file for add_signature: $file"
    set fd [open $src_fn]
    chan configure $fd -translation binary
    set content [read $fd]
    close $fd
    .topclock configure -text "Добавление подписи"
    .topclock.lclock configure -text "Начался процесс подписания\nдокумента из файла\n[file tail $src_fn]\nПодождите некоторое время!"

    place .topclock -in .fn2 -relx 0.1 -rely 0.2
    after 100
    update
    vwait ttt                        	
    set pkcs7_new [::pki::pkcs7_add_signeddata $content $certforsign $typekey  $::p7s_hex]
#after 3000
#set pkcs7_new 0
      if {$pkcs7_new == 0 } {
        tk_messageBox -title "Добавление подписи" -icon error -message "Не удалось добавить подпись"  -parent .
	place forget .topclock
        return
      }
      set fd [open $p7s_fn w]
      chan configure $fd -translation binary
      puts -nonewline $fd $pkcs7_new
      #puts -nonewline $fd $ret(contextforsign)
      close $fd
      set pathsign [string map {"/" "/\n"} $p7s_fn]
    tk_messageBox -title "Добавить подпись" -icon info -message "Подпись добавлена" -detail "Файл с подписями:\n$pathsign" -parent .
    set p7s_fn $p7s_fn
    place forget .topclock

}

#Подписываем документ с токена
proc func_page1 {c} {
  variable nickCert
  variable file_for_sign
  set file_for_sign ""
  variable doc_for_sign
  set doc_for_sign ""
  variable createTimeStamp
  set createTimeStamp 0
  variable createescTS
  set createescTS 0
  variable typesig
  set typesig 1
  variable friendly
  global macos
  global env
  global reqFL
  global typeCert
  global sodCert
  variable pfx_fn
  set pfx_fn ""
  variable src_fn
  set src_fn ""
  variable top12
  set top12 2
  variable ts12
  set ts12 0
  variable exp12
  set exp12 0
  variable varTypeSign
  set varTypeSign  0
puts "PAGE1=$c, $c.tok.listTok"
  set varescTS  0
    set filetypep12 {
	{{PKCS12} {.pfx}}
	{{PKCS12} {.p12}}
	{{All Files} *}
    }
    labelframe $c.tok -text "Выберите токен PKCS11"  -borderwidth 5
    ttk::combobox $c.tok.listTok -textvariable ::nickTok -values $::listtok
    set ::nickTok [lindex $::listtok 0]
#    button $c.tok.viewtok -command {if {[info exists nickCert]} {::viewCert "pkcs11" $nickCert}} -image ::img::view_18x16 -compound left -pady 0 -bd 0 -bg white -highlightthickness 0
    pack $c.tok.listTok -side top  -padx {2 1} -pady {1 0} -ipady 1  -expand 1 -fill x
#    pack $c.tok.viewtok -side right -padx {0 5} -pady 0 -expand 0 -fill none
    pack $c.tok -fill both -side top -padx 10 -pady {4 20}

    labelframe $c.cert -text "Сертификаты токена"  -borderwidth 5
    ttk::combobox $c.cert.listCert -textvariable nickCert -values $::listx509
#     -state readonly
    button $c.cert.viewcert -command {if {[info exists nickCert]} {::viewCert "pkcs11" $nickCert}} -image ::img::view_18x16 -compound left -pady 0 -bd 0 -bg white -highlightthickness 0
    pack $c.cert.listCert -side left  -padx {2 1} -pady {1 0} -ipady 1  -expand 1 -fill x
    pack $c.cert.viewcert -side right -padx {0 5} -pady 0 -expand 0 -fill none
    pack $c.cert -in $c.tok -fill both -side top -padx {2 1} -pady 4

#    ttk::labelframe $c.frdoc -text "Документ для подписи:"
    labelframe $c.frdoc -text "Документ для подписи:"
    set wd 30
    if {$macos} {
	set ft ""
    } else {
	set ft $::filetypesrc
    }
    cagui::FileEntry $c.frdoc.e1 -dialogtype open \
	-title "Выберите документ для подписи" \
	-width $wd \
	-defaultextension .txt \
	-variable  doc_for_sign \
	-initialdir $::myHOME \
	-filetypes $ft
    pack $c.frdoc.e1 -side right  -padx {2 1} -pady {1 0} -ipady 1  -expand 1 -fill x
    pack $c.frdoc -fill both -side top -padx 10

#    ttk::labelframe $c.frdir -text "Папка для подписи:"
    labelframe $c.frdir -text "Папка для подписи:"
    cagui::FileEntry $c.frdir.e2 -dialogtype directory \
	-title "Папка для хранения подписи" \
	-width $wd \
	-variable  file_for_sign \
	-initialdir $::myHOME
    pack $c.frdir.e2 -side right  -padx {2 1} -pady {1 0} -ipady 1  -expand 1 -fill x
    pack $c.frdir -fill both -side top -padx 10  -pady 8

  labelframe $c.lfr0 -text "Тип электронной подписи"  -labelanchor n
  ttk::radiobutton $c.lfr0.rb1 -value 1 -variable typesig -text "Присоединенная"
  ttk::radiobutton $c.lfr0.rb2 -value 0 -variable typesig -text "Отсоединенная"
  grid $c.lfr0.rb1 -row 0 -column 0 -sticky wsen -padx {3 0} -pady {0 4}
  grid $c.lfr0.rb2 -row 0 -column 1 -sticky wsen -padx {0 0} -pady {0 4}
    pack $c.lfr0 -fill both -side top -padx 10

  labelframe $c.lfr1 -text "Формат подписи" -labelanchor n
  ttk::radiobutton $c.lfr1.chb1 -value 0 -variable createescTS -text "CAdes-BES"
  ttk::radiobutton $c.lfr1.chb2 -value 1 -variable createescTS -text "CAdes-T"
  ttk::radiobutton $c.lfr1.chb3 -value 2 -variable createescTS -text "CAdes-XLT1"
  grid $c.lfr1.chb1 -row 0 -column 0 -sticky w -padx {8 8} -pady {4 4}
  grid $c.lfr1.chb2 -row 0 -column 1 -sticky w -padx {8 8} -pady {4 4}
  grid $c.lfr1.chb3 -row 0 -column 2 -sticky w -padx {8 8} -pady {4 4}
    pack $c.lfr1 -fill both -side top -padx 10
#########################
    labelframe $c.tsp -text "Сервер TSP:"
    if {$macos} {
	spinbox $c.tsp.listTSP  -textvariable ::tekTSP -values $::listtsp -width $wd -background white
    } else {
	ttk::combobox $c.tsp.listTSP  -textvariable ::tekTSP -values $::listtsp -width $wd -background white -style TCombobox
    }
    set ::tekTSP [lindex $::listtsp 0]
    pack $c.tsp -side left -pady 4
    pack $c.tsp.listTSP -side left -fill x -expand 1 -pady {0 4}
    pack $c.tsp -fill both -side top -padx 10
    label $c.tekclock -textvariable myclock -background skyblue
    pack $c.tekclock -side top -anchor center -padx 5 -pady 4 -fill x -padx 10

    set com "ttk::button  $c.b2 -command {::sign_file  $c \"pkcs11\"} -text \"Подписать документ\""
    eval [subst $com]
#    pack $c.b2 -side top -anchor nw -padx 5 -pady 4
    pack $c.b2 -side top -anchor center -padx 5 -pady 4

     clock:set myclock          ;# call once, keeps ticking ;-) RS

}

#Страница работы с PKCS#7
proc func_page2 {c} {
  global macos
  global reqFL
  global typeCert
  global sodCert
  variable p7s_fn
  set p7s_fn ""
  variable src_fn
  set src_fn ""
  variable typeop
  set typeop 0
  variable typesave
  set typesave 0
  variable varTypeSign
  set varTypeSign  0
  set varescTS  0
  variable nickCert
  set filetypep7s {
    {{PKCS7 (DER)} {.p7s}}
    {{PKCS7 (DER)} {.sig}}
    {{PKCS7 (DER)} {.p7b}}
    {{PKCS7 (PEM)} {.pem}}
    {{All Files} *}
  }
    labelframe $c.tok -text "Сертификаты токена"  -borderwidth 5
    ttk::combobox $c.tok.listCert -textvariable nickCert -values $::listx509
#     -state readonly
    button $c.tok.viewcert -command {if {[info exists nickCert]} {::viewCert "pkcs11" $nickCert}} -image ::img::view_18x16 -compound left -pady 0 -bd 0 -bg white -highlightthickness 0
    pack $c.tok.listCert -side left  -padx {2 1} -pady {1 0} -ipady 1  -expand 1 -fill x
    pack $c.tok.viewcert -side right -padx {0 5} -pady 0 -expand 0 -fill none
    pack $c.tok -fill both -side top -padx 10 -pady 4

#    ttk::labelframe $c.fr0 -text "Файл с PKCS12" 
    labelframe $c.fr0 -text "Файл с электронной подписью (PKCS7)"  -borderwidth 5
    cagui::FileEntry $c.fr0.e1 -dialogtype open \
	-title "Файл с PKCS7" \
	-width 30 \
	-defaultextension .p7s \
	-variable p7s_fn \
	-initialdir $::myHOME \
	-filetypes $filetypep7s
    pack $c.fr0.e1 -side right  -padx {2 1} -pady {1 0} -ipady 1  -expand 1 -fill x
    pack $c.fr0 -fill both -side top -padx 10
#    ttk::labelframe $c.lfr0 -text "Тип и формат электронной подписи"  -labelanchor n
    labelframe $c.lfr0 -text "Тип и формат электронной подписи"  -labelanchor n

variable typesig1
variable createescTS1
set typesig1 1
set createescTS1 0
    ttk::checkbutton $c.lfr0.chb0 -variable typesig1 -text "Формат подписи" -pad 0  -command {variable typesig1;set typesig1 1}
    ttk::radiobutton $c.lfr0.chb1 -value 0 -variable createescTS1 -text "Тип подписи" -pad 0 
    grid $c.lfr0.chb0 -row 0 -column 0 -sticky swen -padx {14 0} -pady {0 12} -ipadx 5
    grid $c.lfr0.chb1 -row 0 -column 1 -sticky swen -padx {14 0} -pady {0 12} -ipadx 5
if {0} {
    ttk::checkbutton $c.lfr0.chb0 -variable typesig -text "Присоединенная" -pad 0
    ttk::radiobutton $c.lfr0.chb1 -value 0 -variable createescTS -text "CAdes-BES" -pad 0
    ttk::radiobutton $c.lfr0.chb2 -value 1 -variable createescTS -text "CAdes-T" -pad 0
    ttk::radiobutton $c.lfr0.chb3 -value 2 -variable createescTS -text "CAdes-XLT1" -pad 0
    grid $c.lfr0.chb0 -row 0 -column 0 -columnspan 3 -sticky w -padx {14 0} -pady {0 12}
    grid $c.lfr0.chb1 -row 1 -column 0 -sticky w -padx {14 0} -pady {0 12}
    grid $c.lfr0.chb2 -row 1 -column 1 -sticky w -padx {10 0} -pady {0 12}
    grid $c.lfr0.chb3 -row 1 -column 2 -sticky w -padx {10 0} -pady {0 12}
}
    pack $c.lfr0 -fill both -side top -padx 10 -pady 8

#    ttk::labelframe $c.frc -text "Просмотр сертификата из контейнера"
    labelframe $c.frc -text "Сертификаты подписантов"
    set ::nomacver 0
#    label $c.frc.labCert -text "friendlyName:" -anchor w -width 0 -bg white
#    pack $c.frc.labCert  -padx 0 -pady 0 -side left  -expand 0 -fill both
#    ttk::entry $c.frc.listCert -textvariable friendly -state normal 
    ttk::combobox $c.frc.listCert -textvariable ::signedCert  -values $::listx509 -background white -style TCombobox
    pack $c.frc.listCert -side left  -padx 4 -pady 0 -expand 1 -fill x
    button  $c.frc.viewcert -command {if {[info exists ::signedCert]} {::viewCert "pkcs7" $::signedCert}} -image ::img::view_18x16 -compound left -pady 0 -bd 0 -bg white -activebackground white -highlightthickness 0
    pack $c.frc.viewcert -side right -padx {0 5} -pady 0 -expand 0 -fill none
    pack $c.frc -fill both -side top -padx 10 -pady 0
    label $c.l3 -text "Документ подписан:" -textvariable ::dateSign -anchor w -bg white  -width 0 -height 0 -pady 0
    pack $c.l3 -fill both -side top -padx 10 -pady 0
    label $c.l4 -text "Метка времени получена:" -textvariable ::dateSignTST -anchor w -bg white  -width 0 -height 0 -pady 0
    pack $c.l4 -fill both -side top -padx 10 -pady 0 
    label $c.l5 -text "Метка утверждена:" -textvariable ::dateSignEscTS -anchor w -bg white  -width 0 -height 0 -pady 0
    pack $c.l5 -fill both -side top -padx 10 -pady 0

#    ttk::labelframe $c.frdoc -text "Документ для подписи:"
    labelframe $c.frdoc -text "Подписанный документ:"
    set wd 30
    if {$macos} {
	set ft ""
    } else {
	set ft $::filetypesrc
    }
    cagui::FileEntry $c.frdoc.e1 -dialogtype open \
	-title "Выберите полписанный документ" \
	-width $wd \
	-defaultextension .txt \
	-variable  src_fn \
	-initialdir $::myHOME \
	-filetypes $ft
    pack $c.frdoc.e1 -side right  -padx {2 1} -pady {1 0} -ipady 1  -expand 1 -fill x
    pack $c.frdoc -fill both -side top -padx 10

    ttk::frame $c.tsp
    label $c.tsp.tsp -text "Сервер TSP:" -anchor w -bg white  -width 0 -height 0
    if {$macos} {
	spinbox $c.tsp.listTSP  -textvariable ::tekTSP -values $::listtsp -width $wd -background white
    } else {
	ttk::combobox $c.tsp.listTSP  -textvariable ::tekTSP -values $::listtsp -width $wd -background white -style TCombobox
    }
    set ::tekTSP [lindex $::listtsp 0]
    pack $c.tsp.tsp -side left
    pack $c.tsp.listTSP -side left -fill x -expand 1
    pack $c.tsp -fill both -side top -padx 10
  labelframe $c.lfr1 -text "Дополнительные операции"
  ttk::radiobutton $c.lfr1.rb1 -value 0 -variable typeop -text "Проверить подпись"
  ttk::radiobutton $c.lfr1.rb2 -value 1 -variable typeop -text "Извлечь документ"
#  ttk::radiobutton $c.lfr1.rb3 -value 3 -variable typeop -text "Добавить подпись"
  ttk::radiobutton $c.lfr1.rb4 -value 2 -variable typeop -text "Сохранить сер-т подписанта"
#  ttk::radiobutton $c.lfr1.rb6 -value 5 -variable typeop -text "Извлечь метку времени"
  ttk::checkbutton $c.lfr1.ch4 -variable typesave -text "PEM-формат"
  ttk::radiobutton $c.lfr1.rb5 -value 4 -variable typeop -text "Сохранить все сертификаты"
  ttk::checkbutton $c.lfr1.ch5 -variable typesave -text "PEM-формат"

  grid $c.lfr1.rb1 -row 0 -column 0 -columnspan 2 -sticky w -padx {4 0} -pady {0 0}
  grid $c.lfr1.rb2 -row 0 -column 0 -columnspan 2 -sticky e -padx {4 0} -pady {0 0}
#  grid $c.lfr1.rb6 -row 1 -column 1 -sticky w -padx {4 0} -pady {0 0}
#  grid $c.lfr1.rb3 -row 0 -column 1 -sticky w -padx {4 0} -pady {0 0}
  grid $c.lfr1.rb4 -row 3 -column 0 -columnspan 1 -sticky w -padx {4 0} -pady {0 0}
  grid $c.lfr1.ch4 -row 3 -column 1 -sticky e -padx {0 0} -pady {0 0}
  grid $c.lfr1.rb5 -row 4 -column 0 -columnspan 2 -sticky w -padx {4 0} -pady {0 1}
  grid $c.lfr1.ch5 -row 4 -column 1 -sticky e -padx {0 0} -pady {0 1}
    pack $c.lfr1 -fill both -side top -padx 10
    
  ttk::button  $c.b2 -command {::workOp} -text "Выполнить операцию"
    pack $c.b2 -side top -anchor nw  -padx 5 -pady 4 
    
  labelframe $c.lfr2 -text "Добавить подписанта"
  variable storage
  set storage 1
  ttk::radiobutton $c.lfr2.st1 -value 0 -variable storage -text "PKCS11" -command {}
  ttk::radiobutton $c.lfr2.st2 -value 1 -variable storage -text "PKCS12" -command {}
  ttk::button  $c.lfr2.b1 -command {addsignature} -text "Добавить ЭП"
#  grid $c.lfr2.st1 -row 0 -column 0 -sticky w -padx {4 0} -pady {0 0}
#  grid $c.lfr2.st2 -row 0 -column 1 -sticky e -padx {4 0} -pady {0 0}
    pack $c.lfr2.st1 -side left -padx {4 0} -pady {0 0}
    pack $c.lfr2.st2 -side left -padx {4 0} -pady {0 0}
    pack $c.lfr2.b1 -side right -padx {4 10} -pady {0 4}
    pack $c.lfr2 -fill both -side top -padx 10

    trace variable p7s_fn w trace_p7s
    trace variable ::signedCert w trace_signedcert
}

proc wizard {tpage toplevel pages func} {
  puts "WIZARD=$toplevel"
  set j 0
  for {set i 1} {$i <= $pages} {incr i} {
    set finish {}
    set page $toplevel.p$i
    frame $page -bg #f5f5f5 -relief flat -highlightthickness 1 -highlightbackground skyblue -highlightcolor skyblue -padx 2 -pady 2
    frame $page.page -bg #f5f5f5 -relief flat -highlightthickness 2 -highlightbackground skyblue -highlightcolor skyblue -padx 2 -pady 2
    lappend page_list $page.page
    lappend page_list [lindex $func $j]
    incr j

    ttk::button $page.p -text "< Пред." -command [list move $tpage $page.page -1] -style MyBorder.TButton -padding 1
    ttk::button $page.n -text "След. >" -command [list move $tpage $page.page 1] -style MyBorder.TButton -padding 1
    ttk::button $page.f -text "Завершение" -command [list ::finalizeCSR $tpage ] -style MyBorder.TButton -padding 1
    if {$i == 1} {
      $page.p configure -state disabled
    }
    if {$i == $pages} {
      $page.n configure -state disabled
      $page.f configure -state normal
      set finish $page.f
    }
    grid $page.page  -columnspan 4  -sticky nsew
    grid $page.p $page.n {*}$finish -pady 3 -padx {10 10}

    grid columnconfigure $page 3 -weight 1
    grid rowconfigure $page 0 -weight 1
  }
  return $page_list
}

proc create_asnextkey {oids} {
  if {[llength $oids] == 0} {
    return ""
  }
  set extkeyuse ""
  foreach oid $oids {
    set oidt [string map {"." " "} $oid]
    append extkeyuse [::asn::asnObjectIdentifier $oidt ]
  }
  set asnextkeyuse  [::asn::asnSequence [::asn::asnObjectIdentifier "2 5 29 37"] \
  [::asn::asnOctetString  \
  [::asn::asnSequence $extkeyuse] \
  ] \
  ]

  return $asnextkeyuse
}

# Generate a PKCS#10 Certificate Signing Request
proc ::pki::pkcs::create_csr_OK {typegost userkey_hex namelist subjectsigntool extkeyuse {encodePem 0} aa} {
  variable certfor
  if {$typegost == "g12_512"} {
    set ckm "CKM_GOSTR3410_512"
    set stribog "stribog512"
    set signkey "1 2 643 7 1 1 3 3"
  } elseif {$typegost == "g12_256"} {
    set ckm "CKM_GOSTR3410"
    set stribog "stribog256"
    set signkey "1 2 643 7 1 1 3 2"
  } else {
    return ""
  }

  set extreq "1 2 840 113549 1 9 14"
  set subjectst "1 2 643 100 111"
  #puts "DN=$namelist"
  set userkey [binary format H* $userkey_hex]
  array set ar_aa $aa
  if {[info exists ar_aa(group)]} {
    ::asn::asnGetSequence userkey userkey1
    set userkey $userkey1
  }

  #Идентификатор ключа получателя (CKA_ID)
  binary scan  $userkey H*  userk_hex
  array set infopk [parse_key_gost $userk_hex]
  set pubkeysub  [binary format H* $infopk(pubkey)]
  set pkcs11id_bin [lcc_sha1 $pubkeysub]
  binary scan $pkcs11id_bin H* pkcs11id_hex
  # "id-ce-subjectKeyIdentifier" = 2 5 29 14
  #tk_messageBox -title "create_csr_OK" -icon info -message "$ckm\n$pkcs11id_hex" -detail "$infopk(pubkey)"
  #		[::asn::asnBoolean $critical]
  set idsub [::asn::asnSequence \
  [::asn::asnObjectIdentifier [::pki::_oid_name_to_number "id-ce-subjectKeyIdentifier"]] \
  [::asn::asnOctetString [::asn::asnOctetString $pkcs11id_bin]] \
  ]
  #set idsub ""

  set name [list_to_dn_tc26 $namelist]
  #Creare asn1 keyusage
  set k 0
  set ku_m ""
  foreach v $::ku_options {
    set ku "::ku"
    append ku $k
    #puts "KU=$ku"
    set ku [subst $$ku]
    append ku_m $ku
    incr k
  }
  #puts "KU=$ku_m"
  set one_last [string last "1" $ku_m ]
  set ku_m [string range $ku_m 0 $one_last]
  set asn_ku [::asn::asnBitString $ku_m]
  #binary scan $asn_ku H* ku_hex
  #puts "KU_HEX=$ku_hex"
  set isca [lsearch $::bc_options $::bc]
  # If we are generating a CA cert, add a CA extension
  set id_ce_bc ""
  switch $isca {
    0 {
      set id_ce_bc ""
    }
    1 {
      set id_ce_bc [list false false -1]
    }
    2 {
      set id_ce_bc [list true false -1]
    }
    3 {
      set id_ce_bc [list false true 0]
    }
    4 {
      set id_ce_bc [list true true 0]
    }
  }

  set ext_bc ""
  if {$id_ce_bc != "" } {
    set critical [lindex $id_ce_bc 0]
    set allowCA [lindex $id_ce_bc 1]
    set caDepth [lindex $id_ce_bc 2]

    if {$caDepth < 0} {
      set extvalue [::asn::asnSequence [::asn::asnBoolean $allowCA]]
    } else {
      set extvalue [::asn::asnSequence [::asn::asnBoolean $allowCA] [::asn::asnInteger $caDepth]]
    }
    set  ext_bc [::asn::asnSequence \
    [::asn::asnObjectIdentifier [::pki::_oid_name_to_number "id-ce-basicConstraints"]] \
    [::asn::asnBoolean $critical] \
    [::asn::asnOctetString $extvalue] \
    ]	
  }
  set extsubsigntool ""
  if {$subjectsigntool != ""} {
    set extsubsigntool [::asn::asnSequence [::asn::asnObjectIdentifier $subjectst] \
    [::asn::asnOctetString [::asn::asnUTF8String $subjectsigntool]] \
    ]
  }

  set cert_req_info [::asn::asnSequence \
  [::asn::asnInteger 0] \
  [::asn::asnSequence $name] \
  [::asn::asnSequence $userkey ] \
  [::asn::asnContextConstr 0 \
  [::asn::asnSequence [::asn::asnObjectIdentifier $extreq] \
  [::asn::asnSet \
  [::asn::asnSequence \
  $ext_bc \
  [::asn::asnSequence [::asn::asnObjectIdentifier "2 5 29 15"] \
  [::asn::asnOctetString $asn_ku] \
  ] \
  $extkeyuse \
  $extsubsigntool \
  $idsub \
  ] \
  ] \
  ] \
  ] \
  ]

  #Посчитать хэш от tbs-сертификата!!!!
  binary scan $cert_req_info H* tbs_csr_hex
  #puts "AA=$aa"
  #puts "TBS_CSR=$tbs_csr_hex"
  #Оригинал для Хэш передается в оригигальном виде
  set digest_hex    [pki::pkcs11::dgst $stribog $cert_req_info]
  #    set digest_hex    [pki::pkcs11::digest $stribog $cert_req_info  $aa]
  #puts "DIGEST=$digest_hex"
  #Определяем на каком ключе токен или LCC создается запрос
  if {![info exists ar_aa(group)]} {
    set sign_csr_hex  [pki::pkcs11::sign $ckm $digest_hex  $aa]
    if {[catch {set verify [pki::pkcs11::verify $digest_hex $sign_csr_hex $aa]} res] } {
      #	puts "BEDA=$res"
      return ""
    }
  } else {
    # generate random bytes for signature
    set lenkey [string length $ar_aa(privkey)]
    puts "LENKEY=$lenkey"
    set rnd_ctx [lrnd_random_ctx_create ""]
    set rnd_bytes [lrnd_random_ctx_get_bytes $rnd_ctx $lenkey]
    set digest_bin [binary format H* $digest_hex]
                	
    if { $lenkey == 32 } {
      set sign_csr [lcc_gost3410_2012_256_sign $ar_aa(group) $ar_aa(privkey) $digest_bin $rnd_bytes]
    } elseif {$lenkey == 64 } {
      set sign_csr [lcc_gost3410_2012_512_sign $ar_aa(group) $ar_aa(privkey) $digest_bin $rnd_bytes]
    } else {
      puts "BAD key=$lenkey"
      return ""
    }
    binary scan  $sign_csr H*  sign_csr_hex
    set verify 1
    set len_sign [string length $sign_csr]
    puts "::pki::pkcs::create_csr_OK for LCC=$len_sign"
    if { $len_sign != 128 && $len_sign != 64} {
      puts "BAD signature=$len_sign"
      return ""
    }
  }
  if {$verify != 1} {
    puts "BAD SIGNATURE=$verify"
    return ""
  } else {
    puts "SIGNATURE OK=$verify"
  }

  set signature [binary format H* $sign_csr_hex]

  binary scan $signature B* signature_bitstring
        	
  set cert_req [::asn::asnSequence \
  $cert_req_info \
  [::asn::asnSequence [::asn::asnObjectIdentifier $signkey] [::asn::asnNull]] \
  [::asn::asnBitString $signature_bitstring] \
  ]

  if {$encodePem} {
    set cert_req [::pki::_encode_pem $cert_req "-----BEGIN CERTIFICATE REQUEST-----" "-----END CERTIFICATE REQUEST-----"]
  }
  return $cert_req
}

proc CreateRequestTCL {profilename attributes} {
  global env
  global typeCert

  upvar $attributes attr
  array set tkey {gost2012_512 gost3410-2012-512 gost2012_256 gost3410-2012-256}
  parray tkey
  #set typeCert  {"Физическое лицо" reqFL "Индивидуальный предприниматель" reqIP "Юридическое лицо" reqUL}
  set oidtype ""
  foreach {ru lat} $typeCert {
    #puts "RU=$ru"
    #puts "LAT=$lat"
    if {$attr(type) == $ru } {
      switch --  $lat {
        "reqFL" {
          set oidtype "1.2.643.6.3.1.2.2"
        }
        "reqUL" {
          set oidtype "1.2.643.6.3.1.2.1"
        }
        "reqIP" {
          set oidtype "1.2.643.6.3.1.2.3"
        }
      }
    }
  }
  set temp ""

  # + 32768 для неэкспортируемого ключа
  set tpkey 0
  set typegost ""
  switch -- $tkey($attr(typekey)) {
    "gost3410-2012-256" {
      set typegost g12_256
      set tpkey 8192
      set stribog stribog256
      switch -- $attr(parkey) {
        "1.2.643.2.2.35.1" {
        }
        "1.2.643.2.2.35.2" {
          incr tpkey
        }
        "1.2.643.2.2.35.3" {
          incr tpkey 2
        }
        "1.2.643.2.2.36.0" {
          incr tpkey 3
        }
        "1.2.643.2.2.36.1" {
          incr tpkey 4
        }
      }
    }
    "gost3410-2012-512" {
      set typegost g12_512
      set tpkey 16384
      set stribog stribog512
      switch -- $attr(parkey) {
        "1.2.643.7.1.2.1.2.1" {
        }
        "1.2.643.7.1.2.1.2.2" {
          incr tpkey
        }
      }
    }
  }
  if {$attr(expkey) == 1} {
    incr tpkey 32768
  }
  set token_slotid $::slotid_tek
  puts "token_slotid=$token_slotid"
  if { [pki::pkcs11::login $::handle $token_slotid $attr(keypassword)] == 0 } {
    tk_messageBox -title "Запрос на сертификат" -message "Не смогли залогиниться на токене\nПроверьте PIN-код." -icon error  -parent .
    return ""
  }
  set aa [list "pkcs11_handle" $::handle "pkcs11_slotid" $token_slotid]
  array set genkey [::pki::pkcs11::keypair $typegost A $aa ]
  #puts "Ключевая пара $typegost создана"
  #parray genkey
  lappend aa "pkcs11_id"
  lappend aa $genkey(pkcs11_id)
  #Установить метку ключевой пары
  lappend aa "pkcs11_label"
  if {$::egais == 1 && $attr(type) != "Физическое лицо"} {
    set tekt [clock format [clock seconds] -format {%y%m%d%H%M}]
    if {$attr(type) == "Индивидуальный предприниматель"} {
      set lenkpp 0
      set inn $attr(INN)
    } else {
      set lenkpp [string length $attr(UN)]
      set inn [string trimleft $attr(INN) "0"]
    }
    if {$lenkpp != 0 && $lenkpp != 9 } {
      tk_messageBox -title "Запрос на сертификат" -message "Ошибка в поле КПП." -detail "Поле должно быть пустым или содеожать 9 цифр" -icon error  -parent .
      return ""
    }
    if {$lenkpp == 9} {
      set labkey "$tekt-$inn-$attr(UN)"
    } else {
      set labkey "$tekt-$inn"
    }
  } else {
    set labkey $attr(CN)
  }
  puts "labkey=$labkey"
  lappend aa $labkey
  pki::pkcs11::rename key $aa

  lappend aa "pubkeyinfo"
  lappend aa $genkey(pubkeyinfo)

  #####################
  #puts "PUBKEYINFO=$genkey(pubkeyinfo)"
  set   userkey_hex  $genkey(pubkeyinfo)

  set ekeyuse ""
  set oids ""
  if {$attr(type) == "Юридическое лицо" && $::egais == 1 } {
    set oids $::oidegais
    if {$::lisalko == 1} {
      #	    lappend oids $::oidalko
      lappend oids $::oidlizfsrar

    }
  } elseif {$attr(type) == "Индивидуальный предприниматель" && $::egais == 1 } {
    set oids $::oidegais
    if {$::lisalko == 1} {
      #	    lappend oids $::oidalko
      lappend oids $::oidlizfsrar
    }
  }
  set ekeyuse [create_asnextkey $oids]

  set usercsr [ pki::pkcs::create_csr_OK $typegost $userkey_hex  $attr(dncsr) $attr(ckzi) $ekeyuse $::formatCSR $aa]
  #puts $usercsr
  return [list $usercsr $labkey]
}

proc ::finalizeCSR {tpage} {
  variable certfor
  global wizDatacsr
  global wizDatacert
  if {$tpage == "csr"} {
    array set wizData [array get wizDatacsr]
    array set attr [array get wizData]
    set ercreate "Ошибка генерации запроса.\n"
    set tit "Запрос на сертификат"
    set msgok "Запрос успешно создан в файле\n$attr(csr_fn)"
    set detok "Закрытый ключ сохранен на токене\n$attr(token)"
  } else {
    array set wizData [array get wizDatacert]
    array set attr [array get wizData]
    set ercreate "Ошибка создания самоподписанного сертификата.\n"
    set tit "Самоподписанный сертификат"
    if {$certfor != 0} {
      set selfcsr [file join $attr(csr_fn) self_$::snforcert.csr]
      set selfp12cert [file join $attr(csr_fn) self_$::snforcert.pfx]
      set selfcert [file join $attr(csr_fn) self_$::snforcert.cer]
      #	    set selfkey $attr(key_fn)
      set selfkey [file join $attr(csr_fn) self_$::snforcert.key]
    } else {
      set selfcsr [file join $attr(csr_fn) "rootCA.csr"]
      set selfp12cert [file join $attr(csr_fn) "rootCA.pfx"]
      set selfcert [file join $attr(csr_fn) "rootCA.cer"]
      set selfkey [file join $attr(csr_fn) "rootCA.key"]
    }
    set msgok "Сертификат успешно создан в файле\n$selfcert\nСертификат и закрытый ключ сохранены в контейнере PKCS#12:\n$selfp12cert\nНикому не передавайте пароль к контейнеру"
    set detok "Закрытый ключ сохранен также в файле\n$selfkey\nНикому не передавайте закрытый ключ."
    #	set detok ""
    append detok "\nЗапрос на сертификат сохранен в файле\n$selfcsr"
  }
  # only create certificate request to file
  set profile $attr(type)
  #puts "PROFILE=$profile"
  #parray attr
  #puts "wizData"
  #parray wizData

  if {$tpage == "csr"} {
    #    	    set req [CreateRequestTCL $profile attr]
    foreach {req labk} [CreateRequestTCL $profile attr] {}
    append detok "\nМетка ключевой пары:\n$labk"
  } else {
    #tk_messageBox -title $tit -message $msgok -detail $detok -icon info  -parent .
    #set ::pw 01234567
    #set ::rpw 01234567
    if {$::rpw != $::pw || $::rpw == ""} {
      tk_messageBox -title "Выпуск сертификата" -message "Ошибка в пароле для Вашего PKCS#12.\nВернитесь на шаг назад и задайте пароль" -detail "(Пароль не может быть пустым)" -icon error  -parent .
      return -code break
    }

    set req [CreateSelfCertTCL $profile attr]
  }

  if {$req == "" } {
    tk_messageBox -title $tit -message $ercreate -icon error  -parent .
    return -code break
  }
  if {$tpage == "csr"} {
    set fd [open $wizData(csr_fn) w]
  } else {
    set fd [open $selfcsr w]
  }
  chan configure $fd -translation binary
  puts -nonewline $fd $req
  close $fd
  tk_messageBox -title $tit -message $msgok -detail $detok -icon info  -parent .

  #array set csr_parse [::pki::pkcs::parse_csr_gost $req]
  #parray csr_parse

  return -code break
}


proc nextStep {tpage numpage} {
  global certfor
  global wizDatacsr
  global wizDatacert
  global reqFL
  global typeCert
  global sodCert
  set currentStep $numpage
  incr currentStep -1

  #parray wizDatacsr
  #parray wizDatacert
  if {$tpage == "csr"} {
    array set wizData [array get wizDatacsr]
  } else {
    array set wizData [array get wizDatacert]
  }
  set keytok $wizData(keytok)
  #parray wizData

  #puts "CURRENT=$currentStep"
  if { $currentStep == 0} {
    return 1
  }
  if { $currentStep == 1 && $tpage == "cert" } {
    if {$certfor == 0 && $::ku5 == 0} {
      tk_messageBox -title "Выпуск сертификата" -message "Вы хотите выпустить корневой сертификат, но в назначении ключа отсутствует возможность подписания сертификатов!" -icon error  -parent .
      return 0;
    }
  }
  if { $currentStep == 1 && $tpage == "csr" && $keytok == 1} {
    #puts "TypeKey=$wizData(typekey)"
    #puts "token=$wizData(token)"
    #puts "LISTTS=$::listtok"
    #parray ::arlists
    #puts "SLOT=$::arlists($wizData(token))"
    set llmech [pki::pkcs11::listmechs $::handle $::slotid_tek]
    #puts  "MECH=$llmech"
    switch -- $wizData(typekey) {
      gost2012_256 {
        set err [string first "0x1200" $llmech]
        if {$err != -1 } {
          set err [string first "0xD4321012" $llmech]
        }
      }
      gost2012_512 {
        set err [string first "0xD4321005" $llmech]
      }	
      default {
        set err -1
      }
    }
    if {$err == -1} {
      tk_messageBox -title "Запрос на сертификат" -message "Токен $wizData(token)\nне поддерживает ключи $wizData(typekey)" -icon error  -parent .
      return 0;
    }
  } elseif {$currentStep == 2} {
    if {$wizData(CN) == ""} {
      tk_messageBox -title "Запрос на сертификат" -message "Пожалуйста, укажите владельца (CN) сертификата." -icon error  -parent .
      return 0;
    }
  } elseif {$currentStep == 3} {
    set missingvalue 0
    set missinglist {}
    foreach {v req} $typeCert {
      if {$v == $wizData(type) } {
        array set profdate $sodCert($req)
        set reqFL1 $sodCert($req)
        break
      }
    }
    foreach {field dflt} $reqFL1 {
      if {$wizData($field) == ""} {
        if {$field == "UN" && $::egais == 0} {
          continue
        }
        set missingvalue 1
        lappend missinglist "$field"
      }
    }
    if {$wizData(E) != ""} {
      set mail [verifyemail $wizData(E)]
      if {$mail != "OK" } {
        tk_messageBox -title "Запрос на сертификат" -message "Вы неверно указали адрес электронной почты." -icon error  -parent .
        return 0
      }
    } else {
      tk_messageBox -title "Запрос на сертификат" -message "Вы не указали электронную почту"  -icon error  -parent .
      return 0
    }
    if {$wizData(INN) != ""} {
      set leninn [string length $wizData(INN)]
      if {$leninn != 12} {
        tk_messageBox -title "Запрос на сертификат" -message "Неправильная длина поля ИНН." \
        -detail "Для юрлиц ИНН имеет 10 цифр, дополненные слева двумя нулями.\nДля физлиц и ИП это 12 цифр." \
        -icon error  -parent .
        return 0
      }
      if { $wizData(type) == "Юридическое лицо" } {
        if {[string range $wizData(INN) 0 1] != "00" } {
          tk_messageBox -title "Запрос на сертификат" -message "Первые две цифры в ИНН для юрлица должны быть 00.\n(Это вынужденное дополнение)" \
          -detail "Для юрлиц ИНН имеет 10 цифр, дополненные слева двумя нулями.\nДля физлиц и ИП это 12 цифр." \
          -icon error  -parent .
          return 0
        }
        if {[string range $wizData(INN) 2 2] == "0" } {
          tk_messageBox -title "Запрос на сертификат" -message "Первая цифра ИНН не может быть нулем." \
          -detail "Для юрлиц ИНН имеет 10 цифр, дополненные слева двумя нулями.\nДля физлиц и ИП это 12 цифр." \
          -icon error  -parent .
          return 0
        }
      } else {
        if {[string range $wizData(INN) 0 0] == "0" } {
          tk_messageBox -title "Запрос на сертификат" -message "Первая цифра ИНН не может быть нулем." \
          -detail "Для юрлиц ИНН имеет 10 цифр, дополненные слева двумя нулями.\nДля физлиц и ИП это 12 цифр." \
          -icon error  -parent .
          return 0
        }
      }
    }
    if {$missingvalue && $tpage == "csr"} {
      tk_messageBox -title "Запрос на сертификат" -message "Вы не заполнили следующие обязательные поля:" -detail "[join $missinglist {, }]."  -icon error  -parent .
      return 0
    }
  } elseif {$currentStep == 4} {
    if {$tpage == "csr"} {
      if {$wizData(csr_fn) == ""} {
        tk_messageBox -title "Запрос на сертификат" -message "Не задан файл для сохранения запроса." -icon error  -parent .
        return 0
      }
      if {$wizData(keypassword) == ""} {
        tk_messageBox -title "Запрос на сертификат" -message "Задайте PIN-код." -icon error  -parent .
        return 0
      }
    } else {
      if {$wizData(csr_fn) == ""} {
        tk_messageBox -title "Выпуск сертификата" -message "Не выбран каталог для хранения сертификатов и ключей." -icon error  -parent .
        return 0
      }
      if {$::rpw != $::pw || $::rpw == ""} {
        tk_messageBox -title "Выпуск сертификата" -message "Ошибка в пароле для Вашего PKCS#12." -detail "(Пароль не может быть пустым)" -icon error  -parent .
        return 0
      }
    }
  }
  return 1
}

proc move {tpage page {offset 0}} {
  puts "MOVE_PAGE=$page"
  puts "offset=$offset"

  set page [winfo parent $page]
  regexp {^(.*\.p)([0-9]+)$} $page -> root number
  set newnumber [expr {$number + $offset}]
  if {$newnumber == 0} {
    cmdssl $page
  }

  set next [nextStep $tpage $newnumber]
  if {$next != 1} {
    return
  }
  pack forget $page
  set childold [winfo children $page]
  set newpage "$root$newnumber"

  pack $newpage -fill both -expand 1
pack forget .fn3.can
pack .fn3.can  -anchor center -expand 1 -fill both -side top  -padx 0 -pady 0

  set childnew [winfo children $newpage]
  set PP [lindex $childnew 0]
  #puts "PP=$PP"
  if {$tpage == "csr" } {
    set pages $::pagescsr
  } elseif {$tpage == "cert" } {
    set pages $::pagescert
  } else {
    return
  }

  if {$newnumber != 111} {
    eval destroy [winfo children $PP]
    ##########
    foreach {p func} $pages {
      #puts "P=$p"
      if {$p == $PP} {
        #puts "PAGEforFUNC=$page"
        #puts "FUNC=$func"
        #puts "TPAGE=$tpage"
        $func $tpage $p $newnumber
        break
      }
      incr j
      #puts "CSR=[winfo children $page]"
    }
  }
  ###########
  puts "NEW_PAGE=$newpage"
  puts "NEW_NUMBER_PAGE=$newnumber"
  puts "NEW_CHIL=$childnew"
  puts "OLD_CHIL=$childold"
  if {$tpage == "csr" } {
    set ::wizpagecsr 1
  } else {
    set ::wizpagecert 1
  }
  puts "wizpagecsr=$::wizpagecsr"
}

## Procedure:  Digit
proc ::Digit {ent len text size} {
  #puts "DIGIT $ent $len $text $size"
  set length [string length $text]
  if {$length != $len} {
    $ent configure -bg white
  }
  if {$length > $size} {
    $ent configure -bg #00ffff
    return 0
  }

  if {[regexp {[^0-9]} $text]} {
    $ent configure -bg red
    return 0
  }
  if {$length == $size} {
    $ent configure -bg #00ffff
    return 1
  }
  if {$len >= $size} {
    $ent configure -bg #00ffff
    return 0
  }
  $ent configure -bg white
  return 1
}

set ::emailpat {
  ^
  (  # local-part
  (?:
  (?:
  (?:[^"().,:;\[\]\s\\@]+)   # one or more non-special characters (not dot)
  |
  (?:
  "  # begin quoted string
  (?:
  [^\\"]  # any character other than backslash or double quote
  |
  (?:\\.) # or a backslash followed by another character
  )+   # repeated one or more times
  "  # end quote
  )
  )
  \.   # followed by a dot
  )*    # local portion with trailing dot repeated zero or more times.
  (?:[^"().,:;\[\]\s\\@]+)|(?:"(?:[^\\"]|(?:\\.))+")  # as above, the final portion may not contain a trailing dot
  )
  @
  (  # domain-name, underscores are not allowed
  (?:(?:[A-Za-z0-9][A-Za-z0-9-]*)?[A-Za-z0-9]\.)+ # one or more domain specifiers followed by a dot
  (?:[A-Za-z0-9][A-Za-z0-9-]*)?[A-Za-z0-9]     # top-level domain
  \.?           # may be fully-qualified
  )
  $
}

proc verifyemail {emailtest} {
  set rc NG
  #puts "verifyemail=$emailtest"
  if { [regexp -expanded $::emailpat $emailtest emailaddr local domain] } {
    set rc OK
  }
  return $rc
}



proc egais_ul {w tpage } {
  set tface [$w get]
  set ind [string last "." $w]
  set win [string range $w 0 $ind]
  append win "egais"
  if {$tface == "Физическое лицо"} {
    #	puts "Win=$win"
    grid remove $win
  } else {
    grid $win
  }
}


proc create_csr_list1 {tpage c num} {
  global wizDatacsr
  global wizDatacert
  variable certfor
  global macos
  #puts "LIST1=$c"
  puts "create_csr_list1 tpage=$tpage"

  $c configure -bg white
  #    global wizData
    labelframe $c.tok -text "Выберите токен PKCS11"  -borderwidth 5
    ttk::combobox $c.tok.listTok -textvariable ::nickTok -values $::listtok
    set ::nickTok [lindex $::listtok 0]
    $c.tok.listTok configure -state normal
    $c.tok.listTok configure -values $::listtok
    $c.tok.listTok configure -state readonly
    pack $c.tok.listTok -fill both -side top -padx 4 -pady {2 4}
  grid $c.tok -row 0 -column 0 -sticky wsen -padx {4 4} -pady 2

  set typeCert  {"Физическое лицо" reqFL "Индивидуальный предприниматель" reqIP "Юридическое лицо" reqUL}
  labelframe $c.l1 -text "Владелец сертификата" 

  set listCert {}
  # insert existing profiles

  foreach {v req} $typeCert {
    lappend listCert $v
  }
  set wz [subst "wizData$tpage"]
  set type [subst "$wz\(type\)"]
  set typekey [subst "$wz\(typekey\)"]
  set parkey [subst "$wz\(parkey\)"]
  set ckzi [subst "$wz\(ckzi\)"]
  set expkey [subst "$wz\(expkey\)"]
  set selfca [subst "$wz\(selfca\)"]
  set selfssl [subst "$wz\(selfssl\)"]


  if {$macos} {
    spinbox $c.c1 -width 33 -textvariable $type -values $listCert -state readonly
  } else {
    ttk::combobox $c.c1 -width 33 -textvariable $type -values $listCert -state readonly -style TCombobox
  }
  if {$tpage == "csr"} {
    bind $c.c1 <<ComboboxSelected>> {egais_ul %W "csr" }
  }

  if {$tpage == "cert"} {
    frame $c.fcrt -relief flat -bg white  -highlightthickness 1 -highlightbackground skyblue -highlightcolor skyblue -padx 0
    label $c.lcrt -text "Выберите тип сертификата:" -bg white -anchor w
    ttk::radiobutton $c.fcrt.chb1 -value 1 -variable certfor -text "User" -pad 0
    #	 -highlightthickness 0 -disabledforeground #000000
    ttk::radiobutton $c.fcrt.chb2 -value 0 -variable certfor -text "CA (Корневой)" -pad 0
    #	-highlightthickness 0 -disabledforeground #000000
    #	ttk::radiobutton $c.lcrt.chb2 -value 0 -variable certfor -text "CA (Корневой)"
    ttk::radiobutton $c.fcrt.chb3 -value 2 -variable certfor -text "SSL" -pad 0
    #	 -highlightthickness 0
    pack $c.fcrt.chb1 -side left -padx {8 8} -pady {0 0} -fill y -expand 1 -pady 1
    pack $c.fcrt.chb2 -side left -padx {38 8} -pady {0 0} -fill y -expand 1 -pady 1
    pack $c.fcrt.chb3 -side right -padx {8 8} -pady {0 0} -fill y -expand 1 -pady 1
    #	grid $c.lcrt.chb1 -row 0 -column 0 -sticky wnse -padx {8 8} -pady {0 2}
    #	grid $c.lcrt.chb2 -row 0 -column 1 -sticky wnse -padx {8 8} -pady {0 2}
    #	grid $c.lcrt.chb3 -row 0 -column 2 -sticky wnse -padx {8 8} -pady {0 2}
  }

  #Type Key
  # combo box
  labelframe $c.l3 -text "Тип и параметры ключа" -font TkDefaultFontBold
  set listKey {gost2012_256 gost2012_512}
  if {$tpage == "csr"} {
    set dflt $wizDatacsr(typekey)
  } else {
    set dflt $wizDatacert(typekey)
  }

  if {$macos} {
    spinbox $c.c3 -width 13  -textvariable $typekey -values $listKey -state readonly
  } else {
    ttk::combobox $c.c3 -width 13  -textvariable $typekey -values $listKey -state readonly  -style TCombobox
  }
  set $typekey $dflt
  #    $c.c3 delete 0 end
  #    set tekC [lsearch $listKey $dflt]
  #    $c.c3 insert end [lindex $listKey $tekC]

  #puts "C=$c"
  if {$tpage == "csr"} {
    bind $c.c3 <<ComboboxSelected>> {keyParam %W "csr" $wizDatacsr(typekey)}
  } else {
    bind $c.c3 <<ComboboxSelected>> {keyParam %W "cert" $wizDatacert(typekey)}
  }

  if {$dflt == "gost2012_512"} {
    set listBits {1.2.643.7.1.2.1.2.1 1.2.643.7.1.2.1.2.2 1.2.643.7.1.2.1.2.3}
  } elseif {$dflt == "gost2012_256"} {
    set listBits {1.2.643.2.2.35.1 1.2.643.2.2.35.2  1.2.643.2.2.35.3  1.2.643.2.2.36.0 1.2.643.2.2.36.1 1.2.643.7.1.2.1.1.1 1.2.643.7.1.2.1.1.2 1.2.643.7.1.2.1.1.3 1.2.643.7.1.2.1.1.4}
  }
  set listKey {gost2012_256 gost2012_512}
  set dflt [subst $$typekey]

  if {$macos} {
    spinbox $c.c4 -width 18  -textvariable $parkey -values $listBits  -state readonly
  } else {
    ttk::combobox $c.c4 -width 18  -textvariable $parkey -values $listBits -style TCombobox -state readonly
  }
  $c.c3 delete 0 end
  set tekC [lsearch $listKey $dflt]
  $c.c3 insert end [lindex $listKey $tekC]

  set dflt [subst $$ckzi]
  labelframe $c.l5 -text "Наименование СКЗИ"
  ttk::entry $c.c5 -textvariable $ckzi -width 33
  # -textvariable $ckzi -bg white -highlightthickness 1 -highlightbackground skyblue -highlightcolor skyblue
  $c.c5 delete 0 end
  $c.c5 insert end $dflt

  grid $c.l1 -row 1 -column 0 -sticky wsen -padx {4 4} -pady 2
#  grid $c.c1 -in $c.l1 -row 0 -column 1 -sticky wsen -padx {12 4} -pady 2p
  pack $c.c1 -in $c.l1  -padx 4 -pady 2p

  if {$tpage == "cert"} {
    grid $c.lcrt -row 1 -column 0 -columnspan 1 -sticky wsen -padx {4 4} -pady {0 0}
    grid $c.fcrt -row 1 -column 1 -columnspan 2 -sticky wsen -padx {12 4} -pady {0 0}
  }
  #    grid $c.l3 -row 2 -column 0 -sticky w -padx 4 -pady 4
  #    grid $c.c3 -row 2 -column 1 -sticky w -padx 4 -pady 4
  grid $c.l3 -row 2 -column 0 -sticky wsen -padx {4 4} -pady 4
  grid $c.c3 -in $c.l3  -row 2 -column 0 -sticky e -padx {0 4} -pady 4
  #    grid $c.l4 -row 3 -column 0 -sticky w -padx 4 -pady 4
  #    grid $c.c4 -row 3 -column 1 -sticky w -padx 4 -pady 4
  grid $c.c4 -in $c.l3 -row 2 -column 1 -sticky e -padx {2 4} -pady 4


  grid $c.l5 -row 40 -column 0 -sticky wsen -padx 4 -pady 4
#  grid $c.c5 -row 4 -column 1 -sticky w -padx {12 4} -pady 4
  pack $c.c5 -in $c.l5  -padx {4 4} -pady 4 

  #    if {$tpage == "csr"} {
  #	checkbutton $c.c6 -text "Ключ неэкспортируемый"  -variable $expkey  -bg white -highlightthickness 0
  #	grid $c.c6 -row 5 -column 0 -sticky w -padx 4 -pady 4
  #    }

  #	checkbutton $c.c6 -text "Самоподписанный корневой сертификат"  -variable $selfca  -bg white -highlightthickness 0
  #	checkbutton $c.c7 -text "Самоподписанный DV SSL-сертификат"  -variable $selfssl  -bg white -highlightthickness 0
  #	grid $c.c6 -row 5 -column 0 -columnspan 2 -sticky w -padx 4 -pady 4
  #	grid $c.c7 -row 6 -column 0 -columnspan 2 -sticky w -padx 4 -pady 4

  #	label $c.l6 -text "Key Usage:" -font TkDefaultFontBold  -bg skyblue
  labelframe $c.l6 -text "Использование ключа" 
  # -bg skyblue
  grid $c.l6 -row 7 -column 0 -columnspan 1 -sticky wsen -padx 4 ;#-pady 4

  set i 8
  set j 0
  set ir 8
  set k 0
  foreach v $::ku_options {
    #puts "KU=::ku$k"
    ttk::checkbutton $c.c$i -text "$v" -variable ::ku$k 
    #    	    -pady 0
    pack $c.c$i -in  $c.l6 -side top -fill x
if {0} {
    grid $c.c$i -row $ir -column $j -columnspan 1 -sticky w -padx 8  -pady {0 0}
    #    	    grid rowconfigure $c $i -weight 0
    incr i
    if {$j == 1} {
      incr ir
      set j 0
    } else {
      incr j
    }
    incr k
}
    incr k
    incr i
  }
  if {$tpage == "csr"} {
    incr ir
#    checkbutton $c.egais -image egais_83x36 -text "Запрос на сертификат для ЕГАИС" -variable ::egais  -compound left  -bd 0 -bg skyblue
    checkbutton $c.egais -text "Запрос на сертификат для ЕГАИС" -variable ::egais  -compound left  -bd 0 -bg skyblue
    #	 -background white -activebackground white -highlightthickness 0
    grid $c.egais -row $ir -column 0 -columnspan 3 -sticky w -padx 0 -pady 0
    grid remove $c.egais
    egais_ul $c.c1 "csr"
  }

  return
}

set typeCert  {"Физическое лицо" reqFL "Индивидуальный предприниматель" reqIP "Юридическое лицо" reqUL}
array set atrkval {ИНН 12 ОГРН 13 ОГРНИП 15 СНИЛС 11 {ИНН *} 12 {ОГРН *} 13 {ОГРНИП *} 15 {СНИЛС *} 11 КПП 9}
array set sodCert {reqFL  "{C} {Страна} {ST} {Регион} {CN} {ФИО} {SN} {Фамилия} {givenName} {Имя, Отчество} {E} {Электронная почта}
{L} {Населенный пункт}
{street} {Улица, номер дома}
{INN} {ИНН}
{SNILS} {СНИЛС}"
reqUL  "{C} {Страна} {ST} {Регион} {CN} {Организация}
{O} {Наименование организации}
{E} {Электронная почта}
{L} {Населенный пункт}
{street} {Улица, номер дома}
{OU} {Подразделение организации}
{title} {Должность}
{SN} {Фамилия}
{givenName} {Имя, Отчество}
{OGRN} {ОГРН}
{INN} {ИНН}
{UN} {КПП}"
reqIP "{C} {Страна} {ST} {Регион} {CN} {ФИО}
{SN} {Фамилия}
{givenName} {Имя, Отчество}
{E} {Электронная почта}
{L} {Населенный пункт}
{street} {Улица, номер дома}
{INN} {ИНН}
{OGRNIP} {ОГРНИП}
{SNILS} {СНИЛС}"
reqAss  "{C} {Страна} {ST} {Регион} {O} {Организация}
{L} {Населенный пункт}
{street} {Улица, номер дома}
{U} {Подразделение организации}
{title} {Должность}
{INN} {ИНН}
{OGRN} {ОГРН}
{OGRNIP} {ОГРНИП}
{SNILS} {СНИЛС}"
}
#parray sodCert
set reqFL $sodCert(reqFL)

proc create_csr_list3 {tpage c num} {
  puts "LIST1=$c"
  global wizDatacsr
  global wizDatacert
  global rfregions
  global reqFL
  global typeCert
  global sodCert
  global g_iso3166_codes
  set pretext "  Заполните нижележащие поля.
  Эта информация будет помещена в сертификат.
  Поля обязательны для заполнения"
  label $c.lab -text $pretext -wraplength $::scrwidth -highlightthickness 1 -highlightbackground skyblue -highlightcolor skyblue -justify left -anchor w -bg #f5f5f5
  $c.lab configure -font {Times 8 bold italic}
  grid $c.lab -row 0 -column 0 -sticky wsen -padx 4 -pady 4

  if {$tpage == "csr"} {
    array set wizData [array get wizDatacsr]
  } else {
    array set wizData [array get wizDatacert]
  }
  #puts "WIZDATA"
  #puts "INN=$wizData(INN)"
  #parray wizData


  # all optional and required fields
  set i 1 ;# field counter for widgets
  foreach {v req} $typeCert {
    if {$v == $wizData(type) } {
      array set profdate $sodCert($req)
      break
    }
  }
  global profile_options
  array set opts [array get profile_options]
  foreach {v req} $typeCert {
    if {$v == $wizData(type) } {
      array set fieldlabels $sodCert($req)
      set reqFL1 $sodCert($req)
      if {$req == "reqUL"} {
        set wizData(O) $wizData(CN)
      }
      break
    }
  }
  set count [llength $reqFL1]
  set count [expr $count / 2 ]
  set cfirst [expr [expr $count / 2 ] + [expr $count % 2 ]]
  #    puts "CFIRST=$cfirst"
  #    puts "COUNT=$count [expr $count / 2 ] [expr $count % 2 ]"
  #puts "TYPE=$wizData(type)"
  global rfregions
  set oidO 0
  set oidCN -1
  set pp 1

  set wz [subst "wizData$tpage"]

  foreach {field dflt} $reqFL1 {
    if {$pp > $cfirst } {
      break
    }
    set dflt $wizData($field)
    #puts "creating field : $field / $dflt"
    # label
    if { $pp < 10} {
      set label " $pp. $fieldlabels($field)"
    } else {
      set label "$pp. $fieldlabels($field)"
    }
    set label1 "$fieldlabels($field)"
    incr pp

    if {$field == "O"} {
      incr oidO
    } elseif {$field == "CN"} {
      set oidCN $i
    }
    set wzf [subst "$wz\($field\)"]
    if {$field == "C"} {
      labelframe $c.l$i -text "$label ($field)"
      set listISO {}
      foreach {country who} $g_iso3166_codes  {
        lappend listISO $country
      }
      #            ttk::combobox $c.e$i -textvariable [namespace current]::wizData($field) -width 50 -values $listISO -style TCombobox
      ttk::combobox $c.e$i -textvariable $wzf -width 33 -values $listISO -style TCombobox
      if {$wizData($field) == ""} {
        set wizData($field) $dflt
      }
      #puts "listISO=$wizData($field)"
      set tekC [lsearch $listISO {Российская Федерация}]
      $c.e$i delete 0 end
      $c.e$i insert 0 [lindex $listISO $tekC]
      $c.e$i configure -state readonly

    } elseif {$field == "ST"} {
      labelframe $c.l$i -text "$label ($field)"
      ttk::combobox $c.e$i -textvariable $wzf -width 33 -values $rfregions -style TCombobox
      if {$wizData($field) == ""} {
        set wizData($field) $dflt
      }
      set tekC [lsearch $rfregions {Московская область}]
      $c.e$i delete 0 end
      $c.e$i insert 0 [lindex $rfregions $tekC]
      $c.e$i configure -state readonly

    } else  {
      global atrkval
      #Здесь добавить обработку ИНН и т.д.
      #puts "LABEL=\"$label\""
      labelframe $c.l$i -text "$label ($field)" 
      #-wraplength 120
      #             -justify left
      if {[info exists atrkval($label1)]} {
        set len $atrkval($label1)
        #puts "LEN==$len"
        set com "entry $c.e$i -width 34  -textvariable $wzf -validate key -validatecommand {Digit $c.e$i %i %P $len} -highlightthickness 1 -highlightbackground skyblue -highlightcolor skyblue"
        set com1 [subst $com]
        eval $com1
      } else {
        entry $c.e$i -width 34 -textvariable $wzf -highlightthickness 1 -highlightbackground skyblue -highlightcolor skyblue
      }
      $c.e$i delete 0 end
      $c.e$i insert end $dflt
    }
    grid $c.l$i -row $i -column 0 -sticky w -padx 4 -pady 4
#    grid $c.e$i -in $c.l$i -row $i -column 1 -sticky w -padx 4 -pady 4
    pack $c.e$i -in $c.l$i -side top -fill x -padx 4 -pady 4
    #        grid rowconfigure $c $i -weight 0
    incr i
  }
  if {$oidO == 1 && $oidCN > -1} {
    $c.l$oidCN configure -text " 3. Организация (CN)"
  }
  focus $c.e4
}

proc create_csr_list4 {tpage c num} {
  global rfregions
  global reqFL
  global typeCert
  global sodCert
  global g_iso3166_codes
  global wizDatacsr
  global wizDatacert
  set pretext "  Заполните нижележащие поля.
  Эта информация будет помещена в сертификат.
  Поля обязательны для заполнения"
  label $c.lab -text $pretext -wraplength $::scrwidth -highlightthickness 1 -highlightbackground skyblue -highlightcolor skyblue -justify left -anchor w -bg #f5f5f5
  $c.lab configure -font {Times 8 bold italic}
  grid $c.lab -row 0 -column 0 -sticky wsen -padx 4 -pady 4

  if {$tpage == "csr"} {
    array set wizData [array get wizDatacsr]
  } else {
    array set wizData [array get wizDatacert]
  }
  set wz [subst "wizData$tpage"]
  #puts "WIZDATA"
  #puts "INN=$wizData(INN)"
  #parray wizData

  # all optional and required fields
  set i 1 ;# field counter for widgets
  foreach {v req} $typeCert {
    if {$v == $wizData(type) } {
      array set profdate $sodCert($req)
      break
    }
  }
  global profile_options
  array set opts [array get profile_options]
  foreach {v req} $typeCert {
    if {$v == $wizData(type) } {
      array set fieldlabels $sodCert($req)
      set reqFL1 $sodCert($req)
      if {$req == "reqUL"} {
        set wizData(O) $wizData(CN)
      }
      break
    }
  }
  set count [llength $reqFL1]
  set count [expr $count / 2 ]
  set cfirst [expr [expr $count / 2 ] + [expr $count % 2 ]]
  #    puts "CFIRST=$cfirst"
  #    puts "COUNT=$count [expr $count / 2 ] [expr $count % 2 ]"
  #    array set fieldlabels $reqFL
  #puts "TYPE=$wizData(type)"
  global rfregions
  set oidO 0
  set oidCN -1
  set pp 1
  foreach {field dflt} $reqFL1 {
    if {$pp <= $cfirst } {
      incr pp
      continue
    }
    set dflt $wizData($field)
    #puts "creating field : $field / $dflt"
    # label
    if { $pp < 10} {
      set label " $pp. $fieldlabels($field)"
    } else {
      set label "$pp. $fieldlabels($field)"
    }
    set label1 "$fieldlabels($field)"
    incr pp

    # if required
    if {$field == "O"} {
      incr oidO
    } elseif {$field == "CN"} {
      set oidCN $i
    }
    set wzf [subst "$wz\($field\)"]

    if {$field == "C"} {
      labelframe $c.l$i -text "$label ($field)"
      set listISO {}
      foreach {country who} $g_iso3166_codes  {
        lappend listISO $country
      }
      ttk::combobox $c.e$i -textvariable $wzf -width 40 -values $listISO -style TCombobox
      if {$wizData($field) == ""} {
        set wizData($field) $dflt
      }
      #puts "listISO=$wizData($field)"
      set tekC [lsearch $listISO {Российская Федерация}]
      $c.e$i delete 0 end
      $c.e$i insert 0 [lindex $listISO $tekC]

    } elseif {$field == "ST"} {
      labelframe $c.l$i -text "$label ($field)"
      ttk::combobox $c.e$i -textvariable $wzf -width 40 -values $rfregions -style TCombobox
      if {$wizData($field) == ""} {
        set wizData($field) $dflt
      }
      set tekC [lsearch $rfregions {Московская область}]
      $c.e$i delete 0 end
      $c.e$i insert 0 [lindex $rfregions $tekC]

    } else  {
      global atrkval
      #Здесь добавить обработку ИНН и т.д.
      #puts "LABEL=\"$label\""
      labelframe $c.l$i -text "$label ($field)"
      if {[info exists atrkval($label1)]} {
        set len $atrkval($label1)
        #puts "LEN==$len"
        set com "entry $c.e$i -width 34 -textvariable $wzf -validate key -validatecommand {Digit $c.e$i %i %P $len} -highlightthickness 1 -highlightbackground skyblue -highlightcolor skyblue"
        set com1 [subst $com]
        eval $com1
      } else {
        entry $c.e$i -width 34 -textvariable $wzf -highlightthickness 1 -highlightbackground skyblue -highlightcolor skyblue
      }
      $c.e$i delete 0 end
      $c.e$i insert end $dflt
    }
    grid $c.l$i -row $i -column 0 -sticky w -padx 4 -pady 4
    grid $c.e$i -in $c.l$i -row $i -column 1 -sticky w -padx 4 -pady 4
    #        grid rowconfigure $c $i -weight 0
    incr i
  }
  if {$oidO == 1 && $oidCN > -1} {
    $c.l$oidCN configure -text " 3. Организация (CN)"
  }

  if {$wizData(type) == "Юридическое лицо" && $::egais == 1 } {
    #OID 1.2.643.3.6.78.4.4
    #	set lisenze "Лицензиат Росалкогольрегулирования или органов исполнительной власти  субъектов  РФ по розничной продаже алкогольной продукции"
    set lisenze "Лицензиат системы декларирования ФСРАР-лицензиат"
    checkbutton $c.lalko -text $lisenze -wraplength 535 -justify left -variable ::lisalko  -bd 0 -bg wheat3 -activebackground skyblue -padx 0
    grid $c.lalko -row $i -column 0  -columnspan 2 -sticky w -padx 4 -pady 4
  }
  focus $c.e1
}

proc create_csr_list5 {tpage c num} {
  global certfor
  global macos
  global typesys
  global env
  global reqFL
  global typeCert
  global sodCert
  global wizDatacsr
  global wizDatacert
  global certfor
  set filetyperequest {
    {{Запрос на сертификат в DER формате} {.p10}}
    {{Запрос на сертификат в PEM формате} {.csr}}
    {{Любой тип} *}
  }
  set filetypecert {
    {{Certificate (DER)} {.der}}
    {{Certificate (PEM)} {.pem}}
    {{Certificate (DER)} {.p12}}
    {{Certificate (DER)} {.pfx}}
    {{All Files} *}
  }
  set filetypekey {
    {{PrivateKey (PEM)} {.pem}}
    {{PrivateKey (PEM)} {.key}}
    {{All Files} *}
  }
  if {$tpage == "csr"} {
    set wizDatacsr(token) $::slotid_teklab
    array set wizData [array get wizDatacsr]
    set pretext "  Файл с запросом на сертификат в последующем должен быть представлен в УЦ.
    Генерируемый вместе с запросом ключ, будет сохранен на токене [string trim $wizData(token)].
    Это ваш Ключ. Надежно храните его и PIN-код к нему."
    set typefile $filetyperequest
    set labt "Файл для запроса:"
#    .st.fr1.fr2_list3.lab  configure  -text $pretext
  } else {
    set pretext "  Генерируемый вместе с сертификатом закрытый ключ, будет сохранен в защищенном
    контейнере PKCS#12 в каталоге, который вы определите.
    Надежно храните закрытый ключ его и пароль к нему от посторонних глаз."
#    .st.fr1.fr2_list9.lab  configure  -text $pretext
    set wizDatacert(token) $::slotid_teklab
    array set wizData [array get wizDatacert]
    set typefile $filetypecert
    set labt "Папка для сертификатов:"
  }
  label $c.lab -text $pretext -wraplength $::scrwidth -highlightthickness 1 -highlightbackground skyblue -highlightcolor skyblue -justify left -anchor w -bg #f5f5f5
  $c.lab configure -font {Times 8 bold italic}
  grid $c.lab -row 1 -column 0 -sticky nswe -padx 4 -pady {1 1}
 
  set wz [subst "wizData$tpage"]
  set csr_fn [subst "wizData$tpage\(csr_fn\)"]
  set key_fn [subst "wizData$tpage\(key_fn\)"]
  set keypassword [subst "wizData$tpage\(keypassword\)"]

  foreach {v req} $typeCert {
    if {$v == $wizData(type) } {
      array set profdate $sodCert($req)
      break
    }
  }
  set wizData(csr_fn) [file join $env(HOME) $wizData(E).csr]

  labelframe $c.l1 -text $labt
  if {$macos} {
    set typefile ""
  }

  if {$tpage == "csr"} {
    cagui::FileEntry $c.e1 -dialogtype save \
    -variable $csr_fn \
    -title "Введите имя файла для сохранения запроса" \
    -width 32 \
    -defaultextension .csr \
    -initialdir $::myHOME \
    -filetypes $typefile
  } else {
    cagui::FileEntry $c.e1 -dialogtype directory \
    -variable $csr_fn \
    -title "Каталог для сертификатов и ключей" \
    -width 32 \
    -initialdir $::myHOME
  }

  labelframe $c.ftype -text "Формат файла с запросом" 
  #-relief flat -bg white  -highlightthickness 1 -highlightbackground skyblue -highlightcolor skyblue -padx 0
#  label $c.l0 -text "Выберите формат файла:" -bg white -anchor w
  ttk::radiobutton $c.ftype.typeDer -text [mc {DER-format}] -value 0 -variable ::formatCSR -pad 0
  #     -anchor center -bg white  -justify right -highlightthickness 0 -bd 2
  #     -activebackground skyblue
  pack $c.ftype.typeDer -expand 1 -fill x  -side left -padx {10 0} -pady 1
  ttk::radiobutton $c.ftype.typePem -text [mc {PEM-format}] -value 1 -variable ::formatCSR -pad 0
  #     -anchor center -bg white -borderwidth 3  -justify left -highlightthickness 0 -bd 2
  # -activebackground skyblue
  pack $c.ftype.typePem -expand 1 -fill x -side right -padx {0 10} -pady 1
#  grid $c.l0 -row 0 -column 0 -sticky w -padx {4 0} -pady {1 1}
  grid $c.ftype -row 2 -column 0 -sticky nswe -padx 0 -pady {1 1}

  #    set commandnotrequired "namespace eval [namespace current] {if {\$wizData(key_fn) == \"\"} then {set wizData(key_fn) \[file rootname \$wizData(csr_fn)\].key}}"
  grid $c.l1 -row 3 -column 0 -sticky nswe -padx {4 0} -pady 2
  grid $c.e1 -in $c.l1 -row 0 -column 0 -sticky nswe -padx 0 -pady 2

  if {$tpage == "csr"} {
    if {$wizDatacsr(keytok) == 1 } {
      labelframe $c.l2 -text "PIN-код для токена:"
      entry $c.e2  -show * -textvariable $keypassword -highlightthickness 1 -highlightbackground skyblue -highlightcolor skyblue
    } else {
      if {$macos} {
        set ft ""
      } else {
        set ft $filetypekey
      }
      labelframe $c.l2 -text "Файл для закрытого ключа:"
      cagui::FileEntry $c.e2 -dialogtype save \
      -variable $key_fn \
      -title "Введите имя файла для закрытого ключа" \
      -width 47 \
      -defaultextension .key \
      -initialdir $::myHOME \
      -filetypes $ft
    }
    grid $c.l2 -row 4 -column 0 -sticky nswe -padx {4 0} -pady 4
#    grid $c.e2 -in $c.l2 -row 2 -column 0 -sticky nswe -padx 0 -pady 4
    pack $c.e2 -in $c.l2 -fill x -padx 4 -pady 4
  }

  if {$certfor == 0} {
    set bc_opt [lrange $::bc_options 3 4]
  } else {
    set bc_opt [lrange $::bc_options 0 2]
  }
  if {[lsearch $bc_opt $::bc] == -1} {
    set ::bc [lindex $bc_opt 0]
  }

  labelframe $c.lbc -text "Основные ограничения" 
  if {$macos} {
    spinbox $c.bc -width 28 -textvariable ::bc -values $bc_opt -state readonly
  } else {
    ttk::combobox $c.bc -textvariable ::bc -values $bc_opt -state readonly
  }
  grid $c.lbc -row 5 -column 0  -sticky nwse -padx {4 0} -pady 4
#  grid $c.bc -in $c.lbc -row 3 -column 1 -sticky nwse -padx 0 -pady 4
  pack $c.bc -in $c.lbc -fill x -padx 4 -pady 4

  if {$tpage == "cert"} {
    label $c.lpca -text "Точка раздачи CA:"  -bg white -anchor w
    entry $c.pca -width 45 -textvariable ::pointca -bg white -highlightthickness 1 -highlightbackground skyblue -highlightcolor skyblue
    $c.pca delete 0 end
    set lc "bind $c.lpca <Enter> {.helpview configure -text \"Точка выдачи сертификата УЦ\";place .helpview -in $c.lpca -relx 1.0 -rely 0.5}"
    set lc [subst $lc]
    eval $lc
    bind $c.lpca <Leave> {place forget .helpview}

    grid $c.lpca -row 4 -column 0  -sticky nwse -padx {4 0} -pady 2
    grid $c.pca -row 4 -column 1 -sticky nwse -padx 0 -pady 2
    grid columnconfigure $c 1 -weight 1
    label $c.lyear -text "Определите срок действия сертификата (в годах и днях):"  -bg skyblue
    grid $c.lyear -row 5 -column 0 -columnspan 2 -sticky w -padx 4 -pady 0
    ##	spinbox $c.years -from 0 -to 25 -state readonly -textvariable ::yearcert -justify right
    ##	grid $c.years -row 6 -column 0 -columnspan 1 -sticky w -padx {4 0} -pady 4
    ##	scale $c.days -from 0 -to 366 -tickinterval 30 -orient horizontal -variable ::dayscert -showvalue true
    ##	grid $c.days -row 6 -column 1 -columnspan 1 -sticky wnes -padx 0 -pady 4
    #	spinbox $c.years -from 0 -to 25 -state readonly -textvariable ::yearcert -justify right -width 5
    #	grid $c.years -row 6 -column 0 -columnspan 2 -sticky w -padx {4 0} -pady 2
    #	scale $c.days -from 0 -to 366 -tickinterval 30 -orient horizontal -variable ::dayscert -showvalue true -length 480 -width 8  -font {Times 8 bold roman} -bg snow
    #	grid $c.days -row 6 -column 0 -columnspan 2 -sticky e -padx 0 -pady 2
    spinbox $c.years -from 0 -to 25 -state readonly -textvariable ::yearcert -justify right -width 5
    grid $c.years -row 6 -column 0 -columnspan 2 -sticky w -padx {4 0} -pady 2
    ttk::label $c.ld -textvariable ::dayscert2
    ttk::style configure TScale  -background white
    ttk::scale $c.days -from 0 -to 366 -orient horizontal -variable ::dayscert -length 480 -value 0 -command fscale
    #	-showvalue true -length 480 -bg snow -troughcolor skyblue ::dayscert
    #  -tickinterval
    grid $c.ld -row 6 -column 0 -columnspan 1 -sticky e -padx 0 -pady 2
    grid $c.days -row 6 -column 1 -columnspan 1 -sticky e -padx 0 -pady 2

    label $c.lpw -text "Пароль для PKCS#12:"  -bg skyblue -anchor w -font TkDefaultFontBold
    entry $c.pw  -show * -textvariable ::pw -highlightthickness 1 -highlightbackground skyblue -highlightcolor skyblue
    grid $c.lpw -row 7 -column 0  -sticky nwse -padx {4 0} -pady 2
    grid $c.pw -row 7 -column 1 -sticky nwse -padx 0 -pady 2
    label $c.lrpw -text "Повторите пароль:"  -bg skyblue -anchor w -font TkDefaultFontBold
    entry $c.rpw  -show * -textvariable ::rpw -highlightthickness 1 -highlightbackground skyblue -highlightcolor skyblue
    grid $c.lrpw -row 8 -column 0  -sticky nwse -padx {4 0} -pady 0
    grid $c.rpw -row 8 -column 1 -sticky nwse -padx 0 -pady 0
  }

  #puts "FILE=$wizData(csr_fn)"
  focus $c.e1.entry
}

proc create_csr_list6 {tpage c num} {
  global reqFL
  global typeCert
  global sodCert
  global g_iso3166_codes
  global wizDatacsr
  global wizDatacert
  if {$tpage == "csr"} {
    set wizDatacsr(token) $::slotid_teklab
    set pretext "  Внимательно просмотрите запрос, который вы создаете.
Если все нормально, то Нажмите \"Завершение\" для генерации ключевой пары и \
создания Запроса на Сертификат с сохранением в файле"
    array set wizData [array get wizDatacsr]
#    .st.fr1.fr2_list3.lab  configure  -text $pretext
  } else {
    if {$::formatCSR == 0 } {
      set wizDatacert(key_fn) [file join $wizDatacert(csr_fn) selfkey_$::snforcert.der]
    } else {
      set wizDatacert(key_fn) [file join $wizDatacert(csr_fn) selfkey_$::snforcert.pem]
    }
    set wizDatacert(token) $::slotid_teklab
    set pretext "  Внимательно просмотрите сертификат, который вы создаете.
Если все нормально, то Нажмите \"Завершение\" для генерации ключевой пары и \
создания Сертификата с сохранением в файле"
    array set wizData [array get wizDatacert]
#    .st.fr1.fr2_list9.lab  configure  -text $pretext
  }
  label $c.lab -text $pretext -wraplength $::scrwidth -highlightthickness 1 -highlightbackground skyblue -highlightcolor skyblue -justify left -anchor w -bg #f5f5f5
  $c.lab configure -font {Times 8 bold italic}
#  grid $c.lab -row 1 -column 0 -sticky nswe -padx 4 -pady {1 1}
  pack $c.lab -side top -expand 1 -fill x

  text $c.t1 -yscrollcommand [list $c.vsb set]  -font {Times 8 bold italic}  -heigh 16
  ttk::scrollbar $c.vsb -orient vertical -command [list $c.t1 yview]

  set fnt(std) [$c.t1 cget -font]
  set fnt(bold) [list [lindex $fnt(std) 0] [lindex $fnt(std) 1] bold]
  $c.t1 tag configure bold -font $fnt(bold) -foreground blue

  $c.t1 insert end "Владелец сертификата:\n" bold
  $c.t1 insert end "  $wizData(type)\n"
  $c.t1 insert end "Subject Distinguished Name:\n" bold
  foreach {v req} $typeCert {
    if {$v == $wizData(type) } {
      array set profdate $sodCert($req)
      set reqFL1 $sodCert($req)
      break
    }
  }
  global profile_options
  array set opts [array get profile_options]
  array set fieldlabels $reqFL1
  set wizData(dn) ""
  set wizData(dncsr) {}
  foreach {field dflt} $reqFL1 {
    if {$wizData($field)!= ""} {
      #puts "creating field : $field / $dflt"
      # label
      set kpp ""
      set label $fieldlabels($field)
      if {$field == "C" } {
        foreach {country who} $g_iso3166_codes  {
          if {$country == $wizData($field) } {
            append wizData(dn) "$field = $who\n"
            lappend wizData(dncsr) $field
            lappend wizData(dncsr) $who
            break
          }
        }
      } elseif {$field == "E" } {
        append wizData(dn) "emailAddress = $wizData($field)\n"
        lappend wizData(dncsr) email
        lappend wizData(dncsr) $wizData($field)
      } elseif {$field == "UN" && $::egais == 1  && $wizData(type) == "Юридическое лицо"} {
        append wizData(dn) "$field = $wizData($field)\n"
        lappend wizData(dncsr) $field
        lappend wizData(dncsr) "КПП=$wizData($field)"
        set kpp "КПП="
      } else {
        append wizData(dn) "$field = $wizData($field)\n"
        lappend wizData(dncsr) $field
        lappend wizData(dncsr) $wizData($field)
      }
      $c.t1 insert end "  $label ($field) = $kpp$wizData($field)\n"
    }
  }
  if {$::egais == 1 && $wizData(type) == "Индивидуальный предприниматель"} {
    set label "КПП (UN)"
    $c.t1 insert end "  $label = КПП=\n"
    #        append wizData(dn) "UN = \n"
    lappend wizData(dncsr) "UN"
    lappend wizData(dncsr) "КПП="
    lappend wizData(dncsr) "title"
    lappend wizData(dncsr) "Индивидуальный предприниматель"
  }
  #puts "DNCSR=$wizData(dncsr)"
  if {$tpage == "csr"} {
    set wizDatacsr(dncsr) $wizData(dncsr)
  } else {
    set wizDatacert(dncsr) $wizData(dncsr)
  }
  $c.t1 insert end "Сведения о ключе:\n" bold
  $c.t1 insert end "  Тип ключа = $wizData(typekey)\n"
  $c.t1 insert end "  Параметры ключа = $wizData(parkey)\n"
  if {$tpage == "csr"} {
    $c.t1 insert end "  Генерация ключа на токене = $wizData(token)\n"
  } else {
    $c.t1 insert end "  Ключ будет сохранен в файле = [file join $wizData(csr_fn) rootCA.key]\n"
  }
  if {$wizData(ckzi) != 0} {
    $c.t1 insert end "  Наименование СКЗИ = $wizData(ckzi)\n"
  }
  if {$tpage == "csr"} {
    $c.t1 insert end "Запрос будет сохранен в файле = $wizData(csr_fn)\n" bold
  } else {
    $c.t1 insert end "Сертификат будет сохранен в каталоге = $wizData(csr_fn)\n" bold
  }
  if {$::formatCSR == 1} {
    set format "PEM"
  } else {
    set format "DER"
  }
  $c.t1 insert end "Формат файла = $format\n" bold

  $c.t1 configure  -state disabled

  pack $c.vsb -side right -fill y
  pack $c.t1 -side top -expand 1 -fill both
}


#Запрос на сертификат
proc func_page3 {c} {
puts "func_page3 START"
    set funcs [list create_csr_list1 create_csr_list3 create_csr_list4 create_csr_list5 create_csr_list6]
    set wiz $c
    set countp [llength $funcs]
    set ::pagescsr [wizard "csr" $wiz $countp $funcs]
puts "func_page3 END"
}

#Страница работы с Сертификатами/Запросами
proc func_page4 {c} {
  global env
  global reqFL
  global typeCert
  global sodCert
  variable csr_fn
  set csr_fn ""
  variable cert_fn
  set cert_fn ""
  variable opcert
  set opcert 0
  variable dir_crt
  set dir_crt ""
  global macos
  global typesys
  global macos
  variable opcertp11
  set opcertp11 0
  
  set filetyperequest {
    {{Запрос на сертификат (DER)} {.p10}}
    {{Запрос на сертификат (PEM)} {.csr}}
    {{Запрос на сертификат (DER)} {.der}}
    {{Запрос на сертификат (PEM)} {.pem}}
    {{Любой тип} *}
  }
  set filetypecert {
    {{Сертификат в DER формате}    .der}
    {{Сертификат в DER формате}    .cer}
    {{Сертификат в PEM формате}    .pem}
    {{Сертификат в PEM формате}    .crt}
    {{Любой тип}    *}
  }

    labelframe $c.tok -text "Сертификаты токена"  -borderwidth 5
    ttk::combobox $c.tok.listCert -textvariable nickCert -state readonly -values $::listx509
    button $c.tok.viewcert -command {if {[info exists nickCert]} {::viewCert "pkcs11" $nickCert}} -image ::img::view_18x16 -compound left -pady 0 -bd 0 -bg white -highlightthickness 0
    pack $c.tok.listCert -side left  -padx {2 1} -pady {1 0} -ipady 1  -expand 1 -fill x
    pack $c.tok.viewcert -side right -padx {0 5} -pady 0 -expand 0 -fill none
    pack $c.tok -fill both -side top -padx 10 -pady 4

 label $c.lsep0 -text "Просмотр запроса на сертификат" -font TkDefaultFontBold -bg #eff0f1 -highlightthickness 1 -highlightbackground skyblue -highlightcolor skyblue
    pack $c.lsep0 -fill both -side top -padx 10
  labelframe $c.fscr -text "Файл с запросом:" -relief flat -pady 2 -padx 0
  if {$typesys == "win32"} {
    set ww 58
  } elseif {$macos } {
    set ww 63
  } else {
    set ww 30
  }
  if {$macos} {
    set ft ""
  } else {
    set ft $filetyperequest
  }

  cagui::FileEntry $c.fscr.e1 -dialogtype open \
  -title "Выберите файл с запросом" \
  -width $ww \
  -defaultextension .csr \
  -variable  csr_fn \
  -initialdir $::myHOME \
  -filetypes $ft
  pack $c.fscr.e1 -side left -expand 1 -fill both
  button  $c.fscr.viewscr -command {variable csr_fn;::viewCSR  $csr_fn 1} -image ::img::view_18x16 -compound right -bd 0 -background white -activebackground white -highlightthickness 0
  pack $c.fscr.viewscr -side right -padx {4 0} -pady 0 -expand 0 -fill none
    pack $c.fscr -fill both -side top -padx 10
################################
 label $c.lsep -text "Работа с сертификатами из файлов" -font TkDefaultFontBold -bg #eff0f1 -highlightthickness 1 -highlightbackground skyblue -highlightcolor skyblue
    pack $c.lsep -fill both -side top -padx 10

  labelframe $c.fcrt -text "Файл с сертификатом" -relief flat -pady 2 -padx 0
  if {$macos} {
    set ft ""
  } else {
    set ft $filetypecert
  }

  cagui::FileEntry $c.fcrt.e2 -dialogtype open \
  -title "Выберите файл с сертификатом" \
  -width 30 \
  -defaultextension .der \
  -variable  cert_fn \
  -initialdir $::myHOME \
  -filetypes $ft
  pack $c.fcrt.e2 -side left -expand 1 -fill both
  button  $c.fcrt.viewcrt -command {variable opcert; set z $opcert;set opcert 2;::workOpCert;set opcert $z} -image ::img::view_18x16 -compound right -bd 0 -background white -activebackground white -highlightthickness 0
  pack $c.fcrt.viewcrt -side right -padx {2 0} -pady 0 -expand 0 -fill none
  ########

  labelframe $c.lfr1 -text "Выполняемая операция с сертификатом"
  ttk::radiobutton $c.lfr1.rb1 -value 0 -variable opcert -text "Цепочка/Проверка подписи"
  ttk::radiobutton $c.lfr1.rb2 -value 1 -variable opcert -text "Проверка валидности"
  #    radiobutton $c.lfr1.rb3 -value 2 -variable opcert -text "Просмотр сертификата" -highlightthickness 0
  ttk::radiobutton $c.lfr1.rb4 -value 3 -variable opcert -text "Импорт сертификата на токен"
  ttk::checkbutton $c.lfr1.chb4 -variable ::certegais -text "Сертификат для ЕГАИС"

  grid $c.lfr1.rb1 -row 0 -column 0 -sticky w -padx {4 0} -pady {0 3}
  grid $c.lfr1.rb2 -row 1 -column 0 -sticky w -padx {4 0} -pady {0 3}
  grid $c.lfr1.rb4 -row 2 -column 0 -sticky w -padx {4 0} -pady {0 4}
  grid $c.lfr1.chb4 -row 3 -column 0 -sticky w -padx {4 0} -pady {0 4}
    pack $c.fcrt -fill both -side top -padx 10
  ttk::button  $c.b2 -command {::workOpCert} -text "Выполнить операцию" -style My.TButton
    pack $c.lfr1 -fill both -side top -padx 10
    pack $c.b2 -fill both -side top -padx 10
 label $c.lsep1 -text "Работа с сертификатами на токене" -font TkDefaultFontBold -bg #eff0f1 -highlightthickness 1 -highlightbackground skyblue -highlightcolor skyblue
    pack $c.lsep1 -fill both -side top -padx 10
  labelframe $c.lfr2 -text "Операция с сертификатом на токене"
  ttk::radiobutton $c.lfr2.rb0 -value 4 -variable opcertp11 -text "Удалить сертификат с токена"
  ttk::radiobutton $c.lfr2.rb1 -value 0 -variable opcertp11 -text "Цепочка/Проверка подписи"
  ttk::radiobutton $c.lfr2.rb2 -value 1 -variable opcertp11 -text "Проверка валидности"
  ttk::radiobutton $c.lfr2.rb4 -value 2 -variable opcertp11 -text "Экспорт сертификата в PEM"
  ttk::radiobutton $c.lfr2.rb5 -value 3 -variable opcertp11 -text "Экспорт сертификата в DER"
  ttk::radiobutton $c.lfr2.rb6 -value 5 -variable opcertp11 -text "Сменить nickname"

  grid $c.lfr2.rb0 -row 0 -column 0 -sticky w -padx {4 0} -pady {0 3}
  grid $c.lfr2.rb1 -row 1 -column 0 -sticky w -padx {4 0} -pady {0 3}
  grid $c.lfr2.rb2 -row 2 -column 0 -sticky w -padx {4 0} -pady {0 3}
  grid $c.lfr2.rb4 -row 3 -column 0 -sticky w -padx {4 0} -pady {0 4}
  grid $c.lfr2.rb5 -row 4 -column 0 -sticky w -padx {4 0} -pady {0 4}
  grid $c.lfr2.rb6 -row 5 -column 0 -sticky w -padx {4 0} -pady {0 4}
  ttk::button  $c.b3 -command {::workOpCertP11 $opcertp11} -text "Выполнить операцию"
    pack $c.lfr2 -fill both -side top -padx 10
    pack $c.b3 -fill both -side top -padx 10
}

#Страница работы с PKCS#12
proc func_page7 {c} {
  variable nickCert
  variable file_for_sign
  set file_for_sign ""
  variable doc_for_sign
  set doc_for_sign ""
  variable createTimeStamp
  set createTimeStamp 0
  variable createescTS
  set createescTS 0
  variable typesig
  set typesig 1
  variable friendly
  global macos
  global env
  global reqFL
  global typeCert
  global sodCert
  variable pfx_fn
  set pfx_fn ""
  variable src_fn
  set src_fn ""
  variable top12
  set top12 2
  variable ts12
  set ts12 0
  variable exp12
  set exp12 0
  variable varTypeSign
  set varTypeSign  0
  set varescTS  0
    set filetypep12 {
	{{PKCS12} {.pfx}}
	{{PKCS12} {.p12}}
	{{All Files} *}
    }
    labelframe $c.tok -text "Выберите токен PKCS11"  -borderwidth 5
    ttk::combobox $c.tok.listTok -textvariable ::nickTok -values $::listtok
    set ::nickTok [lindex $::listtok 0]
#    button $c.tok.viewtok -command {if {[info exists nickCert]} {::viewCert "pkcs11" $nickCert}} -image ::img::view_18x16 -compound left -pady 0 -bd 0 -bg white -highlightthickness 0
    pack $c.tok.listTok -side top  -padx {2 1} -pady {1 0} -ipady 1  -expand 1 -fill x
#    pack $c.tok.viewtok -side right -padx {0 5} -pady 0 -expand 0 -fill none
    pack $c.tok -fill both -side top -padx 10 -pady {4 10}

    labelframe $c.cert -text "Сертификаты токена"  -borderwidth 5
    ttk::combobox $c.cert.listCert -textvariable nickCert -values $::listx509
#     -state readonly
    button $c.cert.viewcert -command {if {[info exists nickCert]} {::viewCert "pkcs11" $nickCert}} -image ::img::view_18x16 -compound left -pady 0 -bd 0 -bg white -highlightthickness 0
    pack $c.cert.listCert -side left  -padx {2 1} -pady {1 0} -ipady 1  -expand 1 -fill x
    pack $c.cert.viewcert -side right -padx {0 5} -pady 0 -expand 0 -fill none
#    pack $c.cert -fill both -side top -padx 10 -pady 4
    pack $c.cert -in $c.tok -fill both -side top -padx {2 1} -pady 4

#    ttk::labelframe $c.fr0 -text "Файл с PKCS12" 
    labelframe $c.fr0 -text "Файл с PKCS12"  -borderwidth 5
    cagui::FileEntry $c.fr0.e1 -dialogtype open \
	-title "Файл с PKCS12" \
	-width 30 \
	-defaultextension .pfx \
	-variable pfx_fn \
	-initialdir $::myHOME \
	-filetypes $filetypep12
    pack $c.fr0.e1 -side right  -padx {2 1} -pady {1 0} -ipady 1  -expand 1 -fill x
#    ttk::labelframe $c.frc -text "Просмотр сертификата из контейнера"
    labelframe $c.frc -text "Просмотр сертификата из контейнера"
    pack $c.fr0 -fill both -side top -padx 10
    set ::nomacver 0
#    label $c.frc.labCert -text "friendlyName:" -anchor w -width 0 -bg white
#    pack $c.frc.labCert  -padx 0 -pady 0 -side left  -expand 0 -fill both
#    ttk::entry $c.frc.listCert -textvariable friendly -state normal 
    entry $c.frc.listCert -textvariable friendly -state normal -highlightthickness 1 -highlightbackground skyblue -highlightcolor skyblue -width 25
    pack $c.frc.listCert -side left  -padx 4 -pady 0 -expand 1 -fill x
    ttk::checkbutton $c.frc.mac -text "nomac" -variable ::nomacver -compound left
    pack $c.frc.mac  -padx 0 -pady 0 -side left  -expand 0 -fill none
    button  $c.frc.viewcert -command {::viewCert "pkcs12" $::certfrompfx} -image ::img::view_18x16 -compound left -pady 0 -bd 0 -bg white -activebackground white -highlightthickness 0
    pack $c.frc.viewcert -side right -padx {0 5} -pady 0 -expand 0 -fill none
    pack $c.frc -fill both -side top -padx 10 -pady 8

#    ttk::labelframe $c.frdoc -text "Документ для подписи:"
    labelframe $c.frdoc -text "Документ для подписи:"
    set wd 30
    if {$macos} {
	set ft ""
    } else {
	set ft $::filetypesrc
    }
    cagui::FileEntry $c.frdoc.e1 -dialogtype open \
	-title "Выберите документ для подписи" \
	-width $wd \
	-defaultextension .txt \
	-variable  doc_for_sign \
	-initialdir $::myHOME \
	-filetypes $ft
    pack $c.frdoc.e1 -side right  -padx {2 1} -pady {1 0} -ipady 1  -expand 1 -fill x
    pack $c.frdoc -fill both -side top -padx 10

#    ttk::labelframe $c.frdir -text "Папка для подписи:"
    labelframe $c.frdir -text "Папка для подписи и/или сертификата:"
    cagui::FileEntry $c.frdir.e2 -dialogtype directory \
	-title "Папка для хранения подписи" \
	-width $wd \
	-variable  file_for_sign \
	-initialdir $::myHOME
    pack $c.frdir.e2 -side right  -padx {2 1} -pady {1 0} -ipady 1  -expand 1 -fill x
    pack $c.frdir -fill both -side top -padx 10  -pady 8
#    ttk::labelframe $c.lfr0 -text "Тип и формат электронной подписи"  -labelanchor n
    labelframe $c.lfr0 -text "Тип и формат электронной подписи"  -labelanchor n
    ttk::checkbutton $c.lfr0.chb0 -variable typesig -text "Присоединенная подпись" -pad 0
    ttk::radiobutton $c.lfr0.chb1 -value 0 -variable createescTS -text "CAdes-BES" -pad 0
    ttk::radiobutton $c.lfr0.chb2 -value 1 -variable createescTS -text "CAdes-T" -pad 0
    ttk::radiobutton $c.lfr0.chb3 -value 2 -variable createescTS -text "CAdes-XLT1" -pad 0
    grid $c.lfr0.chb0 -row 0 -column 0 -columnspan 3 -sticky w -padx {14 0} -pady {0 12}
    grid $c.lfr0.chb1 -row 1 -column 0 -sticky w -padx {14 0} -pady {0 12}
    grid $c.lfr0.chb2 -row 1 -column 1 -sticky w -padx {10 0} -pady {0 12}
    grid $c.lfr0.chb3 -row 1 -column 2 -sticky w -padx {10 0} -pady {0 12}
    pack $c.lfr0 -fill both -side top -padx 10
    ttk::frame $c.tsp
    label $c.tsp.tsp -text "Сервер TSP:" -anchor w -bg white  -width 0 -height 0
    if {$macos} {
	spinbox $c.tsp.listTSP  -textvariable ::tekTSP -values $::listtsp -width $wd -background white
    } else {
	ttk::combobox $c.tsp.listTSP  -textvariable ::tekTSP -values $::listtsp -width $wd -background white -style TCombobox
    }
    set ::tekTSP [lindex $::listtsp 0]
    pack $c.tsp.tsp -side left
    pack $c.tsp.listTSP -side left -fill x -expand 1
    pack $c.tsp -fill both -side top -padx 10
    set com "ttk::button  $c.b2 -command {::sign_file  $c \"pkcs12\"} -text \"Подписать документ\""
    eval [subst $com]
#    pack $c.b2 -side top -anchor nw -padx 5 -pady 4
    pack $c.b2 -side top -anchor center -padx 5 -pady 4

    labelframe $c.lfr1 -text "Дополнительные операции" -bd 5 -bg skyblue
    ttk::radiobutton $c.lfr1.rb1 -value 0 -variable top12 -text "Сертификат на токен"
    ttk::radiobutton $c.lfr1.rb2 -value 1 -variable top12 -text "Ключ на токен"
    ttk::checkbutton $c.lfr1.ch0 -variable exp12 -text "Неэкспортируемый"
    ttk::radiobutton $c.lfr1.rb3 -value 2 -variable top12 -text "Сертификат в файл"
    ttk::checkbutton $c.lfr1.ch1 -variable ts12 -text "PEM-формат"
    grid $c.lfr1.rb1 -row 1 -column 0 -sticky news -padx {4 0} -pady {0 2}
    grid $c.lfr1.rb2 -row 2 -column 0 -sticky news -padx {4 0} -pady {0 0} -ipadx 0
#  grid $c.lfr1.ch0 -row 2 -column 1 -sticky w -padx {4 0} -pady {0 2}


    grid $c.lfr1.rb3 -row 0 -column 0 -columnspan 1 -sticky wens -padx {4 0} -pady {0 2}
    grid $c.lfr1.ch1 -row 0 -column 1 -columnspan 1 -sticky wnse -padx {4 0} -pady {0 2}
    pack $c.lfr1 -fill both -side top -padx 10
    ttk::button  $c.b3 -command {::workOpP12 } -text "Выполнить операцию"
    pack $c.b3 -side top -anchor nw  -padx 5 -pady 4 

    if {$c == ".fn7"} {
	trace variable pfx_fn w trace_pfx
    }
}

proc ::deleteallobj {} {
  global yespas
  global pass
  variable ::handleObj
  variable ::listObjs
  catch {::pki::pkcs11::logout $::handle $::slotid_tek}
  wm title .topPinPw "Токен: $::slotid_teklab"
  wm state .topPinPw normal
  wm state .topPinPw withdraw
  wm state .topPinPw normal
  raise .topPinPw
  grab .topPinPw
  focus .topPinPw.labFrPw.entryPw
  set yespass ""
  vwait yespas
  grab release .topPinPw
  #Ввод пароля
  if { $yespas == "no" } {
    return 0
  }
  set yespas "no"
  set password $pass
  set pass ""
        	
  if { [pki::pkcs11::login $::handle $::slotid_tek $password] == 0 } {
    tk_messageBox -title "Очистить токен" -message "Доступ к токену не получен" -detail "Проверьте PIN-код" -icon error  -parent .
    return 0
  }
  set password ""

  set allobjs [::pki::pkcs11::listobjects $::handle $::slotid_tek "all"]
  #    catch {::pki::pkcs11::logout $::handle $::slotid_tek}
  foreach obj $allobjs {
    #    lappend ::listObjs [lindex $obj 1]
    #	puts "$obj"
    set aa [dict create pkcs11_handle $::handle pkcs11_slotid $::slotid_tek]
    lappend aa "hobj"
    lappend aa [lindex $obj 1]
    set err [::pki::pkcs11::delete obj $aa]
  }
  ::updatetok
  return 1
}


proc p11status {} {
  if {$::pkcs11_status == 1 } {
    tk_messageBox -title "Используемый токен"   -icon info -message "Нет подключенных токенов." -parent .
    return
  }
  if {$::pkcs11_status == 3 } {
    tk_messageBox -title "Используемый токен"   -icon info -message "Токен не лицензирован." -detail "Обратитесь к вкладке \"Создать токены\"" -parent .
    return
  }
  if {$::pkcs11_status == 2 } {
    tk_messageBox -title "Используемый токен"   -icon info -message "Токен еще не проинициализирован." -parent .
    return
  }
  return $::pkcs11_status
}

#Страница конфигурирования токена
proc p11conf {c} {
global ::handle 
global ::slotid_tek
  variable optok
  if {$::pkcs11_status == 3 } {
    tk_messageBox -title "Используемый токен"   -icon info -message "Токен не лицензирован."
    return
  }
  if {$::pkcs11_status == 2 && $optok != 0} {
    tk_messageBox -title "Используемый токен"   -icon info -message "Сначало проинициализируйте токен."
    return
  }

  switch $optok {
    0 {
      if {$::pkcs11_status == 0} {
        set answer [tk_messageBox -icon question \
    	    -title "Инициализация токена" \
    	    -message "Токен проинициализирован ранее." \
    	    -detail "Повторная инициализация приведет к потере данных\nБудете продолжать?" \
	    -type yesno]

        if {$answer != "yes"} {
    	    return 0
        }
      }

      set ltok [$c.lfr2.entTok get]
      set sopin [$c.lfr2.entSoPin get]
      set upin [$c.lfr2.entUserPin get]
      set rupin [$c.lfr2.entRepUserPin get]
      if {$ltok == "" || $sopin == "" || $upin == "" || $rupin == "" || $upin != $rupin} {
        tk_messageBox -title "Инициализация токена" -icon info -message "Ошибка в заполнении полей. Будьте внимательны!" \
        -detail "upin=$upin\nrupin=$rupin\nltok=$ltok\nsopin=$sopin"
        return
      }
#tk_messageBox -title "Инициализация токена" -icon info -message "HANDLE=$::handle $::slotid_tek $sopin $ltok"
       ::updatetok
      if {$::slotid_tek == -10} {
        set ::slotid_tek 0
      }
#wm state . withdraw
#      tk_messageBox -title "Инициализация токена" -icon info -message "START INITTOKEN\n$::handle $::slotid_tek $sopin $ltok"
#set ::slotid_tek 0
      set ret [::pki::pkcs11::inittoken $::handle $::slotid_tek $sopin $ltok]
#      set ret [pki::pkcs11::inittoken $::handle 0 $sopin $ltok]

#      tk_messageBox -title "Инициализация токена" -icon info -message "INITTOKEN END\n$::handle $::slotid_tek $sopin $ltok"
#wm state . normal
#set slots [pki::pkcs11::listslots $::handle]

      if {!$ret} {
        tk_messageBox -title "Инициализация токена" -icon error -message "Неудача\nПроверьте SO-PIN-код"
        return
      }
#tk_messageBox -title "Инициализация токена" -icon info -message "INITTOK OK\n$::handle $::slotid_tek $sopin $ltok"
      catch {::pki::pkcs11::logout $::handle $::slotid_tek}
#tk_messageBox -title "Инициализация токена" -icon info -message "START INITUSERPIN\n$::handle $::slotid_tek $sopin $upin\ninituserpin"
      set oldpin "11111111"
      ::pki::pkcs11::inituserpin $::handle $::slotid_tek $sopin $oldpin
      if {!$ret} {
        tk_messageBox -title "Инициализация токена" -icon error -message "Неудача 1\n" \
        -detail "Проверьте SO-PIN-код"
        return
      }
#tk_messageBox -title "Инициализация токена" -icon info -message "INITUSERPINУ OK\nустановили первый пароль\n$oldpin"
#      catch {::pki::pkcs11::logout $::handle $::slotid_tek}
      set ret [::pki::pkcs11::setpin $::handle $::slotid_tek user $oldpin $upin]	
      if {$ret} {
        tk_messageBox -title "Инициализация токена" -icon info -message "Токен успешно проинициализирован" \
        -detail "Храните надежно и токен \"$ltok\" и PIN-коды"
        $c.lfr2.entSoPin delete 0 end
        $c.lfr2.entUserPin delete 0 end
        $c.lfr2.entRepUserPin delete 0 end
      } else {
        tk_messageBox -title "Инициализация токена" -icon error -message "Инициализация 2 токена не удалась" \
        -detail "Проверьте SO-PIN-код"
      }
      ::updatetok
    }
    1 {
      set tpin [$c.lfr2.entSoPin get]
      if {$tpin == ""} {
        tk_messageBox -title "Смена пользовательского PIN-кода" -icon info -message "Не задан текущий PIN-код. Будьте внимательны!"
        return
      }
      set upin [$c.lfr2.entUserPin get]
      set rupin [$c.lfr2.entRepUserPin get]
      if {$upin == "" || $rupin == "" || $upin != $rupin} {
        tk_messageBox -title "Смена пользовательского PIN-кода" -icon info -message "Ошибка в новом PIN-коде. Будьте внимательны!" \
        -detail "upin=$upin\nrupin=$rupin"
        return
      }
      catch {::pki::pkcs11::logout $::handle $::slotid_tek}
      set ret [::pki::pkcs11::setpin $::handle $::slotid_tek user $tpin $upin]
      catch {::pki::pkcs11::logout $::handle $::slotid_tek}
      if {$ret} {
        tk_messageBox -title "Смена пользовательского PIN-кода" -icon info -message "Новый PIN-код установлен" \
        -detail "Храните надежно и токен и PIN-коды" 
        $c.lfr2.entSoPin delete 0 end
        $c.lfr2.entUserPin delete 0 end
        $c.lfr2.entRepUserPin delete 0 end
      } else {
        tk_messageBox -title "Смена пользовательского PIN-кода" -icon error -message "Сменить PIN-код не удалось" \
        -detail "Проверьте текущий PIN-код"
      }
    }
    2 {
      set sopin [$c.lfr2.entSoPin get]
      set upin [$c.lfr2.entUserPin get]
      set rupin [$c.lfr2.entRepUserPin get]
      if {$sopin == "" || $upin == "" || $rupin == "" || $upin != $rupin || $upin == "87654321"} {
        tk_messageBox -title "Смена SO-PIN-а" -icon info -message "Ошибка в заполнении полей. Будьте внимательны!" \
        -detail "SO-PIN не может быть равен первоначальному значению" -parent .
        return
      }
      #      catch {::pki::pkcs11::logout $::handle $::slotid_tek}
#      catch {set ::handle [pki::pkcs11::unloadmodule $::handle]}
#      catch {set ::handle [pki::pkcs11::loadmodule "$::pkcs11_module"]}
      ::updatetok
      if {$::slotid_tek == -10} {
        set ::slotid_tek 0
      }
      set ret [::pki::pkcs11::setpin $::handle $::slotid_tek so $sopin $upin]
      #      catch {::pki::pkcs11::logout $::handle $::slotid_tek}
      if {$ret} {
        tk_messageBox -title "Смена SO-PIN-кода" -icon info -message "Новый SO-PIN-код установлен" \
        -detail "Храните надежно и токен и PIN-коды" -parent .
        $c.lfr2.entSoPin delete 0 end
        $c.lfr2.entUserPin delete 0 end
        $c.lfr2.entRepUserPin delete 0 end
      } else {
        tk_messageBox -title "Смена SO-PIN-кода" -icon error -message "Сменить SO-PIN-код не удалось" \
        -detail "Проверьте текущий SO-PIN-код" -parent .
      }
      ::updatetok
    }
    3 {
      set sopin [$c.lfr2.entSoPin get]
      set upin [$c.lfr2.entUserPin get]
      set rupin [$c.lfr2.entRepUserPin get]
      if {$sopin == "" || $upin == "" || $rupin == "" || $upin != $rupin} {
        tk_messageBox -title "Деблокировать USER-PIN" -icon info -message "Ошибка в заполнении полей. Будьте внимательны!" \
        -detail "upin=$upin\nrupin=$rupin\nsopin=$sopin" -parent .
        return
      }
      set ret [::pki::pkcs11::inituserpin $::handle $::slotid_tek $sopin $upin]
      if {$ret} {
        tk_messageBox -title "Деблокировать USER-PIN" -icon info -message "Ваш PIN-код разблокирован" \
        -detail "Храните надежно и токен и PIN-коды" -parent .
        $c.lfr2.entSoPin delete 0 end
        $c.lfr2.entUserPin delete 0 end
        $c.lfr2.entRepUserPin delete 0 end
      } else {
        tk_messageBox -title "Деблокировать USER-PIN" -icon error -message "Разблокировать PIN-код не удалось" \
        -detail "Проверьте PIN-коды" -parent .
      }
    }
    4 {
wm state . withdraw
      set ret [::deleteallobj]
wm state . normal
      if {$ret} {
        tk_messageBox -title "Очистить токен" -icon info -message "Токен \"$::slotid_teklab\" очищен"  -parent .
      }
    }
  }

}

proc setoptok {c} {
  set listop [list "Для инициализации токена \nзаполните следующие поля:" "Для смены USER-PIN \nзаполните следующие поля:" \
  "Для смены SO-PIN \nзаполните следующие поля:" "Для разблокировки USER-PIN \nзаполните следующие поля:" \
  "Очистка токена: \nвсе данные будут уничтожены"]
  variable optok
  variable laboptok
  set laboptok [lindex $listop $optok]
  #  pack forget $c.butop
  switch $optok {
    0 {
#	$c.lfr2 configure -state normal
      grid $c.lfr2.labTok -column 0 -padx 5 -pady 2 -row 0 -sticky we
      grid $c.lfr2.entTok -column 0 -padx 2 -pady 2 -row 1 -sticky we -padx {0 5}
              pack $c.lfr2 -side top -fill x -padx 20
#      grid $c.lfr2
      $c.lfr2.labTok configure -text "Введите метку токена"
      $c.lfr2.labSoPin configure -text "Введите SO PIN"
      $c.lfr2.labUserPin configure -text "Новый PIN-пользователя"
      $c.lfr2.labRepUserPin configure -text "Повторите PIN-пользователя"
    }
    1 {
#	$c.lfr2 configure -state normal
      grid forget $c.lfr2.labTok
      grid forget $c.lfr2.entTok
              pack $c.lfr2 -side top -fill x -padx 20
#      grid $c.lfr2
      $c.lfr2.labSoPin configure -text "Текущий PIN-пользователя"
      $c.lfr2.labUserPin configure -text "Новый PIN-пользователя"
      $c.lfr2.labRepUserPin configure -text "Повторите новый USER-PIN"
    }
    2 {
#	$c.lfr2 configure -state normal
      grid forget $c.lfr2.labTok
      grid forget $c.lfr2.entTok
        pack $c.lfr2 -side top -fill x -padx 20
#      grid $c.lfr2
      $c.lfr2.labSoPin configure -text "Текущий SO-PIN"
      $c.lfr2.labUserPin configure -text "Новый SO-PIN"
      $c.lfr2.labRepUserPin configure -text "Повторите новый SO-PIN"
    }
    3 {
#	$c.lfr2 configure -state normal
      grid forget $c.lfr2.labTok
      grid forget $c.lfr2.entTok
        pack $c.lfr2 -side top -fill x -padx 20
#      grid $c.lfr2
      $c.lfr2.labSoPin configure -text "Введите SO PIN"
      $c.lfr2.labUserPin configure -text "Текущий PIN-пользователя"
      $c.lfr2.labRepUserPin configure -text "Повторите PIN-пользователя"
    }
    4 {
      $c.lfr2.labTok configure -text ""
      $c.lfr2.labSoPin configure -text ""
      $c.lfr2.labUserPin configure -text ""
      $c.lfr2.labRepUserPin configure -text ""
#	$c.lfr2 configure -state disabled
#              pack forget $c.lfr2
#      grid remove $c.lfr2
    }
  }
  #  pack $c.butop -side top -pady {10 0} -padx 20 -anchor se
}

proc licload {} {
    borg activity android.intent.action.VIEW http://soft.lissi.ru/ls_product/skzi/LS11SW2016/ text/html
}

proc licinstall {} {
  set filetype {
    {"Файл LIC.DAT с лицензией" "LIC.DAT"}
    {"Файл с лицензией" ".DAT"}
    {"Любой файл" *}
  }
  set newlic [tk_getOpenFile  -title "Выберите файл с лицензией токена" -initialdir $::myHOME -filetypes $filetype]
  if {$newlic == ""} {
    return
  }
  set err [catch {file copy -force $newlic [file join $::myHOME ".LS11SW2016" "LIC.DAT"]} res]
  if {$err} {
    tk_messageBox -title "Установка лицензии" -icon error -message "Установить не удалось.\nПроверьте файл лицензии"
    return
  }
    set ::pkcs11_module "libls11sw2016.so"
	set ret [::updatetok]
	set ret [::updatetok]
	switch -- $::pkcs11_status {
	    -1	{
		tk_messageBox -title "Используемый токен"   -icon info -message "Отсутствует библиотека"
	    }
	    0 {
		set date [dateLIC]
		if {$date == ""} {
		    set date "31.12.2999"
		}
		tk_messageBox -title "Используемый токен" -icon info -message "Токен готов к использованию:\n$::slotid_teklab\nЛицензия до $date"
	    }
	    1	{
		tk_messageBox -title "Используемый токен"   -icon info -message "Отсутствует подключенный токен"
	    }
	    2  {
#puts "::pkcs11_status=$::pkcs11_status \nret=$ret"
		tk_messageBox -title "Используемый токен"   -icon info -message "Требуется инициализация токена.\nДля инициализации токена перейдите\nна страницу\n\"Конфигурирование токена\""
	    }
	    3  {
		tk_messageBox -title "Используемый токен"   -icon info -message "Нет лицензии на токен.\nЗапрос на лицензию LIC.REQ хранится в папке:\n$::myHOME\n" \
		    -detail "Для получения и установки лицензии\n перейдите на вкладку \"Конфигурирование токенов\""
	    }
	}
}

proc func_page11 {c} {
  variable optok
  set optok 0
  variable laboptok

    labelframe $c.tok -text "Выберите токен PKCS11"  -borderwidth 5
    ttk::combobox $c.tok.listTok -textvariable ::nickTok -values $::listtok
    set ::nickTok [lindex $::listtok 0]
    $c.tok.listTok configure -state readonly
#    button $c.tok.viewcert -command {if {[info exists nickCert]} {::viewCert "pkcs11" $nickCert}} -image ::img::view_18x16 -compound left -pady 0 -bd 0 -bg white -highlightthickness 0
    pack $c.tok.listTok -side left  -padx {2 1} -pady {1 0} -ipady 1  -expand 1 -fill x
#    pack $c.tok.viewcert -side right -padx {0 5} -pady 0 -expand 0 -fill none
    pack $c.tok -fill both -side top -padx 10 -pady {4 0}
#  grid $c.tok -row 0 -column 0 -sticky wsen -padx 10 -pady 10
  set laboptok "Для инициализации токена заполните следующие поля:"
  labelframe $c.lfr1 -text "Выберите операцию с токеном:" -background white
  set cmd "ttk::radiobutton $c.lfr1.rb1 -value 0 -variable optok -text {Инициализация токена} -width 30 -command {setoptok $c}"
  eval [subst $cmd]
  set cmd "ttk::radiobutton $c.lfr1.rb2 -value 1 -variable optok -text {Сменить USER-PIN} -command {setoptok $c}"
  eval [subst $cmd]
  set cmd "ttk::radiobutton $c.lfr1.rb3 -value 2 -variable optok -text {Сменить SO-PIN} -width 30 -command {setoptok $c}"
  eval [subst $cmd]
  set cmd "ttk::radiobutton $c.lfr1.rb4 -value 3 -variable optok -text {Разблокировать USER-PIN} -command {setoptok $c}"
  eval [subst $cmd]
  set cmd "ttk::radiobutton $c.lfr1.rb5 -value 4 -variable optok -text {Очистить токен} -command {setoptok $c}"
  eval [subst $cmd]

  grid $c.lfr1.rb1 -row 0 -column 0 -sticky news -padx {4 0} -pady 8
  grid $c.lfr1.rb2 -row 1 -column 0 -sticky news -padx {4 0} -pady 0
  grid $c.lfr1.rb3 -row 2 -column 0 -sticky news -padx {4 0} -pady 8
  grid $c.lfr1.rb4 -row 3 -column 0 -sticky news -padx {4 0} -pady 0
  grid $c.lfr1.rb5 -row 4 -column 0 -sticky news -padx {4 0} -pady 8
    pack $c.lfr1 -fill both -side top -padx 10 -pady 10
#  grid $c.lfr1 -row 1 -column 0 -sticky wsen -padx {40 0} -pady 10

  ttk::label .lfortok -textvariable laboptok -background wheat
  labelframe $c.lfr2 -labelwidget .lfortok -bg wheat 
#  ttk::label .lfortok -textvariable laboptok -background #bee9fd
#  labelframe $c.lfr2 -labelwidget .lfortok -bg #bee9fd
  label $c.lfr2.labTok -background skyblue -justify left -text "Введите метку токена"  -anchor w -width 30
  grid $c.lfr2.labTok -column 0 -padx 5 -pady 2 -row 0 -sticky we
  entry $c.lfr2.entTok -background snow -width 40
  grid $c.lfr2.entTok -column 0 -padx 2 -pady 2 -row 1 -sticky we -padx {0 5}
  label $c.lfr2.labSoPin -background skyblue -text "Введите SO PIN" -anchor w -width 30
  grid $c.lfr2.labSoPin -column 0 -padx 5 -pady 2 -row 2 -sticky we
  entry $c.lfr2.entSoPin -background snow -show * -width 40
  grid $c.lfr2.entSoPin -column 0 -pady 2 -row 3 -padx {0 5}
  label $c.lfr2.labUserPin -background skyblue -text "Новый PIN-пользователя" -anchor w
  grid $c.lfr2.labUserPin -column 0 -row 4 -sticky we -padx 5
  entry $c.lfr2.entUserPin -background snow -show * -width 40
  grid $c.lfr2.entUserPin -column 0 -pady 2 -row 5 -padx {0 5}
  label $c.lfr2.labRepUserPin -background skyblue -text "Повторите PIN-пользователя" -anchor w
  grid $c.lfr2.labRepUserPin -column 0 -pady 2 -row 6 -sticky we -padx 5
  entry $c.lfr2.entRepUserPin -background snow -show * -width 40
  grid $c.lfr2.entRepUserPin -column 0 -pady {2 10} -row 7 -padx {0 5}

#  grid $c.lfr2 -row 2 -column 0 -sticky se -padx {40 0}
    pack $c.lfr2 -fill both -side top -padx 10 -pady 10
  set cmd "ttk::button  $c.butop -command {p11conf  $c} -text {Выполнить операцию} -style TButton"
  eval [subst $cmd]
#  grid $c.butop -row 3 -column 0  -sticky se -padx 0 -pady {10 0}
    pack $c.butop -fill none -side top -padx 10 -pady {10 }
  labelframe $c.licfr -text "Лицензирование токена:" -background wheat
  label  $c.licfr.llic -text {Лицензию:} -bg skyblue
  ttk::button  $c.licfr.bread -command {licload } -text {Получить} -style TButton
  ttk::button  $c.licfr.bust -command {licinstall } -text {Установить} -style TButton
    pack $c.licfr.llic -fill none -side left -padx 10 -pady {10 }
    pack $c.licfr.bread -fill none -side left -padx 10 -pady {10 }
    pack $c.licfr.bust -fill none -side left -padx 10 -pady {10 }
    pack $c.licfr -fill both -side top -padx 10 -pady 10
}


proc contentabout {w} {
  # Set up display styles.
  if {[winfo depth $w] > 1} {
    set bold "-background #43ce80 -relief raised -borderwidth 1"
    #	    set normal "-background {} -relief flat"
    set normal "-background {} -foreground red -relief flat -underline on"
  } else {
    set bold "-foreground white -background black"
    set normal "-foreground {} -background {}"
  }

  $w.text configure -background white
#  $w.text tag configure tagAbout -foreground blue -font {Times 9 bold italic}
  $w.text tag configure tagAbout -foreground blue -font {{Roboto Condensed Medium} 9}
  $w.text image create end -image creator_small
  $w.text insert end "\tCryptoArmPKCS\n" tagAbout

  #	$w.text insert end $content
  $w.text insert end "       Криптографический АРМ cryptoarmpkcs на базе стандартов с открытым ключом \
  предназначен для работы с криптографическими токенами PKCS#11, защищенными контейнерами PKCS#12, \
  а также для создания запроса на на квалифицированный сертификат, подписания документов \
  в формате CAdes-BES, CAdes-T и CAdes-XLT1 и самоподписанных сертификатов, \
  написан Орловым В.Н."
  $w.text insert end \n
  $w.text insert end \
  {       В качестве СКЗИ используются токены/смарткарты }
  $w.text insert end {PKCS#11} d1
  $w.text insert end ".\n"
  $w.text insert end \
  {       При работе с защищенным контейнером }
  $w.text insert end {PKCS#12} d2
  $w.text insert end \
  { используется }
  $w.text insert end {СКЗИ "ЛИРССЛ-CSP"} d3
  $w.text insert end ".\n"
  $w.text insert end \
  {        Утилита cryptoarmpkcs функционирует на ОС Linux, MS Windows, MacOC, Android и др.} tagAbout
  $w.text insert end \n
  $w.text insert end \
  {        Загрузить дистрибуты для платформ Linux, MS Windows, OS X можно }
  $w.text tag configure tagLoad -foreground blue -font {Times 10 bold italic}
  $w.text tag configure tagLoad1 -foreground blue -font {Times 9 bold italic}
  foreach tag {d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 d11 d12 d13 d14 d15} {
    $w.text tag configure $tag  -foreground red
  }
  #     -font {Times 10 bold italic}
  $w.text insert end {здесь:}  tagAbout
  $w.text insert end "\n\t - "
  $w.text insert end {Linux32} d4
  $w.text insert end \n\n
  $w.text insert end "\t - "
  $w.text insert end {Linux64} d5
  $w.text insert end \n\n
  $w.text insert end "\t - "
  $w.text insert end {OS X} d6
  $w.text insert end \n\n
  $w.text insert end "\t - "
  $w.text insert end {WIN32} d7
  $w.text insert end \n\n
  $w.text insert end "\t - "
  $w.text insert end {WIN64} d8
  $w.text insert end \n\n
  $w.text insert end "\t - "
  $w.text insert end {AndroWishApp-debug.apk} d15
  $w.text insert end \n\n
  $w.text insert end "\t - "
  $w.text insert end {Source} d9
  $w.text insert end \n\n
  $w.text insert end \
  {        При создании дистрибутивов были использованы пакеты }
  $w.text insert end {TclPKCS11} d10
  $w.text insert end \
  {, а такжe утилиты }
  $w.text insert end {freewrap} d11
  $w.text insert end {, }
  $w.text insert end {tclexecomp} d12
  $w.text insert end { и }
  $w.text insert end {tclderdump} d13
  $w.text insert end ".\n"
  $w.text insert end \
  {        При создании дистрибутива под Android использовался }
  $w.text insert end {AndroWish} d14
  $w.text insert end \
  {        Утилита cryptoarmpkcs разрабатывалась с учетом требований ФЗ-63 и регуляторов.}
  $w.text insert end \n
  $w.text insert end \
  {        Автор выражает благодарность Блажнову В.Ю. за разработку пакетов Lrnd, Lcc и GostPfx.}  tagAbout
  $w.text insert end \n
  $w.text insert end \
  {        Это программное обеспечение доступно в терминах GNU General Public License.}
  $w.text insert end \n
  $w.text insert end \
  {        email: vorlov@lissi.ru} tagLoad1
  $w.text insert end \n

  # Create bindings for tags.
  # d3 d4 d5 d6
  array set url []
  set url(d1) "http://soft.lissi.ru/ls_product/skzi/PKCS11"
  set url(d2) "http://soft.lissi.ru/ls_product/utils/p12fromcsp"
  set url(d3) "http://soft.lissi.ru/ls_product/skzi/skzi_lirssl_csp"
  set url(d4) "https://github.com/a513/CryptoArmPKCS/raw/master/distr/cryptoarmpkcs_linux32.tar.bz2"
  set url(d5) "https://github.com/a513/CryptoArmPKCS/raw/master/distr/cryptoarmpkcs_linux64.tar.bz2"
  set url(d6) "https://github.com/a513/CryptoArmPKCS/raw/master/distr/cryptoarmpkcs_mac.tar.bz2"
  set url(d7) "https://github.com/a513/CryptoArmPKCS/raw/master/distr/cryptoarmpkcs_setup_win32.exe"
  set url(d8) "https://github.com/a513/CryptoArmPKCS/raw/master/distr/cryptoarmpkcs_setup_win64.exe"
  set url(d9) "https://github.com/a513/CryptoArmPKCS/raw/master/source/cryptoarmpkcs_source.tar.bz2"
  set url(d10) "https://github.com/a513/TclPKCS11"
  set url(d11) "http://freewrap.sourceforge.net"
  set url(d12) "http://tclexecomp.sourceforge.net"
  set url(d13) "https://github.com/a513/TclDerDUMP"
  set url(d14) "https://www.androwish.org"
  set url(d15) "https://github.com/a513/CryptoArmPKCS/raw/master/distr/AndroWishApp-debug.apk"

  foreach tag {d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 d11 d12 d13 d14 d15} {
    #	    $w.text tag bind $tag <Any-Enter> ".about.butt.lab configure -text {$url($tag)} ;$w.text tag configure $tag $bold"
    #	    $w.text tag bind $tag <Any-Leave> ".about.butt.lab configure -text {}; $w.text tag configure $tag $normal"
    $w.text tag bind $tag <Any-Enter> "set ::entryd {$url($tag)};$w.text tag configure $tag $bold"
    #	    $w.text tag bind $tag <Any-Leave> "set ::entryd {}; $w.text tag configure $tag $normal"
    $w.text tag bind $tag <Any-Leave> "$w.text tag configure $tag $normal"
}
  # Main widget program sets variable tk_demoDirectory
  $w.text tag bind d1 <1> {openURL "http://soft.lissi.ru/ls_product/skzi/PKCS11"}
  $w.text tag bind d2 <1> {openURL "http://soft.lissi.ru/ls_product/utils/p12fromcsp"}
  $w.text tag bind d3 <1> {openURL "http://soft.lissi.ru/ls_product/skzi/skzi_lirssl_csp"}
  if {[string range $w 0 5] == ".about"} {
    $w.text tag bind d4 <1> {readdistr "https://github.com/a513/CryptoArmPKCS/raw/master/distr/cryptoarmpkcs_linux32.tar.bz2" ".about"}
    $w.text tag bind d5 <1> {readdistr "https://github.com/a513/CryptoArmPKCS/raw/master/distr/cryptoarmpkcs_linux64.tar.bz2" ".about"}
    $w.text tag bind d6 <1> {readdistr "https://github.com/a513/CryptoArmPKCS/raw/master/distr/cryptoarmpkcs_mac.tar.bz2" ".about"}
    $w.text tag bind d7 <1> {readdistr "https://github.com/a513/CryptoArmPKCS/raw/master/distr/cryptoarmpkcs_setupo_win32.exe" ".about"}
    $w.text tag bind d8 <1> {readdistr "https://github.com/a513/CryptoArmPKCS/raw/master/distr/cryptoarmpkcs_setup_win64.exe" ".about"}
    $w.text tag bind d9 <1> {readdistr "https://github.com/a513/CryptoArmPKCS/raw/master/source/cryptoarmpkcs_source.tar.bz2" ".about"}
    $w.text tag bind d15 <1> {readdistr "https://github.com/a513/CryptoArmPKCS/raw/master/distr/AndroWishApp-debug.apk" ".about"}
  } else {
    $w.text tag bind d4 <1> {readdistr "https://github.com/a513/CryptoArmPKCS/raw/master/distr/cryptoarmpkcs_linux32.tar.bz2" "."}
    $w.text tag bind d5 <1> {readdistr "https://github.com/a513/CryptoArmPKCS/raw/master/distr/cryptoarmpkcs_linux64.tar.bz2" "."}
    $w.text tag bind d6 <1> {readdistr "https://github.com/a513/CryptoArmPKCS/raw/master/distr/cryptoarmpkcs_mac.tar.bz2" "."}
    $w.text tag bind d7 <1> {readdistr "https://github.com/a513/CryptoArmPKCS/raw/master/distr/cryptoarmpkcs_setup_win32.exe" "."}
    $w.text tag bind d8 <1> {readdistr "https://github.com/a513/CryptoArmPKCS/raw/master/distr/cryptoarmpkcs_setup_win64.exe" "."}
    $w.text tag bind d9 <1> {readdistr "https://github.com/a513/CryptoArmPKCS/raw/master/source/cryptoarmpkcs_source.tar.bz2" "."}
    $w.text tag bind d15 <1> {readdistr "https://github.com/a513/CryptoArmPKCS/raw/master/distr/AndroWishApp-debug.apk" "."}
  }
  $w.text tag bind d10 <1> {openURL "https://github.com/a513/TclPKCS11"}
  $w.text tag bind d11 <1> {openURL "http://freewrap.sourceforge.net"}
  $w.text tag bind d12 <1> {openURL "http://tclexecomp.sourceforge.net"}
  $w.text tag bind d13 <1> {openURL "https://github.com/a513/TclDerDUMP"}
  $w.text tag bind d14 <1> {openURL "https://www.androwish.org"}

}

proc contentcreatetok {w} {
  # Set up display styles.
  if {[winfo depth $w] > 1} {
    set bold "-background #43ce80 -relief raised -borderwidth 1"
    #	    set normal "-background {} -relief flat"
    set normal "-background {} -foreground red -relief flat -underline on"
  } else {
    set bold "-foreground white -background black"
    set normal "-foreground {} -background {}"
  }

  $w.text configure -background white
#  $w.text tag configure tagAbout -foreground blue -font {Times 10 bold italic}
  $w.text tag configure tagAbout -foreground blue -font {{Roboto Condensed Medium} 9}
  $w.text image create end -image creator_small
  $w.text insert end "\t\tCryptARMpkcs\n\n" tagAbout

  #	$w.text insert end $content
  $w.text insert end "   Если у вас нет аппаратного токена, не огорчайтесь.\
  Вы можете актитивировать свой программный токен LS11SW2016, либо создавть облачный токен.\
  Это позволит вам не только обучиться, но и, при желании,  организовать Инфраструктуру Открытых Ключей \
  (ИОК/PKI) в вашей организации или с коллегами"
  $w.text insert end \n\n
  $w.text insert end {   1. }
  $w.text image create end -image sw_token
  $w.text insert end \
  " Создание программного токена "
  $w.text insert end {LS11SW2016} d1
  $w.text insert end ".\n\n"
  $w.text insert end \
  {   На платформе Android программный токен создается при первом старте.} tagAbout
  $w.text insert end \n
  $w.text insert end \
  {Токен создается во внутренней памяти в папке .LS11SW2016. В этой же папке создается запрос LIC.REQ на получение лицензии на токен}
  $w.text insert end \n
  $w.text insert end \
  {Все что вам необходимо сделать, это перейти на страницу "Конфигурирование токена" и проинициализировать ваш токен.}
  $w.text insert end \n
  $w.text insert end \
  {   На платформах Linux, MS Windows, MacOS и др. для создания токена используется утилита guicreate_sw_token} tagAbout
  $w.text insert end \n
  $w.text insert end \
  {   Загрузить дистрибутивы утилиты guicreate_sw_token для платформ Linux, MS Windows, OS X можно }
  $w.text tag configure tagLoad -foreground blue -font {Times 12 bold italic}
  $w.text tag configure tagLoad1 -foreground blue -font {Times 10 bold italic}
  foreach tag {d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 d11 d12 d13} {
    $w.text tag configure $tag  -foreground red
  }
  #     -font {Times 10 bold italic}
  $w.text insert end {здесь:}  tagAbout
  $w.text insert end "\n\t - "
  $w.text insert end {Linux32} d2
  $w.text insert end \n
  $w.text insert end "\t - "
  $w.text insert end {Linux64} d3
  $w.text insert end \n
  $w.text insert end "\t - "
  $w.text insert end {OS X} d4
  $w.text insert end \n
  $w.text insert end "\t - "
  $w.text insert end {WIN32} d5
  $w.text insert end \n
  $w.text insert end "\t - "
  $w.text insert end {WIN64} d6
  $w.text insert end \n
  $w.text insert end "   При необходимости распакуйте дистрибутив и запустите его. В дальнейшем следуйте его подсказкам. \
  Вы можете также воспользоваться "
  $w.text insert end {инструкцией} d7
  $w.text insert end ".\n\n"

  ##################### CLOUD TOKEN ################
  $w.text insert end {   2. }
  $w.text image create end -image cloud_token
  $w.text insert end \
  "   Создание облачного токена "
  $w.text insert end {LS11CLOUD} d8
  $w.text insert end ".\n\n"
  $w.text insert end \
  {   Утилита guils11cloud_conf функционирует на ОС Linux, MS Windows, MacOS и др.} tagAbout
  $w.text insert end \n
  $w.text insert end \
  {   Загрузить дистрибутивыы для платформ Linux, MS Windows, OS X можно }
  $w.text tag configure tagLoad -foreground blue -font {Times 12 bold italic}
  $w.text tag configure tagLoad1 -foreground blue -font {Times 10 bold italic}
  foreach tag {d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 d11 d12 d13} {
    $w.text tag configure $tag  -foreground red
  }
  #     -font {Times 10 bold italic}
  $w.text insert end {здесь:}  tagAbout
  $w.text insert end "\n\t - "
  $w.text insert end {Linux32} d9
  $w.text insert end \n
  $w.text insert end "\t - "
  $w.text insert end {Linux64} d10
  $w.text insert end \n
  $w.text insert end "\t - "
  $w.text insert end {OS X} d11
  $w.text insert end \n
  $w.text insert end "\t - "
  $w.text insert end {WIN32} d12
  $w.text insert end \n
  $w.text insert end "\t - "
  $w.text insert end {WIN64} d13
  $w.text insert end \n
  $w.text insert end "   При необходимости распакуйте дистрибутив и запустите его. В дальнейшем следуйте его подсказкам. \
  Вы можете также воспользоваться "
  $w.text insert end {инструкцией} d8
  $w.text insert end ".\n"
  $w.text insert end \
  {   На платформе Android создание облачного токена будет доступно в следующем обновлении} tagAbout
  $w.text insert end \n


  # Create bindings for tags.
  # d3 d4 d5 d6
  array set url []
  set url(d1) "http://soft.lissi.ru/ls_product/skzi/PKCS11"
  set url(d2) "https://github.com/a513/GuiCreateLS11SW2016Token/raw/master/distr/guicreate_sw_token_linux32.tar.bz2"
  set url(d3) "https://github.com/a513/GuiCreateLS11SW2016Token/raw/master/distr/guicreate_sw_token_linux64.tar.bz2"
  set url(d4) "https://github.com/a513/GuiCreateLS11SW2016Token/raw/master/distr/guicreate_sw_token_mac.tar.bz2"
  set url(d5) "https://github.com/a513/GuiCreateLS11SW2016Token/raw/master/distr/guicreate_sw_token_win32.exe"
  set url(d6) "https://github.com/a513/GuiCreateLS11SW2016Token/raw/master/distr/guicreate_sw_token_win64.exe"
  set url(d7) "http://soft.lissi.ru/ls_product/skzi/LS11SW2016/"
  set url(d8) "http://soft.lissi.ru/solution/ls11cloud"
  set url(d9) "https://github.com/a513/guils11cloud_config/raw/master/distr/guils11cloud_conf_linux32.tar.bz2"
  set url(d10) "https://github.com/a513/guils11cloud_config/raw/master/distr/guils11cloud_conf_linux64.tar.bz2"
  set url(d11) "https://github.com/a513/guils11cloud_config/raw/master/distr/guils11cloud_conf_mac.tar.bz2"
  set url(d12) "https://github.com/a513/guils11cloud_config/raw/master/distr/guils11cloud_conf_win32.exe"
  set url(d13) "https://github.com/a513/guils11cloud_config/raw/master/distr/guils11cloud_conf_win64.exe"

  foreach tag {d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 d11 d12 d13} {
    #	    $w.text tag bind $tag <Any-Enter> ".about.butt.lab configure -text {$url($tag)} ;$w.text tag configure $tag $bold"
    #	    $w.text tag bind $tag <Any-Leave> ".about.butt.lab configure -text {}; $w.text tag configure $tag $normal"
    $w.text tag bind $tag <Any-Enter> "set ::entryd {$url($tag)};$w.text tag configure $tag $bold"
    #	    $w.text tag bind $tag <Any-Leave> "set ::entryd {}; $w.text tag configure $tag $normal"
    $w.text tag bind $tag <Any-Leave> "$w.text tag configure $tag $normal"
}

  $w.text tag bind d1 <1> {openURL "http://soft.lissi.ru/ls_product/skzi/PKCS11"}
  $w.text tag bind d2 <1> {readdistr "https://github.com/a513/GuiCreateLS11SW2016Token/raw/master/distr/guicreate_sw_token_linux32.tar.bz2" "."}
  $w.text tag bind d3 <1> {readdistr "https://github.com/a513/GuiCreateLS11SW2016Token/raw/master/distr/guicreate_sw_token_linux64.tar.bz2" "."}
  $w.text tag bind d4 <1> {readdistr "https://github.com/a513/GuiCreateLS11SW2016Token/raw/master/distr/guicreate_sw_token_mac.tar.bz2" "."}
  $w.text tag bind d5 <1> {readdistr "https://github.com/a513/GuiCreateLS11SW2016Token/raw/master/distr/guicreate_sw_token_win32.exe" "."}
  $w.text tag bind d6 <1> {readdistr "https://github.com/a513/GuiCreateLS11SW2016Token/raw/master/distr/guicreate_sw_token_win64.exe" "."}
  $w.text tag bind d7 <1> {openURL "http://soft.lissi.ru/ls_product/skzi/LS11SW2016"}
  $w.text tag bind d8 <1> {openURL "http://soft.lissi.ru/solution/ls11cloud"}
  $w.text tag bind d9 <1> {readdistr "https://github.com/a513/guils11cloud_config/raw/master/distr/guils11cloud_conf_linux32.tar.bz2" "."}
  $w.text tag bind d10 <1> {readdistr "https://github.com/a513/guils11cloud_config/raw/master/distr/guils11cloud_conf_linux64.tar.bz2" "."}
  $w.text tag bind d11 <1> {readdistr "https://github.com/a513/guils11cloud_config/raw/master/distr/guils11cloud_conf_mac.tar.bz2" "."}
  $w.text tag bind d12 <1> {readdistr "https://github.com/a513/guils11cloud_config/raw/master/distr/guils11cloud_conf_win32.exe" "."}
  $w.text tag bind d13 <1> {readdistr "https://github.com/a513/guils11cloud_config/raw/master/distr/guils11cloud_conf_win64.exe" "."}

}


proc mechlist {w} {
set sopin "87654321"
set ltok "MetkaFromMech"
::updatetok
set ::slotid_tek 0
    $w.fratext.text delete 1.0 end
#tk_messageBox -title "Список мех" -icon info -message "HAndle=$::handle" 
    set lists [listts $::handle]
    if {[llength $lists] == 0} {
	$w.fratext.text insert end "Нет подключенных токенов\n\n" tagAbout
	return
    }
    set i 0
    set ::listtok {}
    set oldslot $::slotid_teklab
    set j 0
    set ::sflags ""
    foreach {lab slotid tokeninfo slotflags} $lists {
    #	    puts "Токен \"$lab\" находится в слоте \"$slotid\""
	lappend ::listtok $lab
	if {$i == 0} {
#Серийный номер устройства/телефона
	    $w.fratext.text insert end "\tИнформация об устройстве\n" tagAbout
	    $w.fratext.text insert end "Серийный номер: $::sntlf\n"
#Информация о токене
	    $w.fratext.text insert end "\tИнформация о токене\n" tagAbout
	    $w.fratext.text insert end "Метка: [lindex $tokeninfo 0]\n"
	    $w.fratext.text insert end "Производитель: [lindex $tokeninfo 1]\n"
	    $w.fratext.text insert end "Тип: [lindex $tokeninfo 2]\n"
	    $w.fratext.text insert end "Серийный номер: [lindex $tokeninfo 3]\n"
	}
	if {$::slotid_tek == -1} {
    	    set ::slotid_tek $slotid
    	    set ::slotid_teklab $lab
	}
	if {$oldslot == $lab } {
    	    set ::slotid_tek $slotid
    	    set ::slotid_teklab $lab
    	    set j $i
	}
	set ::sflags $slotflags
	incr i
    }
    $w.fratext.text insert end "Флаги слота $::slotid_teklab\n" tagAbout
    $w.fratext.text insert end "$::sflags\n"
    
    $w.fratext.text insert end "Криптографические механизмы токена $::slotid_teklab\n" tagAbout
    #puts "HANDLE:ID:LAB=$::handle : $::slotid_tek : $::slotid_teklab"
    set llmech [pki::pkcs11::listmechs $::handle 0]
#    set llmech [pki::pkcs11::listmechs $::handle $::slotid_tek]
    foreach mech $llmech {
      $w.fratext.text insert end $mech
      $w.fratext.text insert end "\n"
    }
#  $w.fratext.text configure -state disabled
#tk_messageBox -title "Список мех" -icon info -message "END\nHAndle=$::handle" 
}


#Информация о токене
proc func_page5 {w} {
    labelframe $w.tok -text "Выберите токен PKCS11"  -borderwidth 5
    ttk::combobox $w.tok.listTok -textvariable ::nickTok -values $::listtok
    set ::nickTok [lindex $::listtok 0]
#    button $w.tok.updateTok -command {updatetok} -image ::img::update_18x16 -compound left -pady 0 -bd 0 -bg white -highlightthickness 0
    set cmd "button $w.tok.updateTok -command {mechlist $w} -image ::img::view_18x16 -compound left -pady 0 -bd 0 -bg white -highlightthickness 0"
    set cmd [subst $cmd]
    eval $cmd 
    pack $w.tok.listTok -side left  -padx {2 1} -pady {1 0} -ipady 1  -expand 1 -fill x
    pack $w.tok.updateTok -side right -padx {0 5} -pady 0 -expand 0 -fill none
    pack $w.tok -fill x -side top -padx 10 -pady 4

  frame $w.fratext -borderwidth 0 -relief flat
  text $w.fratext.text -yscrollcommand [list $w.fratext.scr set]  \
  -insertbackground black -bg #f5f5f5 -highlightcolor skyblue -wrap word  -height 27
  $w.fratext.text tag configure tagAbout -foreground blue -font {{Roboto Condensed Medium} 9}
  ttk::scrollbar $w.fratext.scr  -command [list $w.fratext.text yview]
  #ttk::scrollbar $w.fratext.xscr -orient horizontal -command [list $w.fratext.text xview]
  pack $w.fratext.scr -anchor center -expand 0 -fill y -side right
  #pack $w.fratext.xscr -anchor center -expand 0 -fill x -side bottom
  pack $w.fratext.text -anchor center -expand 1 -fill both -side top -padx 0 -pady {0 0}
    $w.fratext.text configure -background white
  pack $w.fratext -in $w -anchor center -expand 1 -fill both -side top
#Информация о токене:
  set cmd "ttk::button  $w.butop -command {mechlist  $w} -text {Механизмы} -style TButton"
  eval [subst $cmd]
#  grid $c.butop -row 3 -column 0  -sticky se -padx 0 -pady {10 0}
    pack $w.butop -fill none -side top -padx 10 -pady {20 }

# mechlist $w
#  set ::entryd ""
}

proc ::deleteObject {w } {
  global yespas
  global pass
  puts "HANDLE=$::handleObj"

  set aa [dict create pkcs11_handle $::handle pkcs11_slotid $::slotid_tek]
  lappend aa "hobj"
  lappend aa $::handleObj

  set err [::pki::pkcs11::delete obj $aa]
  #    catch {::pki::pkcs11::logout $::handle $::slotid_tek}
  ::updateobj $w
  ::updatetok
}

proc ::updateobj {w} {
  global yespas
  global pass
  variable ::handleObj
  variable ::listObjs
  set ret [p11status]
  if {$ret != 0} {
	return
  }
  set c $w
  $c.fratext.text delete 1.0 end
  set ::listObjs {}
  $c.frhd.lobj configure -values $::listObjs
  set ::handleObj [lindex $::listObjs 0]
  catch {::pki::pkcs11::logout $::handle $::slotid_tek}
  wm title .topPinPw "Токен: $::slotid_teklab"
wm state . withdraw
  wm state .topPinPw normal
  wm state .topPinPw withdraw
  wm state .topPinPw normal
  raise .topPinPw
  grab .topPinPw
  focus .topPinPw.labFrPw.entryPw
  set yespass ""
  vwait yespas
  grab release .topPinPw
wm state . normal
  #Ввод пароля
  if { $yespas == "no" } {
    return 0
  }
  set yespas "no"
  set password $pass
  set pass ""
        	
  if { [pki::pkcs11::login $::handle $::slotid_tek $password] == 0 } {
    tk_messageBox -title "Объекты токена" -message "Доступ к токену не получен" -detail "Проверьте PIN-код" -icon error  -parent .
    return
  }
  set password ""

  set allobjs [::pki::pkcs11::listobjects $::handle $::slotid_tek "all"]
  #    catch {::pki::pkcs11::logout $::handle $::slotid_tek}
  foreach obj $allobjs {
    lappend ::listObjs [lindex $obj 1]
    foreach {type handle label id} $obj {
      $c.fratext.text insert end $type
      $c.fratext.text insert end "\n  "
      $c.fratext.text insert end $handle
      $c.fratext.text insert end "\n  "
      $c.fratext.text insert end $label
      $c.fratext.text insert end "\n  "
      $c.fratext.text insert end $id
      $c.fratext.text insert end "\n"
    }
    #	puts "$obj"
  }
  #puts "::listObjs=$::listObjs"
  #puts "ALLOBJS=[lindex $allobjs 0]"
  $c.frhd.lobj configure -state normal
  $c.frhd.lobj configure -values $::listObjs
  set ::handleObj [lindex $::listObjs 0]
  $c.frhd.lobj configure -state readonly
  return $allobjs
}

proc ::deleteallobj {} {
  global yespas
  global pass
  variable ::handleObj
  variable ::listObjs
  catch {::pki::pkcs11::logout $::handle $::slotid_tek}
  wm title .topPinPw "Токен: $::slotid_teklab"
wm state . withdraw
  wm state .topPinPw normal
  wm state .topPinPw withdraw
  wm state .topPinPw normal
  raise .topPinPw
  grab .topPinPw
  focus .topPinPw.labFrPw.entryPw
  set yespass ""
  vwait yespas
  grab release .topPinPw
wm state . normal
  #Ввод пароля
  if { $yespas == "no" } {
    return 0
  }
  set yespas "no"
  set password $pass
  set pass ""
        	
  if { [pki::pkcs11::login $::handle $::slotid_tek $password] == 0 } {
    tk_messageBox -title "Очистить токен" -message "Доступ к токену не получен" -detail "Проверьте PIN-код" -icon error  -parent .
    return 0
  }
  set password ""

  set allobjs [::pki::pkcs11::listobjects $::handle $::slotid_tek "all"]
  #    catch {::pki::pkcs11::logout $::handle $::slotid_tek}
  foreach obj $allobjs {
    #    lappend ::listObjs [lindex $obj 1]
    #	puts "$obj"
    set aa [dict create pkcs11_handle $::handle pkcs11_slotid $::slotid_tek]
    lappend aa "hobj"
    lappend aa [lindex $obj 1]
    set err [::pki::pkcs11::delete obj $aa]
  }
  ::updatetok
  return 1
}

#Информация об объектах токене
proc func_page6 {w} {
    set ::listObjs [list ]
    labelframe $w.tok -text "Выберите токен PKCS11" -borderwidth 5
    ttk::combobox $w.tok.listTok -textvariable ::nickTok -values $::listtok
    set ::nickTok [lindex $::listtok 0]
    set cmd "button $w.tok.updateTok -command {::updateobj $w} -image ::img::view_18x16 -compound left -pady 0 -bd 0 -bg white -highlightthickness 0"
    set cmd [subst $cmd]
    eval $cmd 
    pack $w.tok.listTok -side left  -padx {2 1} -pady {1 0} -ipady 1  -expand 1 -fill x
    pack $w.tok.updateTok -side right -padx {0 5} -pady 0 -expand 0 -fill none
    pack $w.tok -fill x -side top -padx 10 -pady 4

  frame $w.fratext -borderwidth 0 -relief flat
  text $w.fratext.text -yscrollcommand [list $w.fratext.scr set]  \
  -insertbackground black -bg #f5f5f5 -highlightcolor skyblue -wrap word  -height 27
  $w.fratext.text tag configure tagAbout -foreground blue -font {{Roboto Condensed Medium} 9}
  ttk::scrollbar $w.fratext.scr  -command [list $w.fratext.text yview]
  pack $w.fratext.scr -anchor center -expand 0 -fill y -side right
  pack $w.fratext.text -anchor center -expand 1 -fill both -side top -padx 0 -pady {0 0}
    $w.fratext.text configure -background white
  pack $w.fratext -in $w -anchor center -expand 1 -fill both -side top

  labelframe $w.frhd -text "Handle объекта" -borderwidth 5
  ttk::combobox $w.frhd.lobj -textvariable ::handleObj -values $::listObjs -takefocus {}   -style TCombobox
  #    -state readonly

  set cmd "ttk::button $w.frhd.butdel -text {Удалить объект}  -command {::deleteObject $w} -style My.TButton -padding 1"
  set cmd [subst $cmd]
  eval $cmd 

  pack $w.frhd.lobj -anchor center -expand 1 -fill x -side left -ipadx 3 -ipady 2 -padx 5
  pack $w.frhd.butdel -anchor center -expand 0 -fill none -side left -ipady 0 -pady 0 -padx {0 10}
  pack $w.frhd -fill x -side top -padx 10 -pady 4
}

#proc page_about  {w} 
proc func_page9 {w} {
  frame $w.fratext -borderwidth 0 -relief flat
  text $w.fratext.text -yscrollcommand [list $w.fratext.scr set]  \
  -insertbackground black -bg #f5f5f5 -highlightcolor skyblue -wrap word  -height 31
#  -height 0 -insertbackground black -bg #f5f5f5 -highlightcolor skyblue -wrap word
  #-xscrollcommand [list $w.fratext.xscr set]
  ttk::scrollbar $w.fratext.scr  -command [list $w.fratext.text yview]
  #ttk::scrollbar $w.fratext.xscr -orient horizontal -command [list $w.fratext.text xview]
  pack $w.fratext.scr -anchor center -expand 0 -fill y -side right
  #pack $w.fratext.xscr -anchor center -expand 0 -fill x -side bottom
  pack $w.fratext.text -anchor center -expand 1 -fill both -side top -padx 0 -pady {0 0}
  contentabout $w.fratext
  $w.fratext.text configure -state disabled
  pack $w.fratext -in $w -anchor center -expand 1 -fill both -side top
  set ::entryd ""
}
#proc page_createtok  {w} 
proc func_page10 {w} {
  frame $w.fratext -borderwidth 0 -relief flat
  text $w.fratext.text -yscrollcommand [list $w.fratext.scr set]  \
  -insertbackground black -bg #f5f5f5 -highlightcolor skyblue -wrap word  -height 31
#  -height 0 -insertbackground black -bg #f5f5f5 -highlightcolor skyblue -wrap word
  #-xscrollcommand [list $w.fratext.xscr set]
  ttk::scrollbar $w.fratext.scr  -command [list $w.fratext.text yview]
  #ttk::scrollbar $w.fratext.xscr -orient horizontal -command [list $w.fratext.text xview]
  pack $w.fratext.scr -anchor center -expand 0 -fill y -side right
  #pack $w.fratext.xscr -anchor center -expand 0 -fill x -side bottom
  pack $w.fratext.text -anchor center -expand 1 -fill both -side top -padx 0 -pady {0 0}
  contentcreatetok $w.fratext
  $w.fratext.text configure -state disabled
  pack $w.fratext -in $w -anchor center -expand 1 -fill both -side top
  set ::entryd ""
}

proc page_func {fr tile titul functions} {
#Кнопки  меню
    upvar $functions but
#parray but
#Создаем шрифт для кнопок
    if {$::typetlf} {
#	set feFONT_button "-family {Roboto} -size 9 -weight bold -slant roman"
	set feFONT_button "-family {Roboto} -size 9  -slant roman"
	set widl 10
    } else {
#	set feFONT_button "-family {Arial} -size 12 -weight bold -slant roman"
	set feFONT_button "-family {Arial} -size 12  -slant roman"
	set widl 5
    }
    catch {font delete fontTEMP_drawer}
    eval font create fontTEMP_drawer  $feFONT_button
#Вычисляем максимальныю длину текста
    set drawerCNT 0
    set strMaxWidthPx 15
    set Ndrawers [expr {[array size but] - 1}]
    while { $drawerCNT <= $Ndrawers } {
if {$drawerCNT == 12} {
    incr drawerCNT
    continue
} 
	set strWidthPx [font measure fontTEMP_drawer "$but($drawerCNT)"]
	if { $strWidthPx > $strMaxWidthPx } {
    	    set strMaxWidthPx $strWidthPx
	}
	incr drawerCNT
    }
    set drawerWidthPx [expr $strMaxWidthPx + 10]
    set xxx [expr {($::::scrwidth - $drawerWidthPx) / 2}]

    if {$fr != ".fr1"} {
	set hret [expr $::scrheight / 4]
    } else {
	set hret $::scrheight
    }
	set hret [expr $::scrheight / 4]
#    tkp::canvas $fr.can -borderwidth 0 -height $hret -width $::scrwidth -relief flat
    canvas $fr.can -borderwidth 0 -height $hret -width $::scrwidth -relief flat
#Мостим холст плиткой 
    createtile "$fr.can"  $tile
    pack $fr.can  -anchor center -expand 1 -fill both -side top  -padx 0 -pady 0

    if {$titul != "" } {
	set allfunc $titul
#    set dlx [expr {$::padlx / 1}]
	catch {font delete fontTEMP_titul}
	set font_titul "-family {Roboto Condensed Medium} -size 15"
        eval font create fontTEMP_titul  $font_titul
	set funcWidthPx [font measure fontTEMP_titul "$allfunc"]
	set dlx [expr {($::::scrwidth - $funcWidthPx) / 2}]

	$fr.can create text [expr $dlx + $::dlx1] [expr {6 + $::dlx1}] -anchor nw -text "$allfunc" -fill black -font fontTEMP_titul
	$fr.can create text $dlx 6 -anchor nw -text "$allfunc" -fill white -font fontTEMP_titul -tag id_text0
	set blogo [$fr.can bbox id_text0]
	set boxbut [expr ([lindex $blogo 3] + 6 + 6)]
    } else {
	set boxbut [expr 6 + 6]
    }
#Вычисляем самый широкий текст у кнопок
#См. выше
#Размещаем кнопки
    set BDwidth_canvas 0

    set maxTextHeightPx [font metrics fontTEMP_drawer -linespace] 

    set maxTextHeightPx [expr {$maxTextHeightPx + ( $maxTextHeightPx / 2)}]

##+########################################################################
## Set the height of the toolchest drawers (in pixels) from either
## the 'linespace' height of the text strings OR perhaps some other measure.
##+#########################################################################

    set drawerHeightPx $maxTextHeightPx

##+########################################################################
## Set the x-offset in the one big canvas widget (relative to the left side
## of the canvas widget) at which the left side of each text string will be
## located.
##
## We adjust the x text offset according the the width of the
## border of the canvas --- so that the text does not lie on the border.
##+########################################################################

    set xLocTextPx [expr {($::::scrwidth - $drawerWidthPx) / 2}]


##+########################################################################
## Initialize the y-offset in the one big canvas widget (relative to the
## top of the canvas widget) at which the mid-left side of each text string
## will be located.
##+########################################################################

    set yLocTextPx [expr $BDwidth_canvas + ($drawerHeightPx / 2) + $boxbut]


##+########################################################################
## - Define the one big canvas widget. 
## - Put the background image on it with 'image create'.
## - Pack the canvas widget.
##+########################################################################

    set canvasHeightPx [expr $Ndrawers * $drawerHeightPx]

    set drawerCNT 0
    set Ndrawers [expr {[array size but] - 1}]
    while { $drawerCNT <= $Ndrawers } {
      set yLineLocPx [ expr (( $drawerCNT ) * $drawerHeightPx + $boxbut)]
#Линия перед текстом
      $fr.can create line \
         $xLocTextPx $yLineLocPx \
         [expr $drawerWidthPx + $xLocTextPx] $yLineLocPx \
         -fill "#a0a0a0" -width $widl

   ## Put the text line on the canvas, with a tag.
      $fr.can create text [expr $xLocTextPx + 5] $yLocTextPx \
	-anchor w \
        -font fontTEMP_drawer \
        -text "$but($drawerCNT)" 
#        -tag textlineTag($drawerCNT)
#Прозрачный прямоугольник между двумя линиями - это и есть кнопка
      $fr.can create rect $xLocTextPx [expr $yLineLocPx + $widl]  [expr $drawerWidthPx + $xLocTextPx] [expr $yLineLocPx + $boxbut - $widl] \
	-width 0 \
	-fill "" \
        -tag textlineTag($drawerCNT) 

   ## Bind an action to the text line.
	if {$drawerCNT == 0} {
	    if {$fr == ".fr1"} {
		$fr.can bind textlineTag($drawerCNT)  <ButtonRelease-1>   {butImg "but1"}
	    } else {
		$fr.can bind textlineTag($drawerCNT)  <ButtonRelease-1>   {butReturn}
	    }
	} else {
	    frame .fn$drawerCNT -background white -relief flat -pady 0 -padx 0
#	    set titul ""
	    set titul $but($drawerCNT)
	    if {$drawerCNT != 1 && $drawerCNT != 2 && $drawerCNT != 3 && $drawerCNT != 4 && $drawerCNT != 5 && $drawerCNT != 6 && $drawerCNT != 7 && $drawerCNT != 9 && $drawerCNT != 10 && $drawerCNT != 11} {
#		label .fn$drawerCNT.lab -text $but($drawerCNT) 
#		pack .fn$drawerCNT.lab -side top 
	    } else {
		func_page$drawerCNT .fn$drawerCNT
	    }
	    set cmd "$fr.can bind textlineTag($drawerCNT)  <ButtonRelease-1>   {butCliked $drawerCNT .fn$drawerCNT}"
	    set cmd [subst "$cmd"]
	    eval $cmd 
	    set but1(0) "Возврат в основное меню"
	    page_func ".fn$drawerCNT" voda "$titul" "but1"
#	    page_func ".fn$drawerCNT" newtile "$titul" "but1"
#	    page_func ".fn$drawerCNT" tileand "$titul" "but1"
	}

   ## Get ready for the next text line.
	incr drawerCNT

	set yLocTextPx [ expr $yLocTextPx + $drawerHeightPx]
#Завершаюшая линия
    	    set yLineLocPx [ expr (( $drawerCNT ) * $drawerHeightPx + $boxbut)]
	if {$drawerCNT  > $Ndrawers } {
#Кнопки выбора рабочего токена
	    if {[array size but] > 2 } {
    		set yLineLocPx [ expr (( $drawerCNT ) * $drawerHeightPx + $boxbut)]
#Линия перед текстом
    		$fr.can create line \
        		$xLocTextPx $yLineLocPx \
        		[expr $drawerWidthPx + $xLocTextPx] $yLineLocPx \
        		-fill "#a0a0a0" -width $widl
    		set seltok "Выберите рабочий токен"
    		$fr.can create text [expr $xLocTextPx + 5] $yLocTextPx -anchor w -font fontTEMP_drawer -text $seltok -fill blue
    		set yLineLocPx [ expr (( $drawerCNT + 1) * $drawerHeightPx + $boxbut)]

		set  wd [expr {int ($::px2mm / 2)}]
		set  sz [expr {int($::px2mm * 5)}]
		set x1 $xLocTextPx
		set y1 $yLineLocPx
		set ::rx1 $x1
		set ::ry1 $y1
		set ::rfr $fr
		set x2 [expr $x1 + $sz]
		set y2 [expr $y1 + $sz]
		set imt1 [create_rectangle $fr.can "sw" $x1 $y1 $x2 $y2  "#58a95a" 0.9 $wd "snow"]
    		$fr.can create text $x2 [expr {($y1 + $y2) / 2 }] \
			-anchor w -font fontTEMP_drawer -text " - программный токен" 
		set y1 [expr {$yLineLocPx + $sz + $sz / 2}]
		set x2 [expr $x1 + $sz]
		set y2 [expr $y1 + $sz]
		set imt2 [create_rectangle $fr.can "cloud" $x1 $y1 $x2 $y2  "skyblue" 0.1 $wd "#58a95a"]
    		$fr.can create text $x2 [expr {($y1 + $y2) / 2 }] \
			-anchor w -font fontTEMP_drawer -text " - облачный токен" 
		set y1 [expr {$yLineLocPx + $sz * 2 + $sz }]
		set x2 [expr $x1 + $sz]
		set y2 [expr $y1 + $sz]
		set imt3 [create_rectangle $fr.can "hw" $x1 $y1 $x2 $y2  "skyblue" 0.1 $wd "#58a95a"]
    		$fr.can create text $x2 [expr {($y1 + $y2) / 2 }] \
			-anchor w -font fontTEMP_drawer -text " - другой токен" 
	    } else {
    		$fr.can create line $xLocTextPx $yLineLocPx \
        	[expr $drawerWidthPx + $xLocTextPx] $yLineLocPx \
        	-fill "#a0a0a0" -width $widl
	    }
	}
    }
}
#Create Widget for enter PIN or Password
page_password
#Создаем стартовую страницу
ttk::frame .fr$i -pad 0 -padding 0
#frame .fr$i -padx 0 -relief flat -bd 0
page_titul ".fr$i"  "logo_ls"
#page_titul ".fr$i"  "logo_orel"
pack .fr$i -side top -anchor center -expand 1 -fill both -side top  -padx 0 -pady 0 
update
#Создаем страницы с функционалом
incr i
ttk::frame .fr$i -pad 0 -padding 0
#Кнопки основного меню
    set but(0) "Стартовая страница" 
    set but(1) "Подписать документ"
    set but(2) "Работаем с ЭП (PKCS7)" 
    set but(3) "Запрос на сертификат" 
    set but(4) "Просмотр запроса/сертификата" 
    set but(5) "О токене и его криптографии"
    set but(6) "Объекты токена" 
    set but(7) "Работаем с PKCS12/PFX" 
    set but(8) "Самоподписанный сертификат"
    set but(9) "Об Утилите/Дистрибутивы" 
    set but(10) "Подключнение Токенов PKCS#11"
    set but(11) "Конфигурировние токена"
#    set but(12) "Просмотр ASN1-структуры" 
#parray but
if {0} {
set i2 0
    set but($i2) "Стартовая страница" 
incr i2
    set but($i2) "Подписать документ"
incr i2
    set but($i2) "Работаем с ЭП (PKCS7)" 
incr i2
    set but($i2) "Запрос на сертификат" 
incr i2
    set but($i2) "Просмотр запроса/сертификата" 
incr i2
    set but($i2) "Список криптомеханизмов"
incr i2
    set but($i2) "Объекты токена" 
incr i2
    set but($i2) "Работаем с PKCS12/PFX" 
incr i2
    set but($i2) "Самоподписанный сертификат"
incr i2
    set but($i2) "Об Утилите/Дистрибутивы" 
incr i2
    set but($i2) "Подключнение Токенов PKCS#11"
incr i2
    set but($i2) "Конфигурировние токена"
incr i2
    set but($i2) "Просмотр ASN1-структуры" 
parray but
}

if {$::typetlf} {
	scaleImage voda 3 2
}

#page_func ".fr$i" voda "Функционал" "but"
page_func ".fr$i" newtile "Функционал" "but"
#ЧАСЫ СТАРТ
proc hands {} {
    global ttt
update 
    set ::twopi 6.283185
    catch { .topclock.c delete withtag hands }

    # Compute seconds since midnight

    set s [expr { [clock seconds] - [clock scan 00:00:00] }]
if {$::typetlf == 0} {
    # Angle of second hand

    set angle [expr { $s * $::twopi / 60. }]
    set y [expr { 100 - 90 * cos($angle) }]
    set x [expr { 100 + 90 * sin($angle) }]
    .topclock.c create line 100 100 $x $y -width 1 -tags hands

    # Minute hand

    set angle [expr { $s * $::twopi / 60. / 60. }]
    set y [expr { 100 - 85 * cos($angle) }]
    set x [expr { 100 + 85 * sin($angle) }]
    .topclock.c create line 100 100 $x $y -width 3 -capstyle projecting -tags  hands

    # Hour hand

    set angle [expr { $s * $::twopi / 60. / 60. / 12. }]
    set y [expr { 100 - 60 * cos($angle) }]
    set x [expr { 100 + 60 * sin($angle) }]
    .topclock.c create line 100 100 $x $y -width 7 -capstyle projecting -tags hands
} else {
    # Angle of second hand

    set angle [expr { $s * $::twopi / 60. }]
    set y [expr { 200 - 180 * cos($angle) }]
    set x [expr { 200 + 180 * sin($angle) }]
    .topclock.c create line 200 200 $x $y -width 1 -tags hands

    # Minute hand

    set angle [expr { $s * $::twopi / 60. / 60. }]
    set y [expr { 200 - 170 * cos($angle) }]
    set x [expr { 200 + 170 * sin($angle) }]
    .topclock.c create line 200 200 $x $y -width 3 -capstyle projecting -tags  hands

    # Hour hand

    set angle [expr { $s * $::twopi / 60. / 60. / 12. }]
    set y [expr { 200 - 120 * cos($angle) }]
    set x [expr { 200 + 120 * sin($angle) }]
    .topclock.c create line 200 200 $x $y -width 7 -capstyle projecting -tags hands
}

    set ttt $angle
    after 1000 hands
}

proc guiclock_fr { } {
 set halfpi 1.570796
 set piover6 0.5235987
  global typesys
  variable opts
  variable vars
  set w ".topclock"
  catch {destroy $w}
  labelframe .topclock -relief groove -bd 6 -fg blue  -text "Идет процесс подписания" -padx 5 -pady 3 -font "helvetica 8 bold italic" -bg #eff0f1
if {$::typetlf == 0} {
 pack [canvas .topclock.c -width 200 -height 200 -bg chocolate]

 .topclock.c create oval 2 2 198 198 -fill white -outline white
 for { set h 1 } { $h <= 12 } { incr h } {
    set angle [expr { $halfpi - $piover6 * $h }]
    set x [expr { 100 + 90 * cos($angle) }]
    set y [expr { 100 - 90 * sin($angle) }]
    .topclock.c create text $x $y -text $h 
    #-font {Helvetica -12}
 }
} else {
 pack [canvas .topclock.c -width 400 -height 400 -bg chocolate]

 .topclock.c create oval 2 2 396 396 -fill white -outline white
 for { set h 1 } { $h <= 12 } { incr h } {
    set angle [expr { $halfpi - $piover6 * $h }]
    set x [expr { 200 + 180 * cos($angle) }]
    set y [expr { 200 - 180 * sin($angle) }]
    .topclock.c create text $x $y -text $h 
    #-font {Helvetica -12}
 }
}

  label $w.lclock -text "Начался процесс подписания\nдокумента из файла\nXAXAXA\nПодождите некоторое время!" -bg snow  -fg blue
  #   -font labelfont
  #   -font {Times 11 bold italic}
  pack $w.lclock -side top -anchor w -pady 5 -padx 5 -fill x
  hands
#  wm state $w withdraw
}

my_mes
guiclock_fr
if {$::typetlf} {
    set ::pkcs11_module "libls11sw2016.so"
} else {
    set ::pkcs11_module "./libls11sw2016.so"
}
#Всплывающая информация
set tinfo "\n\tПодождите!\nИдет проверка облачного токена!\n"
label .linfo -relief groove -bd 6 -fg blue  -text $tinfo -padx 0 -padx 3 -pady 3 -font "helvetica 8 bold italic" -bg #eff0f1 -justify left -wraplength $::scrwidth

::updatetok
#ЧАСЫ КОНЕЦ
