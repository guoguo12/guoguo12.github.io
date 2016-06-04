How do you pronounce "brizzuoplatuong"?

You've probably never heard anyone say "brizzuoplatuong" before, because I made it up. And yet, you were probably able to generate a reasonable pronunciation for it. Your brain has seemingly inferred *general rules* about how to pronounce English words based on the thousands of words it has heard before. It then applied those rules in generating a pronunciation for the nonce word "brizzuoplatuong".

The technical name for this task is **grapheme-to-phoneme (G2P) conversion**&mdash;that is, translating from alphabetical characters (graphemes) to sounds (phonemes). A fully-trained G2P model can be thought of as a "pronunciation generator": text goes in, pronunciations come out.

In this post, we'll train our very own G2P model using [Sequitur](https://github.com/sequitur-g2p/sequitur-g2p). We'll then evaluate its performance on words it has never seen before, as well as words *nobody* has ever seen before.

This is a beginner tutorial. The only prerequisite is competency with the command-line.

## Setup

To begin, clone [Sequitur](https://github.com/sequitur-g2p/sequitur-g2p) and follow the installation instructions in the "Installing" section of the README. 

<!--(If you're a Docker user, I've checked that Sequitur installs cleanly on [ipython/scipystack](https://hub.docker.com/r/ipython/scipystack/).)-->

To check Sequitur is installed correctly, type `g2p.py` into terminal. You should see something like this:

```bash
$ g2p.py
Try '/usr/local/bin/g2p.py --help'
```

We'll be training our model on CMUdict, a pronouncing dictionary produced by Carnegie Mellon University. It contains the pronunciations of over 130,000 words! From CMUdict, our model will "learn" general rules about how English words are pronounced. It will then be able to apply those rules to synthesize pronunciations for previously unseen words.

Clone [CMUdict](https://github.com/cmusphinx/cmudict), then open `cmudict.dict` and carefully examine how it is formatted.
Here are the first 10 lines:

```
'bout B AW1 T
'cause K AH0 Z
'course K AO1 R S
'cuse K Y UW1 Z
'em AH0 M
'frisco F R IH1 S K OW0
'gain G EH1 N
'kay K EY1
'm AH0 M
'n AH0 N
```

Some key points about `cmudict.dict`:

* The entire file is sorted alphabetically by line.
* Each line contains a single word, followed by how it is pronounced.
* Some words have multiple pronunciations. Duplicates are numbered. For example, compare "tomato" and "tomato(2)".
* Each pronunciation consists of one or more sounds, which are called *phones* or *phonemes*. (We will use these terms interchangeably.)
* Vowel phones carry numerical stress markers (0, 1, or 2).

Note that it's not always obvious what sound a phone represents. For instance, the phone "AH" actually represents the sound "uh", as in "bug". Refer to the "Phoneme Set" section on the [CMUdict website](http://www.speech.cs.cmu.edu/cgi-bin/cmudict) for details.

## Data prep

Before we can start training, we need to clean and divide up the data. To begin, create a working directory and `cd` into it.

### Cleaning

For G2P model training, we don't care about stress markings. Multiple pronunciations are okay, but we don't want duplicates to be numbered. We'll also make everything lowercase, for mostly aesthetic reasons. So in short, we want

```
tomato T AH0 M EY1 T OW2
tomato(2) T AH0 M AA1 T OW2
```

to turn into

```
tomato t ah m ey t ow
tomato t ah m aa t ow
```

I can remember a time when I would gleefully write a Python script to accomplish this transformation. But there's a better way:

```
cat ~/data/cmudict/cmudict.dict | tr A-Z a-z | sed 's/[()0-9]//g' > all.lex
```

The resulting file, `all.lex`, is our cleaned dataset.

### Splitting

By running `wc -l all.lex`, we observe that our dataset contains 135,025 total words. We'll randomly select 20% (or 27,005 words) to form our test set, which we'll use to evaluate our model's performance later. The remaining 80% (108,020 words) will be our training set.

```bash
shuf all.lex -o all.lex  # shuffle all.lex
head -n 108020 all.lex > train.lex
tail -n 27005 all.lex > test.lex
```

(Note for ML experts: We don't need to worry about creating a development/validation set because Sequitur can do it automatically.) 

We can check our work by making sure `all.lex` is the same as `train.lex` prepended to `test.lex`:

```bash
diff <(cat train.lex test.lex) all.lex  # should have empty output
```

## Training

Now we can train our model. Sequitur makes this very straightforward:

```bash
g2p.py --train train.lex --devel 5% --write-model model-1
g2p.py --model model-1 --ramp-up --train train.lex --devel 5% --write-model model-2
g2p.py --model model-2 --ramp-up --train train.lex --devel 5% --write-model model-3
g2p.py --model model-3 --ramp-up --train train.lex --devel 5% --write-model model-4
```

This four-stage process creates an initial model (`model-1`) then iteratively improves upon it, increasing the model complexity with each stage.

Training might take a while. On my machine, the four steps above ran for about six hours. If you're using a remote server for training (over SSH), be sure to use `screen` so your processes don't die if your connection drops.

If you'd like to skip ahead, you can download my final model [here](downloads/model-4) (5.5 MB).

## Results

### Manual inspection

We can evaluate our model's performance by generating pronunciations for words we know. Let's try the word "crayons":

```bash
$ echo crayons | g2p.py --model model-4 --apply -
crayons k r ey aa n z
```

Pretty cool! The model generated the correct pronunciation. But then again, for me, the word "crayons" was in my training set:

```bash
$ grep crayons train.lex
crayons k r ey aa n z
```

So while it's nice to see that the model seems to have learned *something*, what we'd really like is visual proof that the rules learned by our model are *generalizable* to previously unseen words. 

To that end, let's try a word that wasn't in CMUdict to begin with, like "lyft":

```bash
$ echo lyft | g2p.py --model model-4 --apply -
lyft    l ih f t
```

Aha! Now we're seeing the magic at work. Our model has apparently *learned* something about how certain graphemes sound in the context of other graphemes: it seems to "know" that "y" is pronounced like "ih" in the word "lyft".

Let's try another word, "wug" (of [Wug Test](https://en.wikipedia.org/wiki/Jean_Berko_Gleason#Children.27s_learning_of_English_morphology.E2.80.94.E2.80.8B.E2.80.8Bthe_Wug_Test) fame):

```bash
$ echo wug | g2p.py --model model-4 --apply -
wug     w ah g
```

Looks good to me! (Remember, the phoneme "ah" corresponds to the "uh" sound, as in "bug". See the [CMUdict website](http://www.speech.cs.cmu.edu/cgi-bin/cmudict).)

Alright, let's try a longer word. How about "[supercalifragilisticexpialidocious](https://en.wikipedia.org/wiki/Supercalifragilisticexpialidocious)"?

```
$ echo supercalifragilisticexpialidocious | g2p.py --model model-4 --apply -
supercalifragilisticexpialidocious      s uw p er k ae l ah f r ae jh ah l ih s t ih s ah k s p iy ae l ah d ow sh ah s
```

Not bad, but here there are noticeable errors. In particular, the model predicts that the "c" at the end of "fragilistic" is pronounced like "-s", when actually it's pronounced like "-ck". We can reason about why the model might have generated the wrong result: perhaps when the letter "c" occurs directly between the letters "i" and "e"&mdash;such as in "price" or "solstice"&mdash;it is almost always pronounced like "-s".

Now we'll try words that are totally and overtly made up, such as

```bash
$ echo brizzuoplatuong | g2p.py --model model-4 --apply -
brizzuoplatuong b r iy t s uw aa p l ah t w ao ng
```

or

```bash
$ echo surprochesamun | g2p.py --model model-4 --apply -
surprochesamun  s ah p r ow k eh s ah m uw n
```

Do the model's predictions match your own predictions?

Exercise: Try making up words that the model performs really poorly on, relative to your own intuition. Why do you think the model does so poorly on them?

### Test set

Finally, we can more convincingly show that our model is generalizable by synthesizing pronunciations for the words in our test set and comparing them to the expected results:

```bash
g2p.py --model model-4 --test test.lex > output
```

The last few lines of the output file summarize how the model performed on the test set:

```
total: 26622 strings, 169607 symbols
successfully translated: 26622 (100.00%) strings, 169607 (100.00%) symbols
    string errors:       9528 (35.79%)
    symbol errors:       14311 (8.44%)
        insertions:      1355 (0.80%)
        deletions:       1568 (0.92%)
        substitutions:   11388 (6.71%)
translation failed:      0 (0.00%) strings, 0 (0.00%) symbols
total string errors:     9528 (35.79%)
total symbol errors:     14311 (8.44%)
```

"Total string errors" is the number of words the model got wrong. "Total symbol errors" is the number of inserted, deleted, or substituted phones across all words.

## Final thoughts

As a next step, try training more complex models (based on `model-4`), or playing with the myriad of advanced options that Sequitur offers (try `g2p.py --help`). How much can you reduce the test error by?

If you're interested in how Sequitur works, check out "Joint-Sequence Models for Grapheme-to-Phoneme Conversion" by Bisani and Ney.

<!--A more recent (2015) paper on G2P that is interesting to read is "Grapheme-to-Phoneme Conversion Using Long Short-Term Memory Recurrent Neural Networks" by Rao et al., available [here](https://static.googleusercontent.com/media/research.google.com/en//pubs/archive/43264.pdf).-->

<!--According to the paper, a ninth-order model (i.e. `model-9`) ought to achieve a string error rate of ~25% on CMUdict.-->

<!--STANDARD FOOTER FOLLOWS-->
</div>
<hr>
<p>
If you liked this, check out my <a href="/#writings">other works</a> or find me on <a href="https://github.com/guoguo12" target="_blank">GitHub</a>.
</p>
<p>
Thanks to Korbinian Riedhammer for reading a draft of this.
<p>
