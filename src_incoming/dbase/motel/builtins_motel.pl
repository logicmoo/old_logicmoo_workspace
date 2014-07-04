:-asserta(in_motel_kb(fssKB)).

makeEnvironment(fssKB,"What means fss?").
defconcept(fssKB,[],bot,not(top)).
defconcept(fssKB,[],taeglich,and([daily,lexicon])).
defconcept(fssKB,[],monat,and([monthly,lexicon])).
defconcept(fssKB,[],d,and([determiner,lexicon])).
defconcept(fssKB,[],ein,and([indefinite,lexicon])).
defconcept(fssKB,[],number35,and([cardinal,lexicon])).
defconcept(fssKB,[],fuenfunddreissig,and([cardinal,lexicon])).
defconcept(fssKB,[],der,and([definite,lexicon])).
defconcept(fssKB,[],die,and([definite,lexicon])).
defconcept(fssKB,[],dem,and([lexicon,definite])).
defconcept(fssKB,[],mein,and([lexicon,determiner])).
defconcept(fssKB,[],concept12,and([atleast(1,truth_mod),atmost(1,truth_mod)])).
defconcept(fssKB,[],abstract_thing,and([concept12,thing])).
defconcept(fssKB,[],concept20,and([atleast(1,det),atmost(1,det)])).
defconcept(fssKB,[],concept27,and([atleast(1,deictic_mod),atmost(1,deictic_mod)])).
defconcept(fssKB,[],concept34,and([atleast(1,named),atmost(1,named)])).
defconcept(fssKB,[],thing,and([concept34,concept27,concept20,property_filler])).
defconcept(fssKB,[],concept42,and([atleast(1,subject),atmost(1,subject)])).
defconcept(fssKB,[],concept49,and([atleast(1,purpose),atmost(1,purpose)])).
defconcept(fssKB,[],concept56,and([atleast(1,time),atmost(1,time)])).
defconcept(fssKB,[],concept63,and([atleast(1,illoc),atmost(1,illoc)])).
defconcept(fssKB,[],concept70,and([atleast(1,cause),atmost(1,cause)])).
defconcept(fssKB,[],concept77,and([atleast(1,result),atmost(1,result)])).
defconcept(fssKB,[],concept84,and([atleast(1,location),atmost(1,location)])).
defconcept(fssKB,[],concept90,atleast(1,subject)).
defconcept(fssKB,[],predicate,and([concept90,concept84,concept77,concept70,concept63,concept56,concept49,concept42,fss])).
defconcept(fssKB,[],concept93,some(time,top)).
defconcept(fssKB,[],concept96,and([atleast(1,volition),atmost(1,volition)])).
defconcept(fssKB,[],human,and([concept96,animate])).
defconcept(fssKB,[],concept104,and([atleast(1,origin_mod),atmost(1,origin_mod)])).
defconcept(fssKB,[],geographical_object,and([concept104,inanimate])).
defconcept(fssKB,[],concept111,some(subject,top)).
defconcept(fssKB,[],concept113,some(location,top)).
defconcept(fssKB,[],concept116,and([atleast(1,colour_mod),atmost(1,colour_mod)])).
defconcept(fssKB,[],concrete_thing,and([concept116,thing])).
defconcept(fssKB,[],concept124,and([atleast(1,relative_mod),atmost(1,relative_mod)])).
defconcept(fssKB,[],individual,and([concept124,concrete_thing])).
defconcept(fssKB,[],mass_noun,and([concrete_thing])).
defconcept(fssKB,[],concept132,and([atleast(1,material_mod),atmost(1,material_mod)])).
defconcept(fssKB,[],inanimate,and([concept132,individual])).
defconcept(fssKB,[],concept140,and([atleast(1,weight_mod),atmost(1,weight_mod)])).
defconcept(fssKB,[],touchable_object,and([concept140,inanimate])).
defconcept(fssKB,[],concept147,some(subject,top)).
defconcept(fssKB,[],concept150,and([atleast(1,instrument),atmost(1,instrument)])).
defconcept(fssKB,[],concept157,and([atleast(1,concerned),atmost(1,concerned)])).
defconcept(fssKB,[],action,and([concept157,concept150,concept147,predicate])).
defconcept(fssKB,[],concept165,and([atleast(1,destination),atmost(1,destination)])).
defconcept(fssKB,[],concept172,and([atleast(1,source),atmost(1,source)])).
defconcept(fssKB,[],motion,and([concept172,concept165,action])).
defconcept(fssKB,[],concept180,atleast(1,means)).
defconcept(fssKB,[],motion_by_means,and([concept180,motion])).
defconcept(fssKB,[],fahr,and([lexicon,motion_by_means])).
defconcept(fssKB,[],geh,and([lexicon,motion])).
defconcept(fssKB,[],treff,and([lexicon,action])).
defconcept(fssKB,[],concept186,atleast(1,concerned)).
defconcept(fssKB,[],werf,and([concept186,lexicon,action])).
defconcept(fssKB,[],causative,and([action])).
defconcept(fssKB,[],concept190,atleast(1,result)).
defconcept(fssKB,[],productive,and([concept190,causative])).
defconcept(fssKB,[],concept194,atleast(1,concerned)).
defconcept(fssKB,[],write,and([concept194,productive])).
defconcept(fssKB,[],concept197,some(location,top)).
defconcept(fssKB,[],enter,and([concept197,write])).
defconcept(fssKB,[],arbeit,and([lexicon,action])).
defconcept(fssKB,[],concept202,and([atleast(1,beneficative),atmost(1,beneficative)])).
defconcept(fssKB,[],transaction,and([concept202,action])).
defconcept(fssKB,[],concept209,atleast(1,concerned)).
defconcept(fssKB,[],schenk,and([concept209,lexicon,transaction])).
defconcept(fssKB,[],concept212,atleast(1,concerned)).
defconcept(fssKB,[],kauf,and([concept212,lexicon,transaction])).
defconcept(fssKB,[],unterricht,and([predicate,lexicon])).
defconcept(fssKB,[],concept218,and([atleast(1,measure),atmost(1,measure)])).
defconcept(fssKB,[],value_property,and([concept218,property])).
defconcept(fssKB,[],concept226,atleast(1,measure)).
defconcept(fssKB,[],cost,and([concept226,value_property])).
defconcept(fssKB,[],kost,and([cost,lexicon])).
defconcept(fssKB,[],concept230,some(has_property,top)).
defconcept(fssKB,[],concept232,some(det,top)).
defconcept(fssKB,[],concept234,atleast(1,quantity)).
defconcept(fssKB,[],indication_of_quantity,and([concept234,concept232,abstract_thing])).
defconcept(fssKB,[],dm,and([indication_of_quantity,lexicon])).
defconcept(fssKB,[],fahrt,and([thing,lexicon])).
defconcept(fssKB,[],das,and([thing,lexicon])).
defconcept(fssKB,[],concept241,and([atleast(1,physis_mod),atmost(1,physis_mod)])).
defconcept(fssKB,[],animate,and([concept241,individual])).
defconcept(fssKB,[],mann,and([human,lexicon])).
defconcept(fssKB,[],junge,and([human,lexicon])).
defconcept(fssKB,[],karl,and([lexicon,human])).
defconcept(fssKB,[],ich,and([lexicon,human])).
defconcept(fssKB,[],peter,and([lexicon,human])).
defconcept(fssKB,[],concept254,and([atleast(1,volition),atmost(1,volition)])).
defconcept(fssKB,[],animal,and([concept254,animate])).
defconcept(fssKB,[],voelklingen,and([town,lexicon])).
defconcept(fssKB,[],saarbruecken,and([town,lexicon])).
defconcept(fssKB,[],dudweiler,and([town,lexicon])).
defconcept(fssKB,[],saarlouis,and([lexicon,town])).
defconcept(fssKB,[],wald,and([geographical_object,lexicon])).
defconcept(fssKB,[],hier,and([geographical_object,lexicon])).
defconcept(fssKB,[],ort,and([lexicon,geographical_object])).
defconcept(fssKB,[],concept265,and([atleast(1,worth_mod),atmost(1,worth_mod)])).
defconcept(fssKB,[],vehicle,and([concept265,touchable_object])).
defconcept(fssKB,[],fahrrad,and([vehicle,lexicon])).
defconcept(fssKB,[],bus,and([bus,lexicon])).
defconcept(fssKB,[],buch,and([lexicon,touchable_object])).
defconcept(fssKB,[],auktion,and([lexicon,thing])).
defconcept(fssKB,[],was,and([lexicon,thing])).
defprimconcept(fssKB,[],lexicon,sbone).
defprimconcept(fssKB,[],not(sbone),not(lexicon)).
defprimconcept(fssKB,[],fss,sbone).
defprimconcept(fssKB,[],not(sbone),not(fss)).
defprimconcept(fssKB,[],pointing,fss).
defprimconcept(fssKB,[],not(fss),not(pointing)).
defprimconcept(fssKB,[],vague_p,pointing).
defprimconcept(fssKB,[],not(pointing),not(vague_p)).
defprimconcept(fssKB,[],standard_p,pointing).
defprimconcept(fssKB,[],not(pointing),not(standard_p)).
defprimconcept(fssKB,[],encircling_p,pointing).
defprimconcept(fssKB,[],not(pointing),not(encircling_p)).
defprimconcept(fssKB,[],exact_p,pointing).
defprimconcept(fssKB,[],not(pointing),not(exact_p)).
defprimconcept(fssKB,[],time,fss).
defprimconcept(fssKB,[],not(fss),not(time)).
defprimconcept(fssKB,[],moment,time).
defprimconcept(fssKB,[],not(time),not(moment)).
defprimconcept(fssKB,[],period,time).
defprimconcept(fssKB,[],not(time),not(period)).
defprimconcept(fssKB,[],interval,time).
defprimconcept(fssKB,[],not(time),not(interval)).
defprimconcept(fssKB,[],yearly,interval).
defprimconcept(fssKB,[],not(interval),not(yearly)).
defprimconcept(fssKB,[],jaehrlich,yearly).
defprimconcept(fssKB,[],not(yearly),not(jaehrlich)).
defprimconcept(fssKB,[],jaehrlich,lexicon).
defprimconcept(fssKB,[],not(lexicon),not(jaehrlich)).
defprimconcept(fssKB,[],weekly,interval).
defprimconcept(fssKB,[],not(interval),not(weekly)).
defprimconcept(fssKB,[],woechentlich,lexicon).
defprimconcept(fssKB,[],not(lexicon),not(woechentlich)).
defprimconcept(fssKB,[],woechentlich,weekly).
defprimconcept(fssKB,[],not(weekly),not(woechentlich)).
defprimconcept(fssKB,[],daily,interval).
defprimconcept(fssKB,[],not(interval),not(daily)).
defprimconcept(fssKB,[],monthly,interval).
defprimconcept(fssKB,[],not(interval),not(monthly)).
defprimconcept(fssKB,[],speech_act,fss).
defprimconcept(fssKB,[],not(fss),not(speech_act)).
defprimconcept(fssKB,[],order,speech_act).
defprimconcept(fssKB,[],not(speech_act),not(order)).
defprimconcept(fssKB,[],assertion,speech_act).
defprimconcept(fssKB,[],not(speech_act),not(assertion)).
defprimconcept(fssKB,[],question,speech_act).
defprimconcept(fssKB,[],not(speech_act),not(question)).
defprimconcept(fssKB,[],interjection,speech_act).
defprimconcept(fssKB,[],not(speech_act),not(interjection)).
defprimconcept(fssKB,[],determiner,fss).
defprimconcept(fssKB,[],not(fss),not(determiner)).
defprimconcept(fssKB,[],indefinite,determiner).
defprimconcept(fssKB,[],not(determiner),not(indefinite)).
defprimconcept(fssKB,[],cardinal,indefinite).
defprimconcept(fssKB,[],not(indefinite),not(cardinal)).
defprimconcept(fssKB,[],number50,cardinal).
defprimconcept(fssKB,[],not(cardinal),not(number50)).
defprimconcept(fssKB,[],number50,lexicon).
defprimconcept(fssKB,[],not(lexicon),not(number50)).
defprimconcept(fssKB,[],interrogative,determiner).
defprimconcept(fssKB,[],not(determiner),not(interrogative)).
defprimconcept(fssKB,[],definite,determiner).
defprimconcept(fssKB,[],not(determiner),not(definite)).
defprimconcept(fssKB,[],demonstrative,definite).
defprimconcept(fssKB,[],not(definite),not(demonstrative)).
defprimconcept(fssKB,[],possessive,definite).
defprimconcept(fssKB,[],not(definite),not(possessive)).
defprimconcept(fssKB,[],property_filler,fss).
defprimconcept(fssKB,[],not(fss),not(property_filler)).
defprimconcept(fssKB,[],adjective_property,property_filler).
defprimconcept(fssKB,[],not(property_filler),not(adjective_property)).
defprimconcept(fssKB,[],truth_value,adjective_property).
defprimconcept(fssKB,[],not(adjective_property),not(truth_value)).
defprimconcept(fssKB,[],abstract_thing,some(truth_mod,top)).
defprimconcept(fssKB,[],all(truth_mod,not(top)),not(abstract_thing)).
defprimconcept(fssKB,[],some(inverse(truth_mod),top),truth_value).
defprimconcept(fssKB,[],not(truth_value),all(inverse(truth_mod),not(top))).
defprimconcept(fssKB,[],name,abstract_thing).
defprimconcept(fssKB,[],not(abstract_thing),not(name)).
defprimconcept(fssKB,[],thing,some(det,top)).
defprimconcept(fssKB,[],all(det,not(top)),not(thing)).
defprimconcept(fssKB,[],some(inverse(det),top),determiner).
defprimconcept(fssKB,[],not(determiner),all(inverse(det),not(top))).
defprimconcept(fssKB,[],thing,some(deictic_mod,top)).
defprimconcept(fssKB,[],all(deictic_mod,not(top)),not(thing)).
defprimconcept(fssKB,[],some(inverse(deictic_mod),top),pointing).
defprimconcept(fssKB,[],not(pointing),all(inverse(deictic_mod),not(top))).
defprimconcept(fssKB,[],thing,some(named,top)).
defprimconcept(fssKB,[],all(named,not(top)),not(thing)).
defprimconcept(fssKB,[],some(inverse(named),top),name).
defprimconcept(fssKB,[],not(name),all(inverse(named),not(top))).
defprimconcept(fssKB,[],predicate,some(subject,top)).
defprimconcept(fssKB,[],all(subject,not(top)),not(predicate)).
defprimconcept(fssKB,[],some(inverse(subject),top),thing).
defprimconcept(fssKB,[],not(thing),all(inverse(subject),not(top))).
defprimconcept(fssKB,[],predicate,some(purpose,top)).
defprimconcept(fssKB,[],all(purpose,not(top)),not(predicate)).
defprimconcept(fssKB,[],some(inverse(purpose),top),predicate).
defprimconcept(fssKB,[],not(predicate),all(inverse(purpose),not(top))).
defprimconcept(fssKB,[],predicate,some(time,top)).
defprimconcept(fssKB,[],all(time,not(top)),not(predicate)).
defprimconcept(fssKB,[],some(inverse(time),top),time).
defprimconcept(fssKB,[],not(time),all(inverse(time),not(top))).
defprimconcept(fssKB,[],predicate,some(illoc,top)).
defprimconcept(fssKB,[],all(illoc,not(top)),not(predicate)).
defprimconcept(fssKB,[],some(inverse(illoc),top),speech_act).
defprimconcept(fssKB,[],not(speech_act),all(inverse(illoc),not(top))).
defprimconcept(fssKB,[],predicate,some(cause,top)).
defprimconcept(fssKB,[],all(cause,not(top)),not(predicate)).
defprimconcept(fssKB,[],some(inverse(cause),top),predicate).
defprimconcept(fssKB,[],not(predicate),all(inverse(cause),not(top))).
defprimconcept(fssKB,[],predicate,some(result,top)).
defprimconcept(fssKB,[],all(result,not(top)),not(predicate)).
defprimconcept(fssKB,[],some(inverse(result),top),thing).
defprimconcept(fssKB,[],not(thing),all(inverse(result),not(top))).
defprimconcept(fssKB,[],predicate,some(location,top)).
defprimconcept(fssKB,[],all(location,not(top)),not(predicate)).
defprimconcept(fssKB,[],some(inverse(location),top),thing).
defprimconcept(fssKB,[],not(thing),all(inverse(location),not(top))).
defprimconcept(fssKB,[],state,predicate).
defprimconcept(fssKB,[],not(predicate),not(state)).
defprimconcept(fssKB,[],concept93,state).
defprimconcept(fssKB,[],not(state),not(concept93)).
defprimconcept(fssKB,[],human,some(volition,top)).
defprimconcept(fssKB,[],all(volition,not(top)),not(human)).
defprimconcept(fssKB,[],some(inverse(volition),top),volitional_sq).
defprimconcept(fssKB,[],not(volitional_sq),all(inverse(volition),not(top))).
defprimconcept(fssKB,[],geographical_object,some(origin_mod,top)).
defprimconcept(fssKB,[],all(origin_mod,not(top)),not(geographical_object)).
defprimconcept(fssKB,[],some(inverse(origin_mod),top),origin).
defprimconcept(fssKB,[],not(origin),all(inverse(origin_mod),not(top))).
defprimconcept(fssKB,[],wohn,lexicon).
defprimconcept(fssKB,[],not(lexicon),not(wohn)).
defprimconcept(fssKB,[],wohn,state).
defprimconcept(fssKB,[],not(state),not(wohn)).
defprimconcept(fssKB,[],concept111,wohn).
defprimconcept(fssKB,[],not(wohn),not(concept111)).
defprimconcept(fssKB,[],concept113,wohn).
defprimconcept(fssKB,[],not(wohn),not(concept113)).
defprimconcept(fssKB,[],qualitative,adjective_property).
defprimconcept(fssKB,[],not(adjective_property),not(qualitative)).
defprimconcept(fssKB,[],quality,qualitative).
defprimconcept(fssKB,[],not(qualitative),not(quality)).
defprimconcept(fssKB,[],colour,quality).
defprimconcept(fssKB,[],not(quality),not(colour)).
defprimconcept(fssKB,[],concrete_thing,some(colour_mod,top)).
defprimconcept(fssKB,[],all(colour_mod,not(top)),not(concrete_thing)).
defprimconcept(fssKB,[],some(inverse(colour_mod),top),colour).
defprimconcept(fssKB,[],not(colour),all(inverse(colour_mod),not(top))).
defprimconcept(fssKB,[],relation,adjective_property).
defprimconcept(fssKB,[],not(adjective_property),not(relation)).
defprimconcept(fssKB,[],individual,some(relative_mod,top)).
defprimconcept(fssKB,[],all(relative_mod,not(top)),not(individual)).
defprimconcept(fssKB,[],some(inverse(relative_mod),top),relation).
defprimconcept(fssKB,[],not(relation),all(inverse(relative_mod),not(top))).
defprimconcept(fssKB,[],material,mass_noun).
defprimconcept(fssKB,[],not(mass_noun),not(material)).
defprimconcept(fssKB,[],inanimate,some(material_mod,top)).
defprimconcept(fssKB,[],all(material_mod,not(top)),not(inanimate)).
defprimconcept(fssKB,[],some(inverse(material_mod),top),material).
defprimconcept(fssKB,[],not(material),all(inverse(material_mod),not(top))).
defprimconcept(fssKB,[],weight,quality).
defprimconcept(fssKB,[],not(quality),not(weight)).
defprimconcept(fssKB,[],touchable_object,some(weight_mod,top)).
defprimconcept(fssKB,[],all(weight_mod,not(top)),not(touchable_object)).
defprimconcept(fssKB,[],some(inverse(weight_mod),top),weight).
defprimconcept(fssKB,[],not(weight),all(inverse(weight_mod),not(top))).
defprimconcept(fssKB,[],action,some(instrument,top)).
defprimconcept(fssKB,[],all(instrument,not(top)),not(action)).
defprimconcept(fssKB,[],some(inverse(instrument),top),touchable_object).
defprimconcept(fssKB,[],not(touchable_object),all(inverse(instrument),not(top))).
defprimconcept(fssKB,[],action,some(concerned,top)).
defprimconcept(fssKB,[],all(concerned,not(top)),not(action)).
defprimconcept(fssKB,[],some(inverse(concerned),top),thing).
defprimconcept(fssKB,[],not(thing),all(inverse(concerned),not(top))).
defprimconcept(fssKB,[],do,action).
defprimconcept(fssKB,[],not(action),not(do)).
defprimconcept(fssKB,[],absetz,lexicon).
defprimconcept(fssKB,[],not(lexicon),not(absetz)).
defprimconcept(fssKB,[],absetz,do).
defprimconcept(fssKB,[],not(do),not(absetz)).
defprimconcept(fssKB,[],ausfuehr,lexicon).
defprimconcept(fssKB,[],not(lexicon),not(ausfuehr)).
defprimconcept(fssKB,[],ausfuehr,do).
defprimconcept(fssKB,[],not(do),not(ausfuehr)).
defprimconcept(fssKB,[],motion,some(destination,top)).
defprimconcept(fssKB,[],all(destination,not(top)),not(motion)).
defprimconcept(fssKB,[],some(inverse(destination),top),geographical_object).
defprimconcept(fssKB,[],not(geographical_object),all(inverse(destination),not(top))).
defprimconcept(fssKB,[],motion,some(source,top)).
defprimconcept(fssKB,[],all(source,not(top)),not(motion)).
defprimconcept(fssKB,[],some(inverse(source),top),geographical_object).
defprimconcept(fssKB,[],not(geographical_object),all(inverse(source),not(top))).
defprimconcept(fssKB,[],motion_by_means,some(means,top)).
defprimconcept(fssKB,[],all(means,not(top)),not(motion_by_means)).
defprimconcept(fssKB,[],some(inverse(means),top),touchable_object).
defprimconcept(fssKB,[],not(touchable_object),all(inverse(means),not(top))).
defprimconcept(fssKB,[],productive,some(result,top)).
defprimconcept(fssKB,[],all(result,not(top)),not(productive)).
defprimconcept(fssKB,[],some(inverse(result),top),thing).
defprimconcept(fssKB,[],not(thing),all(inverse(result),not(top))).
defprimconcept(fssKB,[],write,some(concerned,top)).
defprimconcept(fssKB,[],all(concerned,not(top)),not(write)).
defprimconcept(fssKB,[],some(inverse(concerned),top),thing).
defprimconcept(fssKB,[],not(thing),all(inverse(concerned),not(top))).
defprimconcept(fssKB,[],canvas,touchable_object).
defprimconcept(fssKB,[],not(touchable_object),not(canvas)).
defprimconcept(fssKB,[],repeat,action).
defprimconcept(fssKB,[],not(action),not(repeat)).
defprimconcept(fssKB,[],wiederhol,repeat).
defprimconcept(fssKB,[],not(repeat),not(wiederhol)).
defprimconcept(fssKB,[],wiederhol,lexicon).
defprimconcept(fssKB,[],not(lexicon),not(wiederhol)).
defprimconcept(fssKB,[],transaction,some(beneficative,top)).
defprimconcept(fssKB,[],all(beneficative,not(top)),not(transaction)).
defprimconcept(fssKB,[],some(inverse(beneficative),top),human).
defprimconcept(fssKB,[],not(human),all(inverse(beneficative),not(top))).
defprimconcept(fssKB,[],zahl,lexicon).
defprimconcept(fssKB,[],not(lexicon),not(zahl)).
defprimconcept(fssKB,[],zahl,transaction).
defprimconcept(fssKB,[],not(transaction),not(zahl)).
defprimconcept(fssKB,[],reason,action).
defprimconcept(fssKB,[],not(action),not(reason)).
defprimconcept(fssKB,[],verursach,lexicon).
defprimconcept(fssKB,[],not(lexicon),not(verursach)).
defprimconcept(fssKB,[],verursach,reason).
defprimconcept(fssKB,[],not(reason),not(verursach)).
defprimconcept(fssKB,[],property,predicate).
defprimconcept(fssKB,[],not(predicate),not(property)).
defprimconcept(fssKB,[],property,some(has_property,top)).
defprimconcept(fssKB,[],all(has_property,not(top)),not(property)).
defprimconcept(fssKB,[],some(inverse(has_property),top),property_filler).
defprimconcept(fssKB,[],not(property_filler),all(inverse(has_property),not(top))).
defprimconcept(fssKB,[],value_property,some(measure,top)).
defprimconcept(fssKB,[],all(measure,not(top)),not(value_property)).
defprimconcept(fssKB,[],some(inverse(measure),top),abstract_thing).
defprimconcept(fssKB,[],not(abstract_thing),all(inverse(measure),not(top))).
defprimconcept(fssKB,[],cost,some(measure,top)).
defprimconcept(fssKB,[],all(measure,not(top)),not(cost)).
defprimconcept(fssKB,[],some(inverse(measure),top),abstract_thing).
defprimconcept(fssKB,[],not(abstract_thing),all(inverse(measure),not(top))).
defprimconcept(fssKB,[],deducte,property).
defprimconcept(fssKB,[],not(property),not(deducte)).
defprimconcept(fssKB,[],absetzbar,deducte).
defprimconcept(fssKB,[],not(deducte),not(absetzbar)).
defprimconcept(fssKB,[],absetzbar,lexicon).
defprimconcept(fssKB,[],not(lexicon),not(absetzbar)).
defprimconcept(fssKB,[],sein,lexicon).
defprimconcept(fssKB,[],not(lexicon),not(sein)).
defprimconcept(fssKB,[],sein,property).
defprimconcept(fssKB,[],not(property),not(sein)).
defprimconcept(fssKB,[],possess,lexicon).
defprimconcept(fssKB,[],not(lexicon),not(possess)).
defprimconcept(fssKB,[],possess,property).
defprimconcept(fssKB,[],not(property),not(possess)).
defprimconcept(fssKB,[],haben,lexicon).
defprimconcept(fssKB,[],not(lexicon),not(haben)).
defprimconcept(fssKB,[],haben,property).
defprimconcept(fssKB,[],not(property),not(haben)).
defprimconcept(fssKB,[],concept230,haben).
defprimconcept(fssKB,[],not(haben),not(concept230)).
defprimconcept(fssKB,[],origin,adjective_property).
defprimconcept(fssKB,[],not(adjective_property),not(origin)).
defprimconcept(fssKB,[],state_q,qualitative).
defprimconcept(fssKB,[],not(qualitative),not(state_q)).
defprimconcept(fssKB,[],volitional_sq,state_q).
defprimconcept(fssKB,[],not(state_q),not(volitional_sq)).
defprimconcept(fssKB,[],physical_sq,state_q).
defprimconcept(fssKB,[],not(state_q),not(physical_sq)).
defprimconcept(fssKB,[],klein,lexicon).
defprimconcept(fssKB,[],not(lexicon),not(klein)).
defprimconcept(fssKB,[],klein,physical_sq).
defprimconcept(fssKB,[],not(physical_sq),not(klein)).
defprimconcept(fssKB,[],gross,lexicon).
defprimconcept(fssKB,[],not(lexicon),not(gross)).
defprimconcept(fssKB,[],gross,physical_sq).
defprimconcept(fssKB,[],not(physical_sq),not(gross)).
defprimconcept(fssKB,[],rot,colour).
defprimconcept(fssKB,[],not(colour),not(rot)).
defprimconcept(fssKB,[],rot,lexicon).
defprimconcept(fssKB,[],not(lexicon),not(rot)).
defprimconcept(fssKB,[],worth,quality).
defprimconcept(fssKB,[],not(quality),not(worth)).
defprimconcept(fssKB,[],voelklingen,name).
defprimconcept(fssKB,[],not(name),not(voelklingen)).
defprimconcept(fssKB,[],gi,abstract_thing).
defprimconcept(fssKB,[],not(abstract_thing),not(gi)).
defprimconcept(fssKB,[],gi,lexicon).
defprimconcept(fssKB,[],not(lexicon),not(gi)).
defprimconcept(fssKB,[],profession,abstract_thing).
defprimconcept(fssKB,[],not(abstract_thing),not(profession)).
defprimconcept(fssKB,[],schreiner,profession).
defprimconcept(fssKB,[],not(profession),not(schreiner)).
defprimconcept(fssKB,[],schreiner,lexicon).
defprimconcept(fssKB,[],not(lexicon),not(schreiner)).
defprimconcept(fssKB,[],programmer,profession).
defprimconcept(fssKB,[],not(profession),not(programmer)).
defprimconcept(fssKB,[],programmer,lexicon).
defprimconcept(fssKB,[],not(lexicon),not(programmer)).
defprimconcept(fssKB,[],action_content,abstract_thing).
defprimconcept(fssKB,[],not(abstract_thing),not(action_content)).
defprimconcept(fssKB,[],action_content,action).
defprimconcept(fssKB,[],not(action),not(action_content)).
defprimconcept(fssKB,[],motion_content,action_content).
defprimconcept(fssKB,[],not(action_content),not(motion_content)).
defprimconcept(fssKB,[],motion_content,motion).
defprimconcept(fssKB,[],not(motion),not(motion_content)).
defprimconcept(fssKB,[],motion_by_means_content,motion_by_means).
defprimconcept(fssKB,[],not(motion_by_means),not(motion_by_means_content)).
defprimconcept(fssKB,[],motion_by_means_content,action_content).
defprimconcept(fssKB,[],not(action_content),not(motion_by_means_content)).
defprimconcept(fssKB,[],cost,abstract_thing).
defprimconcept(fssKB,[],not(abstract_thing),not(cost)).
defprimconcept(fssKB,[],kosten,lexicon).
defprimconcept(fssKB,[],not(lexicon),not(kosten)).
defprimconcept(fssKB,[],kosten,cost).
defprimconcept(fssKB,[],not(cost),not(kosten)).
defprimconcept(fssKB,[],geld,lexicon).
defprimconcept(fssKB,[],not(lexicon),not(geld)).
defprimconcept(fssKB,[],geld,cost).
defprimconcept(fssKB,[],not(cost),not(geld)).
defprimconcept(fssKB,[],profession,abstract_thing).
defprimconcept(fssKB,[],not(abstract_thing),not(profession)).
defprimconcept(fssKB,[],programmer,lexicon).
defprimconcept(fssKB,[],not(lexicon),not(programmer)).
defprimconcept(fssKB,[],programmer,profession).
defprimconcept(fssKB,[],not(profession),not(programmer)).
defprimconcept(fssKB,[],tax_action,abstract_thing).
defprimconcept(fssKB,[],not(abstract_thing),not(tax_action)).
defprimconcept(fssKB,[],steuerhandlung,lexicon).
defprimconcept(fssKB,[],not(lexicon),not(steuerhandlung)).
defprimconcept(fssKB,[],steuerhandlung,tax_action).
defprimconcept(fssKB,[],not(tax_action),not(steuerhandlung)).
defprimconcept(fssKB,[],number,abstract_thing).
defprimconcept(fssKB,[],not(abstract_thing),not(number)).
defprimconcept(fssKB,[],animate,some(physis_mod,top)).
defprimconcept(fssKB,[],all(physis_mod,not(top)),not(animate)).
defprimconcept(fssKB,[],some(inverse(physis_mod),top),physical_sq).
defprimconcept(fssKB,[],not(physical_sq),all(inverse(physis_mod),not(top))).
defprimconcept(fssKB,[],frau,human).
defprimconcept(fssKB,[],not(human),not(frau)).
defprimconcept(fssKB,[],frau,lexicon).
defprimconcept(fssKB,[],not(lexicon),not(frau)).
defprimconcept(fssKB,[],sie,human).
defprimconcept(fssKB,[],not(human),not(sie)).
defprimconcept(fssKB,[],sie,lexicon).
defprimconcept(fssKB,[],not(lexicon),not(sie)).
defprimconcept(fssKB,[],sie,lexicon).
defprimconcept(fssKB,[],not(lexicon),not(sie)).
defprimconcept(fssKB,[],sie,human).
defprimconcept(fssKB,[],not(human),not(sie)).
defprimconcept(fssKB,[],person,lexicon).
defprimconcept(fssKB,[],not(lexicon),not(person)).
defprimconcept(fssKB,[],person,human).
defprimconcept(fssKB,[],not(human),not(person)).
defprimconcept(fssKB,[],plant,animate).
defprimconcept(fssKB,[],not(animate),not(plant)).
defprimconcept(fssKB,[],animal,some(volition,top)).
defprimconcept(fssKB,[],all(volition,not(top)),not(animal)).
defprimconcept(fssKB,[],some(inverse(volition),top),volitional_sq).
defprimconcept(fssKB,[],not(volitional_sq),all(inverse(volition),not(top))).
defprimconcept(fssKB,[],town,geographical_object).
defprimconcept(fssKB,[],not(geographical_object),not(town)).
defprimconcept(fssKB,[],berlin,lexicon).
defprimconcept(fssKB,[],not(lexicon),not(berlin)).
defprimconcept(fssKB,[],berlin,town).
defprimconcept(fssKB,[],not(town),not(berlin)).
defprimconcept(fssKB,[],information,inanimate).
defprimconcept(fssKB,[],not(inanimate),not(information)).
defprimconcept(fssKB,[],string,information).
defprimconcept(fssKB,[],not(information),not(string)).
defprimconcept(fssKB,[],system,human).
defprimconcept(fssKB,[],not(human),not(system)).
defprimconcept(fssKB,[],system,inanimate).
defprimconcept(fssKB,[],not(inanimate),not(system)).
defprimconcept(fssKB,[],vehicle,some(worth_mod,top)).
defprimconcept(fssKB,[],all(worth_mod,not(top)),not(vehicle)).
defprimconcept(fssKB,[],some(inverse(worth_mod),top),worth).
defprimconcept(fssKB,[],not(worth),all(inverse(worth_mod),not(top))).
defprimconcept(fssKB,[],bus,vehicle).
defprimconcept(fssKB,[],not(vehicle),not(bus)).
defprimconcept(fssKB,[],motorcycle,vehicle).
defprimconcept(fssKB,[],not(vehicle),not(motorcycle)).
defprimconcept(fssKB,[],motorcycle,lexicon).
defprimconcept(fssKB,[],not(lexicon),not(motorcycle)).
defprimconcept(fssKB,[],motorcycle,vehicle).
defprimconcept(fssKB,[],not(vehicle),not(motorcycle)).
defprimconcept(fssKB,[],motorcycle,lexicon).
defprimconcept(fssKB,[],not(lexicon),not(motorcycle)).
defprimconcept(fssKB,[],spellbook,lexicon).
defprimconcept(fssKB,[],not(lexicon),not(spellbook)).
defprimconcept(fssKB,[],spellbook,touchable_object).
defprimconcept(fssKB,[],not(touchable_object),not(spellbook)).
defprimconcept(fssKB,[],result,touchable_object).
defprimconcept(fssKB,[],not(touchable_object),not(result)).
defrole(fssKB,[],time_state,restr(time,period)).
defrole(fssKB,[],agent,restr(subject,human)).
defrole(fssKB,[],location_wohn,restr(location,geographical_object)).
defrole(fssKB,[],agent,restr(subject,human)).
defrole(fssKB,[],location_enter,restr(location,canvas)).
defrole(fssKB,[],has_property_haben,restr(has_property,thing)).
defrole(fssKB,[],quantity,restr(det,cardinal)).



assert(roleDefault(env(t4259),[],truth_mod,bot)).
assert(roleDefault(env(t4259),[],det,bot)).
assert(roleDefault(env(t4259),[],deictic_mod,bot)).
assert(roleDefault(env(t4259),[],named,bot)).
assert(roleDefault(env(t4259),[],subject,bot)).
assert(roleDefault(env(t4259),[],purpose,bot)).
assert(roleDefault(env(t4259),[],time,bot)).
assert(roleDefault(env(t4259),[],illoc,bot)).
assert(roleDefault(env(t4259),[],cause,bot)).
assert(roleDefault(env(t4259),[],result,bot)).
assert(roleDefault(env(t4259),[],location,bot)).
assert(roleDefault(env(t4259),[],time_state,bot)).
assert(roleDefault(env(t4259),[],volition,bot)).
assert(roleDefault(env(t4259),[],origin_mod,bot)).
assert(roleDefault(env(t4259),[],agent,thing)).
assert(roleDefault(env(t4259),[],location_wohn,bot)).
assert(roleDefault(env(t4259),[],colour_mod,bot)).
assert(roleDefault(env(t4259),[],relative_mod,bot)).
assert(roleDefault(env(t4259),[],material_mod,bot)).
assert(roleDefault(env(t4259),[],weight_mod,bot)).
assert(roleDefault(env(t4259),[],agent,human)).
assert(roleDefault(env(t4259),[],instrument,bot)).
assert(roleDefault(env(t4259),[],concerned,bot)).
assert(roleDefault(env(t4259),[],destination,bot)).
assert(roleDefault(env(t4259),[],source,bot)).
assert(roleDefault(env(t4259),[],means,touchable_object)).
assert(roleDefault(env(t4259),[],result,thing)).
assert(roleDefault(env(t4259),[],concerned,thing)).
assert(roleDefault(env(t4259),[],location_enter,canvas)).
assert(roleDefault(env(t4259),[],beneficative,bot)).
assert(roleDefault(env(t4259),[],has_property,bot)).
assert(roleDefault(env(t4259),[],measure,bot)).
assert(roleDefault(env(t4259),[],measure,abstract_thing)).
assert(roleDefault(env(t4259),[],has_property_haben,bot)).
assert(roleDefault(env(t4259),[],quantity,cardinal)).
assert(roleDefault(env(t4259),[],physis_mod,bot)).
assert(roleDefault(env(t4259),[],volition,bot)).
assert(roleDefault(env(t4259),[],worth_mod,bot)).
assert(roleDefNr(env(t4259),[],truth_mod,1)).
assert(roleDefNr(env(t4259),[],det,1)).
assert(roleDefNr(env(t4259),[],deictic_mod,1)).
assert(roleDefNr(env(t4259),[],named,1)).
assert(roleDefNr(env(t4259),[],subject,1)).
assert(roleDefNr(env(t4259),[],purpose,1)).
assert(roleDefNr(env(t4259),[],time,1)).
assert(roleDefNr(env(t4259),[],illoc,1)).
assert(roleDefNr(env(t4259),[],cause,1)).
assert(roleDefNr(env(t4259),[],result,1)).
assert(roleDefNr(env(t4259),[],location,1)).
assert(roleDefNr(env(t4259),[],volition,1)).
assert(roleDefNr(env(t4259),[],origin_mod,1)).
assert(roleDefNr(env(t4259),[],colour_mod,1)).
assert(roleDefNr(env(t4259),[],relative_mod,1)).
assert(roleDefNr(env(t4259),[],material_mod,1)).
assert(roleDefNr(env(t4259),[],weight_mod,1)).
assert(roleDefNr(env(t4259),[],instrument,1)).
assert(roleDefNr(env(t4259),[],concerned,1)).
assert(roleDefNr(env(t4259),[],destination,1)).
assert(roleDefNr(env(t4259),[],source,1)).
assert(roleDefNr(env(t4259),[],beneficative,1)).
assert(roleDefNr(env(t4259),[],measure,1)).
assert(roleDefNr(env(t4259),[],physis_mod,1)).
assert(roleDefNr(env(t4259),[],volition,1)).
assert(roleDefNr(env(t4259),[],worth_mod,1)).
assert(roleDomain(env(t4259),[],truth_mod,abstract_thing)).
assert(roleDomain(env(t4259),[],det,thing)).
assert(roleDomain(env(t4259),[],deictic_mod,thing)).
assert(roleDomain(env(t4259),[],named,thing)).
assert(roleDomain(env(t4259),[],subject,predicate)).
assert(roleDomain(env(t4259),[],purpose,predicate)).
assert(roleDomain(env(t4259),[],time,predicate)).
assert(roleDomain(env(t4259),[],illoc,predicate)).
assert(roleDomain(env(t4259),[],cause,predicate)).
assert(roleDomain(env(t4259),[],result,predicate)).
assert(roleDomain(env(t4259),[],location,predicate)).
assert(roleDomain(env(t4259),[],subject,concept90)).
assert(roleDomain(env(t4259),[],time_state,concept93)).
assert(roleDomain(env(t4259),[],volition,human)).
assert(roleDomain(env(t4259),[],origin_mod,geographical_object)).
assert(roleDomain(env(t4259),[],agent,concept111)).
assert(roleDomain(env(t4259),[],location_wohn,concept113)).
assert(roleDomain(env(t4259),[],colour_mod,concrete_thing)).
assert(roleDomain(env(t4259),[],relative_mod,individual)).
assert(roleDomain(env(t4259),[],material_mod,inanimate)).
assert(roleDomain(env(t4259),[],weight_mod,touchable_object)).
assert(roleDomain(env(t4259),[],agent,concept147)).
assert(roleDomain(env(t4259),[],instrument,action)).
assert(roleDomain(env(t4259),[],concerned,action)).
assert(roleDomain(env(t4259),[],destination,motion)).
assert(roleDomain(env(t4259),[],source,motion)).
assert(roleDomain(env(t4259),[],means,motion_by_means)).
assert(roleDomain(env(t4259),[],means,concept180)).
assert(roleDomain(env(t4259),[],concerned,concept186)).
assert(roleDomain(env(t4259),[],result,productive)).
assert(roleDomain(env(t4259),[],result,concept190)).
assert(roleDomain(env(t4259),[],concerned,write)).
assert(roleDomain(env(t4259),[],concerned,concept194)).
assert(roleDomain(env(t4259),[],location_enter,concept197)).
assert(roleDomain(env(t4259),[],beneficative,transaction)).
assert(roleDomain(env(t4259),[],concerned,concept209)).
assert(roleDomain(env(t4259),[],concerned,concept212)).
assert(roleDomain(env(t4259),[],has_property,property)).
assert(roleDomain(env(t4259),[],measure,value_property)).
assert(roleDomain(env(t4259),[],measure,cost)).
assert(roleDomain(env(t4259),[],measure,concept226)).
assert(roleDomain(env(t4259),[],has_property_haben,concept230)).
assert(roleDomain(env(t4259),[],quantity,concept232)).
assert(roleDomain(env(t4259),[],quantity,concept234)).
assert(roleDomain(env(t4259),[],physis_mod,animate)).
assert(roleDomain(env(t4259),[],volition,animal)).
assert(roleDomain(env(t4259),[],worth_mod,vehicle)).
assert(roleRange(env(t4259),[],truth_mod,truth_value)).
assert(roleRange(env(t4259),[],det,determiner)).
assert(roleRange(env(t4259),[],deictic_mod,pointing)).
assert(roleRange(env(t4259),[],named,name)).
assert(roleRange(env(t4259),[],subject,thing)).
assert(roleRange(env(t4259),[],purpose,predicate)).
assert(roleRange(env(t4259),[],time,time)).
assert(roleRange(env(t4259),[],illoc,speech_act)).
assert(roleRange(env(t4259),[],cause,predicate)).
assert(roleRange(env(t4259),[],result,thing)).
assert(roleRange(env(t4259),[],location,thing)).
assert(roleRange(env(t4259),[],time_state,period)).
assert(roleRange(env(t4259),[],volition,volitional_sq)).
assert(roleRange(env(t4259),[],origin_mod,origin)).
assert(roleRange(env(t4259),[],agent,human)).
assert(roleRange(env(t4259),[],location_wohn,geographical_object)).
assert(roleRange(env(t4259),[],colour_mod,colour)).
assert(roleRange(env(t4259),[],relative_mod,relation)).
assert(roleRange(env(t4259),[],material_mod,material)).
assert(roleRange(env(t4259),[],weight_mod,weight)).
assert(roleRange(env(t4259),[],agent,human)).
assert(roleRange(env(t4259),[],instrument,touchable_object)).
assert(roleRange(env(t4259),[],concerned,thing)).
assert(roleRange(env(t4259),[],destination,geographical_object)).
assert(roleRange(env(t4259),[],source,geographical_object)).
assert(roleRange(env(t4259),[],means,touchable_object)).
assert(roleRange(env(t4259),[],result,thing)).
assert(roleRange(env(t4259),[],concerned,thing)).
assert(roleRange(env(t4259),[],location_enter,canvas)).
assert(roleRange(env(t4259),[],beneficative,human)).
assert(roleRange(env(t4259),[],has_property,property_filler)).
assert(roleRange(env(t4259),[],measure,abstract_thing)).
assert(roleRange(env(t4259),[],measure,abstract_thing)).
assert(roleRange(env(t4259),[],has_property_haben,thing)).
assert(roleRange(env(t4259),[],quantity,cardinal)).
assert(roleRange(env(t4259),[],physis_mod,physical_sq)).
assert(roleRange(env(t4259),[],volition,volitional_sq)).
assert(roleRange(env(t4259),[],worth_mod,worth)).

:-retract(in_motel_kb(fssKB)).

