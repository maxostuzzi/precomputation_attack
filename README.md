This is the code for the key recovery attack described in the paper eprint/2024/564.

The script in setting.sage is taken from https://joostrenes.nl/software/, while the remaining part is novel.

These three sage scripts (one for the settings, two for the attack) are meant to be used one after the other, since precomputation.sage calls functions defined in settings.sage ones and online.sage calls functions defined in precomputation.sage. The file precomputation.sage also contains the code for the "instantiated PRF". 

If you have comments or suggestions for improving the quality of the code, feel free to reach out at massimo[dot]ostuzzi[at]rub[dot]de.
