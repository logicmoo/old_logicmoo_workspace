/** <module> 
% ===================================================================
% File 'dbase_db_preds.pl'
% Purpose: Emulation of OpenCyc for SWI-Prolog
% Maintainer: Douglas Miles
% Contact: $Author: dmiles $@users.sourceforge.net ;
% Version: 'interface.pl' 1.0.0
% Revision:  $Revision: 1.9 $
% Revised At:   $Date: 2002/06/27 14:13:20 $
% ===================================================================
% File used as storage place for all predicates which change as
% the world is run.
%
%
% Dec 13, 2035
% Douglas Miles
*/

:- decl_mpred((
'abbreviationString-PN'/2, 
'countryName-LongForm'/2, 
'countryName-ShortForm'/2, 
abbreviationForLexicalWord/3, 
adjSemTrans/4, 
compoundString/4, 
denotation/4, 
formerName/2,
denotationRelatedTo/4, 
genFormat/3, 
genPhrase/4, 
headMedialString/5, 
initialismString/2, 
multiWordString/4, 
nameStrings/2, 
nounPrep/3, 
partOfSpeech/3, 
preferredGenUnit/3, 
preferredNameString/2, 
prepCollocation/3, 
scientificName/2, 
verbSemTrans/4, 
infinitive/4, 
'termStrings-GuessedFromName'/2)).

:- registerCycPredPlus2([
'abbreviationForCompoundString'/6,
'abbreviationForLexicalWord'/5,
'abbreviationForMultiWordString'/6,
'abbreviationForString'/4,
'abbreviationString-PN'/4,
'abnormal'/4,
'acronymString'/4,
'actionExpressesFeelingToward'/5,
'actionViolatesObligation'/4,
'adjacentTo'/4,
'adjSemTrans'/6,
'adjSemTrans-Restricted'/7,
'adjSemTransTemplate'/5,
'affiliatedWith'/4,
'affixRuleArity'/4,
'affixRuleCategorialConstraint'/4,
'affixRuleTypeMorphemePosition'/5,
'affixSemantics'/4,
'agentive-Mass'/4,
'agentive-Pl'/4,
'agentive-Sg'/4,
'agentiveNounSemTrans'/6,
'agreeingAgents'/4,
'algorithmStartStep'/4,
'allies'/4,
'alternateRouteFromThrough'/6,
'altitudeAnglePredicate'/4,
'analogousFeelings'/4,
'anatomicalParts'/4,
'areaOfRegion'/4,
'arg1Format'/4,
'arg1Genl'/4,
'arg1Isa'/4,
'arg2Format'/4,
'arg2Genl'/4,
'arg2Isa'/4,
'arg3Format'/4,
'arg3Genl'/4,
'arg3Isa'/4,
'arg4Format'/4,
'arg4Genl'/4,
'arg4Isa'/4,
'arg5Format'/4,
'arg5Genl'/4,
'arg5Isa'/4,
'arg6Format'/4,
'arg6Isa'/4,
'argAdmittanceTestedDuringTransitiveViaInference'/6,
'argAndRestIsa'/5,
'argFormat'/5,
'argGenl'/5,
'argIsa'/5,
'argsIsa'/4,
'arity'/4,
'arityMax'/4,
'arityMin'/4,
'assertionTimeOfMicrotheory'/4,
'assertTemplate-Reln'/6,
'azimuthAnglePredicate'/4,
'backchainForbidden'/3,
'backchainRequired'/3,
'barLevelOfPhraseType'/4,
'baseForm'/4,
'basicSpeechPartPred'/4,
'behaviorCapable'/5,
'beliefs'/4,
'beneficiary'/4,
'betweenCyc'/5,
'bogusSpeechPart'/3,
'bordersOn'/4,
'budgetExpenditureFractionOfGDP'/6,
'budgetExpenditures'/6,
'canBop'/4,
'capitalCity'/4,
'cardinality'/4,
'casualtyCount'/4,
'causes-PropProp'/4,
'causes-SitProp'/4,
'chiefPorts'/4,
'citizens'/4,
'coExtensional'/4,
'collectionBackchainEncouraged'/3,
'collectionIntersection'/4,
'collectionUnion'/4,
'comment'/4,
'commutativeInArgs'/5,
'commutativeInArgsAndRest'/4,
'comparativeAdverb'/4,
'comparativeDegree'/4,
'completeCollectionExtent'/3,
'completeExtentKnown'/3,
'compoundSemTrans'/7,
'compoundString'/6,
'compoundStringDenotesArgInReln'/7,
'compoundVerbSemTrans'/6,
'conceptuallyRelated'/4,
'conditionalProbability'/5,
'conditionalProbabilitySet'/5,
'considersAsEnemy'/4,
'constrainsArg'/4,
'consumptionAmountDuring'/6,
'consumptionCapacityDuring'/6,
'containsInformation'/4,
'contiguousAfter'/4,
'contradictoryPreds'/4,
'contraryFeelings'/4,
'contrastedFeelings'/4,
'controls'/4,
'correspondingPreds-Capability'/4,
'countryCodeDigraph'/4,
'countryName-LocalLongForm'/4,
'countryName-LocalShortForm'/4,
'countryName-LongForm'/4,
'countryName-ShortForm'/4,
'covering'/4,
'currencyOf'/4,
'currentAccountBalanceDuring'/5,
'customers'/4,
'cyclistNotes'/4,
'damages'/4,
'dateOfEvent'/4,
'deathToll'/5,
'decontextualizedCollection'/3,
'decontextualizedCollectionConventionMt'/4,
'decontextualizedPredicate'/3,
'decontextualizedPredicateConventionMt'/4,
'decreasesCausally'/5,
'defaultCorrespondingRoles'/4,
'defaultReformulationDirectionInModeForPred'/5,
'defenseBudgetExpenditures'/4,
'definingMt'/4,
'definingTimeUnit'/4,
'defnIff'/4,
'defnSufficient'/4,
'deliberateActors'/4,
'denotation'/6,
'denotationPlaceholder'/6,
'denotationRelatedTo'/6,
'denotatumArg'/4,
'denotesArgInReln'/6,
'derivationalAffixBasePOS'/4,
'derivationalAffixResultPOS'/4,
'derivedProbability'/4,
'derivedProbability-Range'/4,
'derivedUsingPrefix'/4,
'derivedUsingSuffix'/4,
'desires'/4,
'determinerAgreement'/4,
'deviceUsed'/4,
'different'/4,
'directingAgent'/4,
'disjointWith'/4,
'distanceAboveSeaLevel'/4,
'distanceBetween'/5,
'domainAssumptions'/4,
'doneBy'/4,
'driverActor'/4,
'duration'/4,
'eastOf'/4,
'elInverse'/4,
'emptiesInto'/4,
'endingDate'/4,
'endingPoint'/4,
'endsAfterEndingOf'/4,
'enforcingAgent'/4,
'englishGloss'/4,
'equals'/4,
'etymologicalVariantOfSuffix'/5,
'evaluate'/4,
'evaluationDefn'/4,
'eventOccursAt'/4,
'exceptFor'/4,
'exceptWhen'/4,
'exchangeRateDuring'/6,
'exchangeRateDuring-Market'/6,
'exchangeRateDuring-Official'/6,
'executableProgramName'/4,
'expansion'/4,
'expansionAxiom'/4,
'expansionDefn'/4,
'expertRegarding'/4,
'exportAmountDuring'/6,
'exportCapacityDuring'/6,
'exportDestinationFractionDuring'/6,
'exportRate'/5,
'exportRateThrough'/6,
'exportRevenueFractionDuring'/6,
'exports'/4,
'exportsThrough'/5,
'exportThroughAmountDuring'/7,
'extent'/4,
'facets-Generic'/4,
'facets-Partition'/4,
'facets-Strict'/4,
'fanOutArg'/4,
'fertilityRate'/4,
'firstPersonSg-Present'/4,
'firstSubEvents'/4,
'flowCapacity'/4,
'followingIntervalType'/4,
'followingValue'/4,
'formalityOfWS'/6,
'formalityOfWS-New'/4,
'formationAuthorizedBy'/4,
'formedByConfluenceOf'/4,
'formerName'/4,
'frequencyOfActionType'/6,
'functionalInArgs'/4,
'functionCommutesWith'/4,
'functionCorrespondingPredicate'/5,
'functionCorrespondingPredicate-Canonical'/5,
'functionCorrespondingPredicate-Generic'/5,
'genCodeSupport'/3,
'generalSemantics'/4,
'generateArgWithOutsideScope'/4,
'generateQuantOverArg'/5,
'genExpansion'/4,
'genFormat'/5,
'genFormat-ArgFixed'/7,
'genFormat-NP'/5,
'genFormat-Precise'/5,
'genKeyword'/4,
'genlAttributes'/4,
'genlFuncs'/4,
'genlInverse'/4,
'genlMt'/4,
'genlMt-Vocabulary'/4,
'genlPreds'/4,
'genls'/4,
'genMassNoun'/3,
'genNatTerm-ArgLast'/5,
'genNatTerm-compoundString'/7,
'genNatTerm-multiWordString'/7,
'genPhrase'/6,
'genPreferredKeyword'/4,
'genQuestion'/6,
'genStringAssertion'/4,
'genStringAssertion-Old'/3,
'genStringAssertion-Precise'/4,
'genTemplate'/4,
'genTemplate-Constrained'/5,
'genWithGloss'/3,
'geographicalSubRegions'/4,
'geopoliticalSubdivision'/4,
'givesSupportToAgent'/5,
'goalCategoryForAgent'/5,
'goals'/4,
'governmentType'/4,
'granuleOfStuff'/4,
'greaterThanOrEqualTo'/4,
'grossDomesticProduct'/5,
'grossDomesticProduct-Nominal'/5,
'grossDomesticProduct-Slot'/4,
'grossNationalProduct'/5,
'groupCardinality'/4,
'groupMembers'/4,
'groupMemberType'/4,
'hasAgents'/4,
'hasBeliefSystems'/4,
'hasClimateType'/4,
'hasHeadquartersInCountry'/4,
'hasLeaders'/4,
'hasMembers'/4,
'hasOwnershipIn'/4,
'hasSequentialProgramSteps'/5,
'hasStatusWithAgent'/5,
'headMedialString'/7,
'headsPhraseOfType'/4,
'holdsIn'/4,
'hyphenString'/6,
'implies'/4,
'importAmountDuring'/6,
'importanceOfThingInSet'/5,
'importCapacityDuring'/6,
'importExpenditureFractionDuring'/6,
'importFromAmountDuring'/7,
'importFromThroughAmountDuring'/8,
'importOriginFractionDuring'/6,
'importRate'/5,
'importRateFrom'/6,
'imports'/4,
'importsFrom'/5,
'importsThrough'/5,
'importThroughAmountDuring'/7,
'increasesCausally'/5,
'independentArg'/4,
'industryFacilities'/4,
'industryFractionOfGDP'/6,
'industryProduces'/4,
'infinitive'/4,
'inflationRateDuring'/5,
'infoTransferred'/4,
'inhabitantTypes'/4,
'initialismString'/4,
'initialParameterValue'/4,
'inputsDestroyed'/4,
'inReactionTo'/4,
'localityOfObject'/4,
'instanceElementType'/4,
'instancesDontNeedLexification'/3,
'instrument-Generic'/4,
'intangibleParts'/4,
'integerRange'/4,
'intendedBehaviorCapable'/5,
'interArg1ResultGenls'/5,
'interArg1ResultIsa'/5,
'interArg2ResultIsa'/5,
'interArgCardinality'/7,
'interArgDifferent'/5,
'interArgFormat1-1'/5,
'interArgFormat1-2'/5,
'interArgFormat2-2'/5,
'interArgGenl2-1'/5,
'interArgIsa1-2'/5,
'interArgIsa1-3'/5,
'interArgIsa2-1'/5,
'interArgIsa3-4'/5,
'interArgIsa4-5'/5,
'interArgReln'/6,
'interArgReln1-2'/4,
'interArgReln1-3'/4,
'interArgReln1-4'/4,
'interArgReln2-1'/4,
'interArgReln2-3'/4,
'interArgReln2-4'/4,
'interArgReln3-1'/4,
'interArgReln3-2'/4,
'interArgReln3-4'/4,
'interArgResultGenl'/6,
'interArgResultIsa'/6,
'interArgResultReln'/5,
'internationalMonetaryReservesDuring'/5,
'internationalOrg-MemberCountry'/4,
'interResultArgReln'/5,
'intersectsIntervalType'/4,
'intervalStartedBy'/4,
'inverseFunc'/4,
'isa'/4,
'jurisdictionRegion'/4,
'keClarifyingCollection'/3,
'keCommonQueryPredForInstances'/4,
'keConsiderationInverse'/4,
'keConsiderationPreds'/4,
'keGenlsConsiderationInverse'/4,
'keGenlsConsiderationPreds'/4,
'keGenlsStrongSuggestionPreds'/4,
'keGenlsWeakSuggestionInverse'/4,
'keGenlsWeakSuggestionPreds'/4,
'kePredArgStrongSuggestionPreds'/5,
'kePredArgWeakSuggestionPreds'/5,
'keRequirementPreds'/4,
'keStrongConsiderationInverse'/4,
'keStrongConsiderationPreds'/4,
'keStrongSuggestion'/4,
'keStrongSuggestionInverse'/4,
'keStrongSuggestionPreds'/4,
'keWeakSuggestionInverse'/4,
'keWeakSuggestionPreds'/4,
'knows'/4,
'laborForceDuring'/5,
'laborForceFractionDuring'/6,
'languageOfLexicon'/4,
'languagesSpokenHere'/4,
'laterThan'/4,
'latitude'/4,
'lengthOfObject'/4,
'lengthOfPathTypeInRegion'/5,
'lessLikelyThan-Prior'/4,
'lexicalWordTypeForLanguage'/4,
'lightVerb-TransitiveSemTrans'/5,
'linksOfCustomarySystem'/4,
'listSetMembers'/4,
'literacyRateForGroupInRegion'/5,
'longitude'/4,
'majorReligions'/4,
'maleficiary'/4,
'massNounSemTrans'/6,
'massNumber'/4,
'memberStatusInOrganization'/5,
'microtheoryDesignationArgnum'/4,
'minimize'/3,
'minimizeExtent'/3,
'modalInArg'/4,
'morphologicalComposition'/5,
'morphologicallyDerivedFrom'/4,
'mtInferenceFunction'/4,
'multiplicationUnits'/5,
'multiWordSemTrans'/7,
'multiWordString'/6,
'multiWordStringDenotesArgInReln'/7,
'nameOfAgent'/4,
'nameStrings'/4,
'nationalBudgetExpenditures'/4,
'nationalLanguage'/4,
'naturalResourcesInRegion'/4,
'ncRuleConstraint'/4,
'ncRuleLabel'/4,
'ncRuleTemplate'/4,
'near'/4,
'negationAttribute'/4,
'negationInverse'/4,
'negationPreds'/4,
'negativeVestedInterest'/4,
'nicknames'/4,
'nlPhraseTypeForTemplateCategory'/4,
'no-GenQuant'/4,
'nonCompositionalVerbSemTrans'/5,
'nonGradableAdjectiveForm'/4,
'nonThirdSg-Present'/4,
'northeastOf'/4,
'northOf'/4,
'northwestOf'/4,
% 'not'/3,
'notAssertible'/3,
'notAssertibleCollection'/3,
'notAssertibleMt'/3,
'nounPrep'/5,
'nounSemTrans'/6,
'nthLargestElement'/6,
'numInhabitants'/4,
'objectActedOn'/4,
'objectFoundInLocation'/4,
'obligatedAgent'/4,
'obligationParts'/4,
'occurrencesPerPeriod'/5,
'officialArmedForces'/4,
'oldConstantName'/4,
'opaqueArgument'/4,
'opponents'/4,
'opponentsInConflict'/5,
'oppositeAttributeValue'/4,
'oppositeDirection-Precise'/4,
'or'/4,
'overrides'/4,
'owns'/4,
'paraphraseCoercionAllowedFrom'/4,
'partitionedInto'/4,
'partOfSpeech'/5,
'pastTense-Universal'/4,
'pathBetween'/5,
'pathConnects'/5,
'pathFromToInSystem'/6,
'pathTerminus'/4,
'perfect'/4,
'performedBy'/4,
'performsInsAtLocation'/5,
'perpendicularVectors'/4,
'phoneticVariantOfPrefix'/5,
'phoneticVariantOfSuffix'/5,
'phraseTemplateArg'/4,
'physicalPartTypes'/4,
'placeName-ShortForm'/4,
'plural'/4,
'pluralVerb-Present'/4,
'pnMassNumber'/4,
'pnPlural'/4,
'pnSingular'/4,
'politenessOfWS'/6,
'populationDuring'/5,
'populationGrowthRate'/4,
'posBaseForms'/4,
'posForms'/4,
'posForTemplateCategory'/4,
'positiveVestedInterest'/4,
'posOfPhraseType'/4,
'posPredForTemplateCategory'/4,
'power-Military'/4,
'predicateForAction'/4,
'preferredGenUnit'/5,
'preferredNameString'/4,
'preferredTermStrings'/4,
'prefixString'/4,
'prepCollocation'/5,
'prepReln-Action'/6,
'prepReln-Object'/6,
'prepSemTrans'/6,
'presentParticiple'/4,
'presentTense-Universal'/4,
'preservesGenlsInArg'/4,
'prettyName'/4,
'primaryFunction'/5,
'priorProbability'/4,
'priorProbability-Range'/4,
'productionAmountDuring'/6,
'productionCapacity'/5,
'productionCapacityDuring'/6,
'productionQuotaDuring'/6,
'productionRateOfRegion'/5,
'productionValueOfIndustryDuring'/6,
'programAlgorithmInputs'/4,
'programAlgorithmInputs'/5,
'programAlgorithmInternals'/4,
'programAlgorithmOutputs'/4,
'programExpressionHasType'/4,
'programFunctionArity'/4,
'programFunctionIdentifier'/4,
'programFunctionOperator'/4,
'programIfConditionThenElse'/6,
'programObjectTypeRepresents'/4,
'programStrings'/4,
'programTypeStrings'/4,
'programWhileConditionDo'/5,
'properNounSemTrans'/6,
'psRuleArity'/4,
'psRuleCategory'/4,
'psRuleConstraint'/4,
'psRuleExample'/4,
'psRuleSemanticsFromDtr'/4,
'psRuleSemanticsHandler'/4,
'psRuleSyntacticHeadDtr'/4,
'psRuleTemplateBindings'/4,
'psRuleTemplateDtr'/4,
'purchaseFromFractionDuring'/7,
'purposeInEvent'/5,
'quotedArgument'/4,
'quotedCollection'/3,
'realGDPGrowthRateDuring'/5,
'realGNPGrowthRateDuring'/5,
'recipientOfInfo'/4,
'reformulationPrecondition'/5,
'reformulatorEquals'/4,
'reformulatorEquiv'/4,
'regionHasTransportMeans'/4,
'regionLacksTransportMeans'/4,
'regularAdverb'/4,
'regularDegree'/4,
'regularSuffix'/5,
'relatedArgPositions'/5,
'relationAll'/4,
'relationAllExists'/5,
'relationAllExistsCount'/6,
'relationAllExistsMany'/5,
'relationAllExistsMax'/6,
'relationAllExistsMin'/6,
'relationAllInstance'/5,
'relationExistsAll'/5,
'relationExistsAllMany'/5,
'relationExistsCountAll'/6,
'relationExistsInstance'/5,
'relationExistsMaxAll'/6,
'relationIndicators'/5,
'relationIndicators-Strong'/5,
'relationInstanceAll'/5,
'relationInstanceExists'/5,
'relationInstanceExistsCount'/6,
'relationInstanceExistsMany'/5,
'relationInstanceExistsMax'/6,
'relationInstanceExistsMin'/6,
'reliabilityOfMicrotheory'/4,
'requiredActorSlots'/4,
'requiredArg1Pred'/4,
'requiredArg2Pred'/4,
'residenceOfOrganization'/4,
'resultGenl'/4,
'resultGenlArg'/4,
'resultIsa'/4,
'resultIsaArg'/4,
'resultIsaArgIsa'/4,
'revenueFromProduct'/5,
'rewriteOf'/4,
'rolesForEventType'/4,
'saleToFractionDuring'/7,
'salientAssertions'/4,
'scientificName'/4,
'scopingArg'/4,
'secondPersonSg-Present'/4,
'sellsProductType'/4,
'semTransArg'/4,
'semTransPredForPOS'/4,
'senderOfInfo'/4,
'sentenceDesignationArgnum'/4,
'sharedNotes'/4,
'shortTimeIntervalAfter'/4,
'siblingDisjointExceptions'/4,
'singular'/4,
'skillRequired'/6,
'socialParticipants'/4,
'softwareParameterDomain'/4,
'softwareParameterHasType'/4,
'spatiallyIntersects'/4,
'spatiallyIntrinsicArg'/4,
'spatiallySubsumes'/4,
'speechPartPreds'/4,
'startingDate'/4,
'startingPoint'/4,
'startsAfterEndingOf'/4,
'startsAfterStartingOf'/4,
'startsDuring'/4,
'statementOfPurpose'/4,
'subBeliefSystem'/4,
'subcatFrame'/6,
'subcatFrameArity'/4,
'subcatFrameDependentConstraint'/5,
'subcatFrameDependentKeyword'/5,
'subcatFrameExample'/4,
'subcatFrameKeywords'/4,
'subEvents'/4,
'subEventType'/4,
'subEventTypes'/4,
'subGroups'/4,
'subIndustries'/4,
'subjectRoles'/4,
'subOrganizations'/4,
'subsumesIntervalType'/4,
'suffixString'/4,
'suffrageAge'/4,
'superlativeAdverb'/4,
'superlativeDegree'/4,
'superTaxons'/4,
'suppliedWithFrom'/5,
'supplyFromThroughAmountDuring'/8,
'supplyThroughAmountDuring'/7,
'surroundsHorizontally'/4,
'synonymousExternalConcept'/5,
'temporalBoundsContain'/4,
'temporallyCooriginating'/4,
'temporallyCoterminal'/4,
'temporallyIntrinsicArg'/4,
'temporallyStartedBy'/4,
'temporallySubsumes'/4,
'termDoesntNeedLexification'/3,
'termPOS-Strings'/5,
'termStrings'/4,
'termStrings-GuessedFromName'/4,
'territoriesControlled'/4,
'thereExistAtLeast'/5,
'thereExistExactly'/5,
'thereExists'/4,
'thirdPersonSg-Present'/4,
'timeIntervalBetween'/5,
'toBeReviewedBy'/4,
'topicOfIndividual'/4,
'topicOfInfoTransfer'/4,
'totalBudgetExpenditures'/5,
'totalReserves'/5,
'tradeBalanceDuring'/6,
'transitiveViaArg'/5,
'transitiveViaArgInverse'/5,
'transportedInTypes'/4,
'transportees'/4,
'transportFacilityFor'/4,
'trueRule'/4,
'typeBehaviorCapable'/5,
'typedGenlInverse'/4,
'typedGenlPreds'/4,
'typeGenls'/4,
'typeLevelVersionInArg'/7,
'unemploymentRateDuring'/5,
'uniquePartTypes'/4,
'unitExpansions'/4,
'unitMultiplicationFactor'/5,
'unitOfMeasurePrefixString'/4,
'useReformulationRuleForQuantifierProcessing'/3,
'variantOfSuffix'/4,
'verbPrep-Passive'/5,
'verbPrep-Transitive'/5,
'verbPrep-TransitiveTemplate'/5,
'verbSemTrans'/6,
'verbSemTransPartial'/6,
'verbSemTransTemplate'/5,
'victim'/4,
'widthOfObject'/4,
'wnAdjectiveParticiple'/6,
'wnAdjectivePertains'/6,
'wnAntonymous'/6,
'wnAttribute'/4,
'wnCauses'/4,
'wnEntailment'/4,
'wnFollowsInMeaning'/6,
'wnHypernym'/4,
'wnMemberMeronym'/4,
'wnPartMeronym'/4,
'wnS'/8,
'wnSimilarInMeaning'/4,
'wnSubstanceMeronym'/4,
'wnVerbsSimilarInMeaning'/4,
'wordInLanguage'/4,
'wornOn-TypeType'/4
]).

