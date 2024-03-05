* Encoding: UTF-8.
** Rupture de la structure sociale = poleff recalculé sur l'intervalle 0 à 1, initialement de 0 à 3**

COMPUTE RSS=Poleff  / 3.


** Rupture de la structure normative = PITF recalculé sur l'intervalle 0 à 1, initialement de 0 à 4+ (plafond à 4)**
**Changer les valeurs supérieures à 4, donnant une valeur supérieure à 1 après le recalcul, pour avoir un maximum à 1.**

COMPUTE RNS=PITF / 4.

**Rupture des structures = moyenne des ruptures des structures sociale et normative**

COMPUTE RupStruc=MEAN(RSS,RNS).

**Menace à l'identité = polleg recalculé sur l'intervalle 0 à 1, initialement de 0 à 3**

COMPUTE TCI=Polleg  / 3.


