This is the code for the key recovery attack described in ....

The code in setting.sage is taken from https://joostrenes.nl/software/, while the rest of the code is original.

These three sage scripts (one for the settings, two for the attack) are meant to be used one after the other, since precomputation.sage calls functions defined in settings.sage ones and online.sage calls functions defined in precomputation.sage. The file precomputation.sage also contains the code for the "instantiated PRF". 
