abstract Attempto =
  Numeral, Symbols, Questions ** {

-- Use Text to get only single-sentence texts.
flags startcat = ACEText ;

cat ACEText ;
cat Text ;
cat Sentence ;
cat Question ;

cat CN ; cat VarCN ;
cat NP ; cat ThereNP ;
cat Card ;
cat PN ;
-- Some lexicons require A (see e.g. /words/acewiki_aceowl/)
cat A ;
cat A2 ;
cat RS ;
cat Pron ; IndefPron ; IndefTherePron ;
cat S ;
cat VP ;
cat V ;
cat V2 ;
-- V2 that can be used in the passive structure
cat V2by ;
cat Conj ;
cat IP ;
cat IDet ;
cat QS ;
cat RP ;
cat MCN ;
cat PP ;
cat VPS ;
cat [VPS] {2} ;


fun aNP : VarCN -> ThereNP ;
fun theNP : VarCN -> NP ;
-- Note: in full ACE this must be ThereNP [KK]
fun noNP : VarCN -> NP ;
fun everyNP : VarCN -> NP ;

fun pnNP : PN -> NP ;

-- [JJC] [KK]
-- - ACE and AceWiki do not allow 'there is every-'
-- - AceWiki does not allow 'there is no-' (but ACE does)
-- - ACE and AceWiki allow 'there is some-'
fun somebody_IPron : IndefTherePron ;
fun something_IPron : IndefTherePron ;
fun everybody_IPron : IndefPron ;
fun everything_IPron : IndefPron ;
fun nobody_IPron : IndefPron ;
fun nothing_IPron : IndefPron ;

-- [JJC] [KK]
fun indefTherePronNP : IndefTherePron -> ThereNP ;
fun indefPronNP : IndefPron -> NP ;

fun indefTherePronVarNP : IndefTherePron -> Var -> ThereNP ;
fun indefPronVarNP : IndefPron -> Var -> NP ;

fun at_leastNP : Card -> VarCN -> ThereNP ;
fun at_mostNP : Card -> VarCN -> ThereNP ;
fun more_thanNP : Card -> VarCN -> ThereNP ;
fun less_thanNP : Card -> VarCN -> ThereNP ;
fun exactlyNP : Card -> VarCN -> ThereNP ;

fun nothing_butNP : VarCN -> NP ;

fun apposVarCN : CN -> Var -> VarCN ;  -- a man X

fun cn_as_VarCN : CN -> VarCN ;

-- Note: in full ACE this must be ThereNP [KK]
fun termNP : Var -> NP ;

-- Relative clause can be attached to both CNs and NPs.
-- relCN provides relative clauses in constructs like
-- `which woman who ...` and `for every woman who ...`
fun relCN : VarCN -> RS -> VarCN ;
fun relNP : NP -> RS -> NP ;
--fun relThereNP : ThereNP -> RS -> ThereNP ; avoid ambiguity generated by ThereNP [JJC]

fun andRS : RS -> RS -> RS ;
fun orRS : RS -> RS -> RS ;

fun predRS : RP -> VP -> RS ;
fun neg_predRS : RP -> VP -> RS ;
fun slashRS : RP -> NP -> V2 -> RS ;
fun neg_slashRS : RP -> NP -> V2 -> RS ;

fun which_RP : RP ;

-- of-construction
-- example: dog of John and Mary
-- This version does not allow 'dog X of John' which is supported
-- by full ACE but not in AceWiki. Note that naively changing the rule to
-- "VarCN -> NP -> VarCN" would allow complex of-structures,
-- e.g. ((dog of X) of X), most of which ACE does not allow. [KK]
fun ofCN : CN -> NP -> VarCN ;

fun vpS : NP -> VP -> S ;
fun neg_vpS : NP -> VP -> S ;

fun v2VP : V2 -> NP -> VP ;
fun refl_v2VP : V2 -> VP ;

fun a2VP : A2 -> NP -> VP ; -- is mad-about NP
fun refl_a2VP : A2 -> VP ; -- is mad-about itself

fun thereNP : ThereNP -> S ;  -- there is/are

fun thereNP_as_NP : ThereNP -> NP ;

fun coordS : Conj -> S -> S -> S ;

fun and_Conj : Conj ;
fun or_Conj : Conj ;

-- In order to implement VP coordination, we
-- (1) convert VP into VPS,
-- (2) use VPS coordination producing VPS,
-- (3) map VPS into S (and QS?) (but definitely not into RS).
fun vp_as_posVPS : VP -> VPS ;
fun vp_as_negVPS : VP -> VPS ;
fun np_coord_VPS : NP -> Conj -> [VPS] -> S ;

fun for_everyS : VarCN -> S -> S ;

fun if_thenS : S -> S -> S ;
fun falseS : S -> S ; -- it is false that

-- These have been replaced by the more generic function npqQS, which allows
-- for wh-words in the object position of a relative clause as subject
-- e.g. "somebody who is who is a man?"
--fun ipQS : IP -> VP -> QS ;
--fun neg_ipQS : IP -> VP -> QS ;

-- who does Mary like?
fun slash_ipQS : IP -> NP -> V2 -> QS ;

-- who does Mary not like?
fun neg_slash_ipQS : IP -> NP -> V2 -> QS ;

fun whoSg_IP : IP ;
fun whatSg_IP : IP ;

fun whichIP : IDet -> VarCN -> IP ;
fun which_IDet : IDet ;
fun whichPl_IDet : IDet ;

fun consText : Text -> ACEText -> ACEText ;

fun baseText : Text -> ACEText ;

-- Identity functions
fun sText : Sentence -> Text ;
fun qsText : Question -> Text ;

-- Adds '.'
fun s : S -> Sentence ;
-- Adds '?'
fun qs : QS -> Question ;

fun npVP  : NP -> VP ;              -- is a bank
fun digitsCard : Digits -> Card ;   -- 8 banks
fun v2_byVP : V2by -> NP -> VP ;    -- is bought by a customer
fun V2by_as_V2 : V2by -> V2 ;

}