---
jupyter:
  jupytext:
    formats: ipynb,md
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.3'
      jupytext_version: 1.17.2
  kernelspec:
    display_name: R
    language: R
    name: ir
---

<!-- #region tags=["title"] -->
# The Text Analysis Prototype for Galileo's Library and Letters Online: GaLiLeO
<!-- #endregion -->

<!-- #region tags=["contributor"] -->
 ### Crystal Hall [![0000-0003-1324-0364](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0003-1324-0364)
Bowdoin College
<!-- #endregion -->

<!-- #region tags=["copyright"] -->
[![cc-by-nc-nd](https://licensebuttons.net/l/by-nc-nd/4.0/88x31.png)](https://creativecommons.org/licenses/by-nc-nd/4.0/)
© Crystal Hall. Published by De Gruyter in cooperation with the University of Luxembourg Centre for Contemporary and Digital History. This is an Open Access article distributed under the terms of the [Creative Commons Attribution License CC BY-NC-ND](https://creativecommons.org/licenses/by-nc-nd/4.0/)

<!-- #endregion -->

```R jdh={"object": {"source": ["Image created by DALL\u00b7E 2023-03-22 10.55.28 - a photograph of parchment-bound books on shelves in an old library like the Laurentiana", "No known copyright restrictions"]}} tags=["cover"] vscode={"languageId": "r"}
library("IRdisplay")
display_png(file="./media/CoverImage.png")
```

<!-- #region tags=["disclaimer"] -->
This article is the author's report on a collaborative project, which currently exists as a prototype that was presented to a small group of subject experts in September 2018. The article, with permission, makes use of the author's contributions to a presentation made at that prototype demonstration workshop with collaborator Hannah Marcus, Historian of Science at Harvard University. Where Marcus' work has focused on metadata and a scholarly editorial apparatus for correspondence to and from Galileo Galilei, this article takes as its object of evaluation the code written in R to explore and contextualize the texts, including the letters, but also books written by Galileo and those that he owned. Portions of this article appeared for a time on the author's personal website, but have now been removed.
<!-- #endregion -->

<!-- #region tags=["keywords"] -->
text analysis, history of science, digital archives, corpus creation, Galileo Galilei
<!-- #endregion -->

<!-- #region tags=["abstract"] -->
This article reports on a prototype digital laboratory of tools for the discovery of interpretative pathways through historical materials related to Galileo Galilei (1563-1642). GaLiLeO: Galileo's Library and Letters Online allows a user to contextualize a document or term within a broader corpus of personal and semi-public letters, prefatory letters, and book-length texts from Galileo's library. Given three features of the tool set and corpus, the article argues for a third digital, analytical space between the digital archive and a corpus used for computational analysis. First, the code for GaLiLeO was developed in 2016-2018 based on specific modeling principles from Digital Humanities that are now several years old and merit re-contextualization within shifts and DH and adjacent fields (<cite data-cite="1584927/PVFRKDSE"></cite>,<cite data-cite="1584927/4JAXCGB8"></cite>). Second, the tools for exploration, question making, and question answering in GaLiLeO do not aim for corpus-scale descriptive models or interpretations, but rather to highlight documents of interest for historians and literary scholars working outside DH with humanistic methods of document selection and interpretation rather than those offered by text mining, computational linguistics, and data science. Finally, the project is unfinished and based on an incomplete corpus, but has nonetheless yielded research results because of the tools' focus on identification of pathways of a few potentially related documents, not corpus-wide patterns. By avoiding corpus-level declarations, the preliminary computational tools in GaLiLeO represent a prototype for emphasizing relationships across documents that may have resisted or otherwise been excluded from the organizational logic of (digital) archival and other post-hoc metadata.
<!-- #endregion -->

## Project History and Contextualization

<!-- #region tags=["narrative"] -->
This article engages with questions related to the usefulness of an unfinished, yet entirely functional, project that was designed to be experimental and iterative in recognition of its incomplete corpus of documents and their condition. Galileo's Library and Letters Online (GaLiLeO) was developed to start a conversation about the characteristics of new digital tools in the interdisciplinary field of Galileo Studies. The GaLiLeO prototype tools and the process of their creation offered a way to brainstorm about a future larger-scale project, work with a cohort of experts in various areas of 17th-century Italian culture, and draft new digital and computational analytical tools alongside scholarly editorial apparati. The GaLiLeO team's enthusiasm and imagination quickly outpaced the resources of time and funding. Feedback on a 2017 proposal for a Digital Humanities Advancement Grant through the National Endowment for the Humanities in the United States (<cite data-cite="1584927/B5Q585LU"></cite>) pointed to ways to scale back the initial scope to a proof-of-concept for the combined text analysis of the two corpora and their metadata, working with materials at hand to focus more on method. The audience for the prototype of this tool suite was a group of content specialists that do not consider themselves digital humanists, but are historians and literary scholars in search of tools for meaningful exploration of large digitized archives and primary materials related to Galileo Galilei (1543-1642).
<!-- #endregion -->

<!-- #region tags=["narrative"] -->
Although digitized resources related to Galileo are plentiful, computational and quantitative means of navigating the materials are not. The largest digital resource of texts for Galileo specialists is the galileo//thek@ (Galileoteca) developed through 2016 and maintained by the Galileo Museum in Florence, Italy (<cite data-cite="1584927/K7RFDQH5"></cite>). The Galileoteca provides access to scans of primary documents, scholarly editions, and selected secondary scholarship alongside explanatory materials related to the Museum's holdings. A subset of manuscripts are searchable by their shelfmarks within the Galileian manuscripts at the National Central Library of Florence, a person or place name, dates, and words in titles or incipits. A second digital layer offers access to OCR from scans of the documents included in the late-19th century National Edition of Galileo's works and correspondence compiled by Antonio Favaro (1847-1922) and his team of collaborators (<cite data-cite="1584927/XYL4T68J"></cite>). These 20 volumes, now supplemented with appendices recently edited by Galileo experts, represent a corpus too large to memorize and disorienting to read in a linear fashion. Long texts (including some letters) are included in thematic volumes, all other letters by date. Scans and transcriptions of documents are organized according to their location in the national edition and the digitized text reflects Favaro's editorial interventions, most often in materials written by Galileo, rarely in texts authored by others. The excellent curatorial and editorial team at the Museo Galileo has also added other interpretive layers to the digital interface to help visitors find appropriate documents easily through a searchable critical lexicon.
<!-- #endregion -->

This kind of resource requires the user to have details about the documents' creation or contents prior to beginning a search. In the Galileoteca, specialists who know what person or document they want to find, those who are studying a chronological period in Galileo's lifetime, or have a thematic or topical research question in mind can use the resources to access related materials. Users can search word forms and lemmas within certain areas of this digital archive or across eleven kinds of materials that also include biographies, indices, and iconography. It is an excellent finding aid for those who already know the specific text(s) they seek and can navigate the organizational logic of the manuscripts or the national edition. This digital archive has successfully remediated the structures that have made these documents findable while adding the functionality of keyword searching in metadata and any machine-readable texts.


At the same time, the collection of documents is extensive and scholars continue to discover new features that broaden understandings of Galileo and his contemporaries even without a corpus-level computational study of the contents. These mutually compatible aspects of Galileo Studies, that is, the continued interest in small-scale patterns and the possibilities for larger-scale analysis, sparked two digital projects that evolved separately, but simultaneously until 2016: developing an editorial apparatus for Galileo's correspondence based on close reading of the available letters and creating a digital and computational library of the books that Galileo owned. From the perspective of History of Science, Hannah Marcus had worked with a team of scholars to identify thematic overlap in the surviving correspondence related to Galileo. Part of that project also involved careful attention to metadata about the letters, which has resulted in new findings (<cite data-cite="1584927/5R7T42AP"></cite>). When the project leaders met in April 2016 at Stanford University, the points of connection and similar goals of the two collaborative efforts coalesced around two concerns: not repeating existing resources and establishing research outcomes while the larger projects unfolded. Neither corpus was complete, nor may they ever be definitive, but the expanded access they provide is fertile territory for new investigation - with the right tools.

<!-- #region tags=["narrative"] -->
Galileo's Library and Letters Online derives its title from this tension in its identity. Naming credit goes to Hannah Marcus and Morgan MacLeod after much discussion about what this project would be. The creators struggled with the identity of the hybrid tools-text nature of the platform. The tools were not meant to create a digital archive, which would emphasize findability and display a range of related material, a role already filled by the Galileoteca. The aspirational goal was similar to the ARTFL Encyclopédie (<cite data-cite="1584927/DMRYV5NK"></cite>), but the projects were being developed by the two PIs and a few rotating graduate and undergraduate students without dedicated funding or broad technical support. Even though Marcus' team had created a rigorous and extensive scholarly interpretive layer for the correspondence, a digital edition would have implied a single organization and interpretation of the texts. Using the vague "online" descriptor avoided these problems of identity. It gestures toward actions of aggregation, exploration, and experimentation that are enabled by the web. While bringing together plain, full text of the letters and limited contents from the library would create bridges across otherwise siloed resources, the immediate aim was not to make a claim about a collection, but to evaluate the connections found between and across the texts of which it was composed as it grew.
<!-- #endregion -->

This short term goal shaped design in a way that links traditional humanistic study of primary materials with the outcomes of larger-scale analyses using methods from Digital Humanities, data science, and computational linguistics. Because of the iterative nature of the corpus development (described in more detail in [Preliminary Corpus for Data Development](#anchor-preliminary-corpus)), the tools ultimately needed to suggest pathways, not patterns. That is, quantitative and graphical results could not be the end in themselves, they were designed to surface small subsections of the corpus with potential relationships. The tools needed to be designed in such a way as to facilitate contextualization, comparison, and expansion of points of entry into the primary sources, keeping in mind students new to the historical material and peer scholars outside the Digital Humanities looking for a way to investigate their own texts. While the corpus may be of interest for large scale study, the audience for the tools was colleagues who conduct traditional historical and literary interpretations of primary sources. GaLiLeO aimed to provide an alternative entry point to the corpus of Galileian materials for posing contextualized questions about individual documents or authors through computation.


This article will evaluate the extent to which the digital and computational tools in GaLiLeO point to small-scale interpretive pathways through a corpus (the realm of non-digital humanists) rather than declare a quantitative definition of an aspect of a corpus for interpretation (which is often the aim of DH tools, methods, and research questions).


## Method for Tool Development


The tools were developed most intensively in 2016-2018, at a particular moment in the expansion and seemingly perpetual redefinition of the field of Digital Humanities, including digital history and computational literary studies. On the one hand, communities of stylometric experts were working to develop more accurate tools for classification (<cite data-cite="1584927/87L9ASGN"></cite>; <cite data-cite="1584927/ZBM62GSI"></cite>; <cite data-cite="1584927/VME52UHN"></cite>) and topic modeling was being applied to economic history (<cite data-cite="1584927/WCHBNS28"></cite>) and the history of biology (<cite data-cite="1584927/WKT379WY"></cite>). On the other hand, these were also the years that culminated in Nan Z. Da's polemical critique of methods and reproducibility in the field (<cite data-cite="1584927/87HUD89D"></cite>), Katherine Bode's call for an articulation of the constructedness of corpora (<cite data-cite="1584927/MZMUE8HY"></cite>), and greater visibility for the gaps, silences, and situatedness of archives and methods for their computational study (<cite data-cite="1584927/Y3VEU6AM"></cite>; <cite data-cite="1584927/R2JTQWFH"></cite>). Taken together, this meant developing a suite of tools that incorporated features from both sets of trends in the field in pursuit of small-scale inquiry in a large corpus.


Non-digital historical and literary methods often involve making a selection from heterogeneous sets of primary materials that have been organized by their authors, archives, libraries, and editors. (See the left side of [figure below](#anchor-galileocontext).) That selection can be based on biographical (chronological), thematic, or lexical similarities or differences, but the features of what drive that selection were of interest for tool development in GaLiLeO. The choice of terms, themes, or historic moments can be driven by pre-established notable names, dates, and concepts for which existing tools like the Galileoteca are well suited. Yet, new discoveries also arise from a specialist noticing something unusual, witnessing variety, or recognizing an absence (among other possibilities). In a large corpus of thousands of documents, absence and anomaly are much harder to detect than in one main text or dozens of letters. This is where computational methods can assist, although many of the existing tools during GaLiLeO's development had other aims.


The grey box in the figure below offers an overview of a typical workflow for computational study of a textual corpus. While sharing a similar starting point with other humanistic inquiry, the data carpentry and digital humanistic processes begin with potential outputs in mind, which shape how the texts are organized and what data is created from them. Coding textbooks for humanists model this approach (<cite data-cite="1584927/U3L2U4N5"></cite>; <cite data-cite="1584927/HD8S7YPS"></cite>; <cite data-cite="1584927/DRI292Q5"></cite>). A research question such as "How did early modern intellectual academies engage with the telescope in letters to Galileo?" could then prompt organization by the academy in which the author participated, creation of bag-of-words tables of word counts, and then stylometric modeling (among other ways to explore this idea). A parallel question that does not require digital methods for interpretation would be "What significance can be derived from an individual's departure from their academy's style of engagement with the telescope in letters to Galileo?" Again, specialist knowledge could determine the person and the academy due to previously-established notoriety, but that forecloses opportunities to engage with the lesser-studied or unstudied documents in the corpus. The scale is nonetheless overwhelming: With dozens of academies and hundreds of authors to choose from, where might a scholar begin?

```R jdh={"object": {"source": ["GaLiLeO context diagram", "No copyright restrictions."]}} tags=["figure-galileocontext-*", "anchor-galileocontext"] vscode={"languageId": "r"}
display_png(file="./media/GaLiLeOContextDiagram.png")
```

<!-- #region tags=["narrative"] -->
By creating a corpus-level view on the texts, that recognizes the imperfections of the corpus, GaLiLeO seeks a return to the texts to explore new interpretive pathways that have not been predetermined by centuries of scholarship. Granted, the underlying computational methods employed for the corpus-scale analysis in GaLiLeO have been modified from those used for a larger scale study of similar materials to provide authorship attribution, thematic mapping, and rhetorical similarity (<cite data-cite="1584927/FS3UWENS"></cite>). Given the condition of the corpus, described in more detail in [Preliminary Corpus for Data Development](#anchor-preliminary-corpus), such study was not an option. It was also not the immediate goal, since the team wanted to spark a conversation about tools that would be of use beyond the few digital humanists that also study Galileo. While the code could now be updated to reflect advances in text mining and computational linguistics, they do not address GaLiLeO's primary question of how to bridge the scales of question making and answering in the humanities.
<!-- #endregion -->

This focus meant creating textual models and query possibilities that would highlight similarities or differences in a way that gives non-digital researchers enough context to both evaluate and follow leads suggested by those circumstances allowed by the corpus. In this sense, GaLiLeO aspires to going one step beyond the ePistolarium project (<cite data-cite="1584927/QX9LW4Y8"></cite>) on 17th century correspondence in the Dutch Republic, which provides spatial and network visualizations of the searched person's locations and relationships. The openness of the planned, ideal query can also address DH priorities of de-colonizing archives. In order to know what is interesting enough to search in a corpus, a user needs to arrive with prior knowledge of the values associated with its contents. While not always problematic, systemic exclusion, majority perspectives, and other kinds of bias limit the interpretive pathways of a collection of text structured by technology. In that regard, GaLiLeO addressed a point raised by Ryan Cordell during a visit to Bowdoin College in 2014: What happens when we do not know the person, term, or year that might be interesting in a corpus of texts?


Consequently, rather than a model of the documents related to Galileo, the tools presented here provide a model for asking questions in non-digital humanistic fashion. The approach borrows this phrasing from Willard McCarty, who distinguishes between an archaeological map *of* a historic site (i.e. a computational reading of the National Edition of Galileo's works) and the blueprint *for* a new edifice (inquiries related to the documents) (<cite data-cite="1584927/4JAXCGB8"></cite>). A model *of* Galilean texts would be forever incomplete and many parts already exist in the current digital ecosystem. A model *for* inquiry on the other hand would be extensible to the new data sets, for Galileo, but potentially for other authors and collections. The tools in GaLiLeO thus embrace the epistemology of *Hermeneutica*, but not the implementation. Since, as Rockwell and Sinclair point out, an "instrument implements a theory of interpreting the phenomenon it was designed to bring into view" (<cite data-cite="1584927/PVFRKDSE"></cite>, 162), a new instrument was necessary. The historians involved in testing the prototype were seeking mechanisms to understand tone, reliability (through consistency), corroboration with other viewpoints, and verification. Literary scholars wanted to engage with the multiple contexts through which an expression conveys potentially different meanings. This required bringing together not just words and documents, but the overall corpus attributes. Again, as Rockwell and Sinclair so efficiently state: "developing tools involves bearing hermeneutical theories" (<cite data-cite="1584927/PVFRKDSE"></cite>, 161). For the GaLiLeO designers, the result was a type of digital laboratory: a series of tools for exploration, question-making, and question answering.

<!-- #region tags=["narrative"] -->
One might ask why the team did not repurpose Rockwell and Sinclair's Voyant Tools for this purpose, since it was one of the primary inspirations for the functions in GaLiLeO (<cite data-cite="1584927/2WCMWWUK"></cite>). The evaluations in subsequent sections of this article will provide a more detailed comparison, but one challenge was simply the size of the corpus, thousands of documents, which are difficult to see graphically.
<!-- #endregion -->

The remaining sections of this article evaluate the tools as they were demonstrated via Jupyter notebook in September 2018, with identification of improvements that could be made in the future and slight modifications to function with the tools of this journal. While not necessarily an obstacle, the code ought to be optimized for runtime efficiency, since their designer was a Digital Humanist who codes, but not a software engineer. In addition, although the Jupyter notebook tried to offer novice coders instructions for use, the project would benefit from a more user-friendly interface.


## Preliminary Corpus for Data Development

<!-- #region tags=["narrative", "anchor-preliminary-corpus"] -->
The two projects that merged involved metadata about Galileo's correspondence and cleaned OCR of books from his library, including both those that he wrote and others that he was known to have owned. The prepared corpus reflected Galileo's correspondence tagged by the Marcus team and the contents of his library prepared by the author's team as of July 2017. Metadata for these texts was hand keyed, with the clarification that sometimes authors (including letter writers) are simply unknown. Yet, the correspondence itself needed to be available for use as plain text. Even for an individual as famous as Galileo (or perhaps because of it), there is no freely-available set of plain-text files for analysis.
<!-- #endregion -->

The correspondence in the National Edition of Galileo’s works included over 4,300 letters from the 20 volumes edited by Favaro in the 19th century (<cite data-cite="1584927/XYL4T68J"></cite>). Many letters were only excerpted in Favaro's edition. While a scan of the first printing of the National Edition is available, images of manuscripts are housed by different institutions with strict reproduction rules. Although materials existed on the Galileoteca site, and conversations with the director after 2018 indicated that there might be opportunities for bulk export and resource sharing, the process of working from the available print edition raised valuable questions about the state of Galilean correspondence. By working with the National Edition rather than manuscripts, the resources were not limited by the confines of physical archives, yet the editorial practices and remediation of the National Edition in the Galileoteca imposed critical changes in orthography, punctuation, and sometimes word choice (<cite data-cite="1584927/XYL4T68J"></cite>, X, 11). These editorial layers foreclosed a corpus-scale analysis, which would have amounted to a study of a 19th-century version of the language of Galileo and his contemporaries. An ideal corpus would not remediate post-hoc editorial lenses with their own epistemological priorities. The GaLiLeO tools aspired to identify the categories, organizing principles, affinities, disparities, patterns, and outliers in the documents as they were expressed at the time. Even if the texts were readily available, they nonetheless overrepresent Galileo and the authors skew heavily male. This fundamental resource in the field was used to start the conversation about what might be built next, but should not be the foundation for that new digital corpus.


For the purposes of the prototype development, and with the limitations of time and resources, the corpus was nonetheless the only one available to use during the demonstration alongside the library contents and editorial metadata. Abbyy Fine Reader was used to convert the scans of the national edition to plain text with minimum data cleaning. The texts represented a spectrum of quality from a first pass of OCR on scans of 19th-century volumes (National Edition) to OCR results cleaned by comparison to scans of pre-modern printed volumes (library contents) to documents typed by hand based on the original print or manuscript (library contents). Using the editorial layer created by the Marcus team, which had tagged letters for use of various concepts after reading the letters, the corpus of correspondence was reduced to the documents with "Instruments and Materials" tags. These represented a range of early modern tools for knowledge creation including the telescope and its component pieces, but also candles, compasses, magnets, scales, and vessels for water. The team of specialist readers had also tagged words that were used as descriptors and actions related to experiments and experiences of natural phenomena in service of learning or confirming knowledge. Overall this created a subcorpus of 2,346 letters for analysis during the workshop. The proof of concept identified several areas for future development in terms of customization: how to interact with the specialist editorial layer (or not), choosing a subcorpus of interest, limiting or expanding the number of languages considered, and how to handle Galileo's work.


As presented at the workshop, the overall corpus could be subset into specialized document groupings based on type of document and metadata tag categories.

```R jdh={"object": {"source": ["Screen capture from the GaLiLeO Prototype created by the author.", "No copyright restrictions."]}} tags=["figure-galileoparameter-*", "hermeneutics"] vscode={"languageId": "r"}
display_png(file="./media/GaLiLeOParameters.png")
```

<!-- #region tags=["narrative"] -->
Any text from the library that used one of 905 different terms tagged in the "Instruments and Materials" category identified by the editors was also available as a subcorpus. Users could opt to include the matching prefatory letters from 119 titles in Galileo's library. Due to an OCR error, the shortest document only had 1 token. The median length of the texts in the subcorpus was 257 words (i.e. 2,178 documents were shorter than this). The corpus represents 9 different languages. A planned feature would allow further subsetting by English, Dutch, French, German, Greek, Italian, Neolatin, Paduan dialect, and Spanish. This would require a team of scholars trained in those languages to help align the tags and clean the OCR.
<!-- #endregion -->

<!-- #region tags=["hermeneutics"] -->
The first code cells in the prototype made visible the goals and limited implementation of the prototype while obscuring significant interpretive work. Users were asked to run some setup code behind the scenes before getting started. This loaded the necessary libraries and read the data into memory without needing to show lines of code that might have been overwhelming to many of the workshop participants who had never worked with Jupyter or seen code prior to joining us that day. (The code cells in this article retain some of the commenting that was provided for colleagues who had never programmed prior to the workshop.)
<!-- #endregion -->

```R tags=["hermeneutics"] vscode={"languageId": "r"}
#Requires ~20 seconds to load everything into memory
source("script/5_GaLiLeOSetup1.R")

corpus_name <- "InstrumentsAndMaterials" #documents that were tagged with this label by Marcus' editorial team

subcorpus_name <- "NoFull" #includes prefatory letters, but not full text of books
#subcorpus_name <- "EdNaz" #only OCR from the National Edition of Galileo's works

# Do not edit this line or the following code:
correct_corpus_files <- prepare(corpus_name, "script/data/")
cm <- grep("CorpusMetadata", data_files[correct_corpus_files])
correct_cm <- grep(subcorpus_name, data_files[correct_corpus_files[cm]])
corpus <- readRDS(file = paste(in_dir, data_files[correct_corpus_files[cm[correct_cm]]], sep = ""))
ca <- grep("CorpusAttributes", data_files[correct_corpus_files])
correct_ca <- grep(subcorpus_name, data_files[correct_corpus_files[ca]])
corpus_attributes <- readRDS(file = paste(in_dir, data_files[correct_corpus_files[ca[correct_ca]]], sep = ""))
text_a <- grep("TextAttributes", data_files[correct_corpus_files])
correct_text_a <- grep(subcorpus_name, data_files[correct_corpus_files[text_a]])
text_attributes <- readRDS(file = paste(in_dir, data_files[correct_corpus_files[text_a[correct_text_a]]], sep = ""))
type_a <- grep("TypeAttributes", data_files[correct_corpus_files])
correct_type_a <- grep(subcorpus_name, data_files[correct_corpus_files[type_a]])
type_attributes <- readRDS(file = paste(in_dir, data_files[correct_corpus_files[type_a[correct_type_a]]], sep = ""))
source("script/6_GaLiLeOSetup2.R")
```

<!-- #region tags=["narrative"] -->
During the demonstration, users were able to interact with documents written by over 625 authors. As with the national edition overall, the letter writers skew male and the collection features Galileo more than other individual. 307 authors only contributed one item. The top contributors were:
- Galileo Galilei (441)
- Benedetto Castelli (251)
- Fulgenzio Micanzio (153)
- Federico Cesi (150)
- Buonaventura Cavalieri (134)
- Suor Maria Celeste Galilei (124)
- Giovanfrancesco Sagredo (102)

Importantly, the subcorpus shows the prominence of Galileo's students and collaborators (Castelli, Cavalieri, and Sagredo), patron and partner (Cesi), and daughter (Maria Celeste). A planned feature will allow for continued subsetting by author of the material to facilitate the comparison of their linguistic choices to other writers. NB: anyone who explores the current notebook in more detail will immediately notice numeric discrepancies related to trimming the data to conform to file size limits in GitHub and mybinder. One can also see encoding issues related to accented vowels and special characters in the names of letter writers and recipients.
<!-- #endregion -->

```R tags=["hermeneutics"] vscode={"languageId": "r"}
authors(corpus) # Long output
```

<!-- #region tags=["narrative"] -->
Because the goal of GaLiLeO was to assist in the selection of texts, the contextual data about their contents had to be developed with the possible subcorpus variations that were planned. The data creation process occurred prior to the user's corpus selection. (This also solves a runtime problem, similarly to the functionality of the Text Analysis and Concording Tool (TACT), but of course restricts usability by this predefinition (<cite data-cite="1584927/PVFRKDSE"></cite>, 57). Currently the analysis focuses only on the body of documents. A feature to develop would include words in titles and the metadata as part of the contextual information available. Given the known editorial interventions, two versions of each subcorpus were made: one with and one without punctuation. Every character was converted to lowercase.
<!-- #endregion -->

<!-- #region tags=["hermeneutics"] -->
One of the primary challenges was accounting for orthographical variance between the critically edited texts and the diplomatically edited ones. These are unrelated to the significant orthographical changes made in the 19th century edition, and are instead an artefact of printing practices in the 17th century. Early modern printing practice interchanged u and v, such that, for example, vno and uno were read as equivalents by contemporary readers. Since the digital characters v and u are encoded uniquely, substitutions were made in all texts to standardize how words appeared, meaning a departure from their print original, but the ability to search for terms without concern for orthographic variation. Using regular expressions would have changed too many vs that really were vs, so this catalogue of substitutions was developed iteratively. It identifies and corrects most v/u substitutions, but likely still needs refinement. On the other hand, a universal substitution was made for j (called the long i) to i. This would need to be addressed with more nuance in a subsequent version of the tool kit, but allowed for significant experimentation even with the alpha prototype for texts in Italian (as opposed to Latin where it is more frequent).
<!-- #endregion -->

```R tags=["hermeneutics"] vscode={"languageId": "r"}
v_incorrect <- c("vb", "vc", "vd", "vf", "vg", "vh", "vj", "vk", "vl", "vm", "vn", "vp", "vq", "vs", "vt",
                 "vw", "vx", "vy", "vz", "bv", "cv", "fv", "gv", "hv", "jv", "kv", "mv",
                 "pv", "qv", "tv", "wv", "xv", "yv", "zv", " sve ", " sva ", " svo ", "trvi", "nvo ",
                 "nva ", "dvr", "dvi", " piv ", " lvi ", "svoi", " dv", "vr ", "nvare", " Vn", "Qv", "æ",
                 "vre ", " lv", " svo.", " svo,", " svo?", " svo!", " svo;", "vrea", "svet", " lvi.",
                 " lvi,", " lui?", "svra") # v does not normally appear before these letters
u_correct <- c("ub", "uc", "ud", "uf", "ug", "uh", "uj", "uk", "ul", "um", "un", "up", "uq", "us", "ut",
               "uw", "ux", "uy", "uz","bu", "cu", "fu", "gu", "hu", "ju", "ku", "mu",
               "pu", "qu", "tu", "wu", "xu", "yu", "zu", " sue ", " sua ", " suo ", "trui", "nuo ",
               "nua ", "dur", "dui", " piu ", " lui ", "suoi", " du", "ur ", "nuare", "Un", "Qu", "ae",
               "ure ", " lu", " suo."," suo,", " suo?", " suo!", " suo;", "urea", "suet", " lui.",
               " lui,", " lui?", "sura")
```

<!-- #region tags=["narrative", "hermeneutics"] -->
The code is not elegant, but captures quantitative information about each document, the words in the document, and the author. As shown in the figure below, the underlying metadata is also contextualized within the corpus. The results are stored as RDS objects to be loaded into memory when the user chooses a subcorpus for exploration.
<!-- #endregion -->

```R jdh={"object": {"source": ["Screen capture of the code written by the author to create the data for GaLiLeO.", "No copyright restrictions."]}} tags=["figure-galileotextattributes-*", "hermeneutics"] vscode={"languageId": "r"}
display_png(file="./media/GaLiLeOTextAttributes.png")
```

<!-- #region tags=["hermeneutics"] -->
The figure above outlines the specific and relative information created and saved for each document. Again, there are redundancies and inefficiencies since this is an alpha-prototype coded by a humanist. Many of the attributes are recorded with variations: tokenization includes and excludes punctuation, stylistic similarity based on three different feature classes and two distance measures, as well as distinguishing between documents written by Galileo and those written by other authors. The goals were twofold: achieve as many perspectives as possible on the texts and word types as well as explore the strengths or limitations of each perspective in comparison to the others. Creating many of the features also allows for querying by attribute range rather than the specific attribute. For example, by saving the contextual information, a user could identify authors who wrote many documents in the corpus, but were the recipient of none.
<!-- #endregion -->

<!-- #region tags=["narrative"] -->
As Rockwell and Sinclair point out, these hermeneutica draw our attention to "the materiality of interpretation" (<cite data-cite="1584927/PVFRKDSE"></cite>, 152). For GaLiLeO the materialities rest on two kinds of instantiations of interpretation: providing context around specific documents or words and experimenting with pattern-based inquiry. The contextual output draws attention to the marginal, mainstream, and missing information related to a query. Data about commonalities and differences appear together by default. Pattern-based functions, currently at the end of the prototype, push the materiality of interpretation further by asking the scholar to frame a question without knowing a specific document, word, or author that might meet the criteria.
<!-- #endregion -->

<!-- #region tags=["narrative"] -->
Typical document-retrieval design would require the user to have one of two things:
- prior knowledge of key actors in the period, important dates, sites of intellectual exchange, and significant keywords (all likely brought to light by previous scholarship)
- enough curiosity to provoke browsing ordered lists of people, dates, places, or concordances in the hopes of finding something interesting

While our underlying data does capture information about people and places (with Named Entity Recognition to be implemented), it also tries to bring to light the bigger picture in which they appeared. GaLiLeO gives relevance to inconsistencies, prizes the anomalous, renews the priority of the individual text or author, draws attention to gaps, and capitalizes on juxtaposition to provoke new inquiry.
<!-- #endregion -->

<!-- #region tags=["hermeneutics"] -->
For example, in the "Instruments and Materials" documents without full text, the dates of coverage were 1506-1642 (the year of Galileo's death). With mean and median years in the mid-1620s, there is potentially an emphasis on discussions of experimentation supported by tools and instruments in the correspondence written in later decades of Galileo's life. Yet, in terms of chronological representation of the overall corpus, it is also heavily skewed toward the later years of Galileo's life, when his fame was such that correspondence increased and the need for preserving a record of communication with famous individuals became apparent.
<!-- #endregion -->

```R tags=["hermeneutics"] vscode={"languageId": "r"}
date_range(all_years)
```

<!-- #region tags=["hermeneutics"] -->
The following code cell shows a simplistic example of how this was instantiated in terms of creating both the model of the data, but also a model for contextualizing any document. The context, ideally, was provocation for further inquiry based on the results (the circumstances influencing the events). Users are immediately greeted with information about the years of coverage in their subcorpus, shown in the code snippet and then rendered specifically for one document of interest that will serve as the example for the rest of this article.
<!-- #endregion -->

```R tags=["hermeneutics"] vscode={"languageId": "r"}
#Get year information
years <- as.numeric()
for (d in 1:length(text_attributes)){
  year <- as.numeric(text_attributes[[d]]$Year)
  years <- c(years, year)
}
all_years <- sort(years, decreasing = F)
years_df <- as.data.frame(table(all_years))
years_df$Color <- "No"
colnames(years_df) <- c("Year", "Count", "Color")

#Partial representation of the function to highlight contextual data about years
#Commented out to avoid overwriting the full function loaded earlier

#choose_doc <- function(text_list, corpus_metadata, full_ID){
#  tl_index <- which(Full_IDs == full_ID)
#  for (j in 1:length(tl_index)){
#    cat("This is 1 of ", text_list[[tl_index[j]]]$AuthorDocs, " documents written by ", text_list[[tl_index[j]]]$Author, "in the corpus.\n")
#    cat("The title is: ", corpus_metadata[[tl_index[j]]]$Metadata$Title, "\n")
#    cat("\nIt was written or published ", text_list[[tl_index[j]]]$Year, ".\n")
#    cat(text_list[[tl_index[j]]]$YearInfo$SameYear, "document(s) was (were) dated or (published) in the same year.\n")
#    cat(text_list[[tl_index[j]]]$YearInfo$Before, "document(s) was (were) dated or (published) in the years before it.\n",
#        text_list[[tl_index[j]]]$YearInfo$After, "document(s) was (were) dated or (published) in years after it.\n")
#    target_y <- text_list[[tl_index[j]]]$Year
#    years_df$Color[which(years_df$Year == target_y)] <- "Yes"
#    
#    y<-ggplot(years_df, aes(x=as.numeric(Year), y=Count, fill=factor(Color))) +
#      geom_bar(stat="identity")+theme_minimal() +
#      theme(axis.text.x= element_text(angle = 45)) +
#      theme(legend.position = "none") +
#      scale_x_continuous(name = "Year", breaks = seq(earliest,latest, by = 5)) +
#      labs(title = "Comparison of Selected Text (in Blue) by Year")
#    out_dir <- "GaLiLeOResults/"
#    year_plot_name <- paste(out_dir, full_ID, "YearComparison.png", sep = "")
#    ggsave(filename = year_plot_name, plot = y, device = "png")
#    dev.off()
#  }
#}
```

```R jdh={"object": {"source": ["Output from a tool in GaLiLeO created by the author.", "No copyright restrictions."]}} tags=["figure-ednazcomparaison-*", "hermeneutics"] vscode={"languageId": "r"}
display_png(file="./media/EdNaz574YearComparison.png")
```

<!-- #region tags=["hermeneutics"] -->
The figure above visually foregrounds the chronological context of a letter written in 1610, while the code does so numerically. The user can immediately see trends of representation in the corpus at large. A student new to the field can recognize that they are in a period of importance (determined by quantity of documents), while a scholar might be curious about the years with less documentation.
<!-- #endregion -->

<!-- #region tags=["narrative"] -->
By creating this metadata for documents, GaLiLeO's tools facilitate structuring a query that identifies relationship intensities (central, peripheral or eccentric), frequencies (maximum, high, low, minimum, none), and document categories (private, public, print tradition in the library) of interest. Using this metadata, it would be helpful to both an expert scholar and a student to be able to search by the following attributes that can be calculated for each named person or place:
- how central the author is in Galileo’s library or letters
- that a letter recipient is only present in paratext in the library
- if a person mentioned has a higher centrality in the library than in correspondence
- that the destination of the letter is the most frequent city to which letters were sent and/or the second-most frequent city in which books in the library were published
- the date of the document is the year in which book collecting started to increase and/or a year with many missing letters, but still a high frequency for the overall correspondence
- a word has a high frequency in Galileo's letters, but very few or no occurrences in printed materials, or is absent from other writers' documents entirely

These features use corpus-wide trends to point to small-scale patterns. In response to DH scholars Witmore and Hope, GaLiLeO aimed for tools that “allow you to have your books on multiple shelves simultaneously” (<cite data-cite="1584927/T3EV72WF"></cite>, 18). Such a structure is an invitation, one that does not require knowing someone or something “interesting” before exploring. In this sense, the ideal tools would respond to a challenge that Ryan Cordell identified in the development of the large-scale digital text archives: even a motivated user often does not know what to put in a search bar (<cite data-cite="1584927/VNEYQCPL"></cite>).
<!-- #endregion -->

<!-- #region tags=["narrative"] -->
The original plan for GaLiLeO anticipated accounting for the fact that any word in the letters or library is:
- a string of alphanumeric characters (ngram)
- a potential editorial tag provided by specialists
- a part of speech (POS)
- a keyword in multiple textual contexts
- a piece of a textual structure (sentence, verse, speaking part, marginalia)
- a piece of multiple semantic networks
- an abstraction (indicative of a dictionary of synonyms and related terms)
- a concept (a collection of instances across time and contexts)
- an expression in time
- a position in vectors of words
- part of metadata
- part of text or paratext
- a material object with a print and/or manuscript history and visual qualities
- an instance of a frequency of usage:
    - In the corpus
    - In works written by Galileo
    - In works written by others
All of these features would thus build the query structure for the curious researcher that can formulate a question without already knowing a preliminary answer.
<!-- #endregion -->

<!-- #region tags=["narrative"] -->
Scholars and students know what kinds of questions are interesting without necessarily knowing who or what fits those criteria, and the GaLiLeO team hopes to have built something to model (or provide a foundation for) that kind of query. In that sense, GaLiLeO becomes a site of discovery, not simply transmission of digitized documents. The hierarchies often embedded in digital tools through remediation of archives are brought onto the same plane via this underlying data structure. By changing identifiers related to documents (not alphabetical, chronological, or numerical), the texts are placed in an interconnected space of representation and understanding (thus they are actual relations rather than a relational table with connections assigned through inherited, post-hoc knowledge). The user can experience these texts with a perspective that is not her own - a browsable structure that provokes inquiry, allows for the selection of a virtual book from this network and reveals all of the ways that it nests within hierarchies or stands apart from them. Rather than browse by a post-hoc genre category, the adjacencies of texts based on a variety of features can be evaluated for their apparent lack of connection, the ambiguity of the language that binds them, and the serendipitous viewpoint that their similarity allows.
<!-- #endregion -->

## Document Tools in GaLiLeO

<!-- #region tags=["narrative"] -->
The goal with the analytical tools for the text of the documents was to create a visual or numerical point of entry for asking questions about terminology, texts, and authors. While not as polished as the suite of widgets in Voyant Tools, the demonstration at Harvard in 2018 deployed 12 tools even though participants were unfamiliar with Jupyter notebooks and coding in R or other formal languages. Omitted here is a discussion of the Tag Exploration (developed by Hannah Marcus and Morgan MacLeod) that was part of a secondary Jupyter Notebook written in Python. Because the presentation was for a specialist audience of Italian Studies scholars, most of whom focus on Galileo, the pattern-based searches for an author or document were not fully built. These would have included addressing patterns based on an individual's frequency of appearance, role in a network of correspondents, co-mentions in a text (or lack thereof). Humanists are interested in central, peripheral, and eccentric figures; the popular and the obscure; those connected to figures of power (or not); those who cross boundaries or define them. All of these features could be calculated and queried (with the right data) to draw attention to people in the documents without ever needing to know a name to put in a search bar or select from a menu.
<!-- #endregion -->

<!-- #region tags=["narrative"] -->
Ideally, users would be presented with a menu of attributes related to similarity and difference to help them arrive at a document of potential interest. For instance, such a pattern-based tool would surface the name of Margherita Sarrocchi (1560-1617), because she is mentioned more often by other authors than she is the author of surviving letters, a potentially interesting imbalance worthy of investigation. Given Sarrocchi's embeddedness in literary circles in Rome at the time, her correspondence with Galileo also offers a sense of the interdisciplinary nature of Galileo Studies (<cite data-cite="1584927/UU4GWNXT"></cite>). For the sake of this demonstration, a letter that Sarrocchi wrote to the Perugian Guido Bettoli (active early-16th century), of which she sent a copy to Galileo, will serve as a guide through the document and lexical tools. Since Galileo read the letter (having written this contextual information on a surviving copy of it), and since it was not included in Ray's recent edition of the Sarrocchi-Galileo correspondence, it provides an alternative entry point to examining Sarrocchi's relationship with Galileo and his discoveries.
<!-- #endregion -->

A function later in the prototype notebook, "read_doc", prints the contents of the letter to the screen, but it is provided here for Italian readers to see the letter in question. The output also provides a sense of the quality of the OCR from the national edition. The letter is labelled EdNaz574 in the code cells for its location in the national edition.

```R tags=["hermeneutics"] vscode={"languageId": "r"}
read_doc(text_attributes, "EdNaz574")
```

<!-- #region tags=["narrative", "hermeneutics"] -->
Currently, the function “choose_doc” is the primary contextualizer in the suite of tools and much more restricted than the pattern-based ideal described above. The function retrieves critical numeric and lexical information, presents those results as text, and saves images of graphs when appropriate. The output from choose_doc is admittedly long, so it will be evaluated in phases. The visualizations that accompany the quantitative output are loaded here as images. Student users can refer to the output to prompt exploration of other documents and authors that are similar. Specialists will likely be drawn to the lexical and chronological features to start an investigatory path. All users will be presented with what could be called the document's perspective on the corpus: how it relates to other documents without imposition of siloes of periodization, nationality, genre, or form.
<!-- #endregion -->

```R tags=["hermeneutics"] vscode={"languageId": "r"}
choose_doc(text_attributes, corpus, "EdNaz574")
```

<!-- #region tags=["narrative"] -->
There are 8 documents written by Sarrocchi in the corpus overall, but only 4 appear in this subcorpus related to instruments and materials. That discrepancy should prompt a query for her other letters (and eventually the full text). She wrote to Bettoli in 1611, soon after Galileo had returned to Tuscany upon publishing his discoveries with the telescope. The barplot that is generated by the same function for contextualizing years (see figure above) visualizes that context in terms of quantities of letters that exist in the subcorpus. 1611 is in the top 5 years for which letters have survived in the various archives represented by the data. The chronological information indicates that Sarrocchi's enthusiastic confirmation of Galileo's observations was sent during a year of intensive correspondence. One might start to wonder how Sarrocchi became part of this first wave of interest in instruments and materials, particularly since she was not one of the earliest writers on these topics. This should also prompt an interative use of the code to contextualize her other letters chronologically. A convenient additional feature would be to plot all of the writer's documents against the backdrop of the corpus.
<!-- #endregion -->

<!-- #region tags=["narrative"] -->
An embedded function within choose_doc contextualizes the length of a document in comparison to the lengths of other documents in the subcorpus. Sarrocchi was writing longer letters than the average correspondent in this subcorpus. In addition to the prose readout from the code cell, prototype users saved a graph that plots lengths for the entire subcorpus.
<!-- #endregion -->

```R jdh={"object": {"source": ["Output from a tool in GaLiLeO created by the author.", "No copyright restrictions."]}} tags=["figure-ednazlengthcomparison-*", "hermeneutics"] vscode={"languageId": "r"}
display_png(file="./media/EdNaz574LengthComparison.png")
```

<!-- #region tags=["hermeneutics"] -->
While perhaps initially disorienting, the plot in the figure above shows, for example, that 11 documents are ~250 words long (the dot farthest to the right). 11 are slightly longer than 500 (the dot to its left). At the left side of the graph, length variation increases. The y-axis is a logarithmic scale to account for the handful of documents that are around 10,000 words in length. The context shows how unusual in this subcorpus are documents of the same length. Red dots lower than Sarrocchi's blue dot are letters that are shorter, those higher are longer. It is not unusual for letters to have the same length. To assist with pattern-based inquiry, this function should be expanded to be able to reverse the query based on the location of a point on the plot. This would increase the juxtaposition circumstances for the texts and would help to identify Sarrocchi's variation in all of her letters (or not).
<!-- #endregion -->

<!-- #region tags=["narrative"] -->
Beyond quantity of terms, the code also reveals proportionality of lexical choices. One of the visual outputs is a comparative type-token ratio scatterplot (see figure below). This can be a way to understand repetition and complexity in documents by comparing unique word forms to the total number of words in a text. The figure compares the lexical complexity of a specific document (in blue), with or without punctuation, to works by Galileo and works by other authors. Importantly, the points with a TTR value of 1.0, meaning that no words are repeated in the document, are short excerpts from letters that were transcribed into the National Edition. They are sometimes so short as to be phrases or incomplete sentences. Sarrocchi's letter is not as lexically complex as most of the documents in the subcorpus. Here Sarrocchi's use of terms is seen in comparison to Galileo directly and against the backdrop of other authors in the subcorpus. The juxtaposition reveals more repetition in her letter than in those written by others.
<!-- #endregion -->

```R jdh={"object": {"source": ["Output from a tool in GaLiLeO created by the author.", "No copyright restrictions."]}} tags=["figure-ednaz574TTRComparison-*", "hermeneutics"] vscode={"languageId": "r"}
display_png(file="./media/EdNaz574TTRComparison.png")
```

<!-- #region tags=["narrative"] -->
Admittedly, the distinction between counting or not counting punctuation might be negligible. However, Galileo's prose is built on clauses and subclauses, so counting words followed by punctuation as a token helps to capture something about the prominence and variation within that stylistic element. For example, a document 1000 words long with 500 unique word types has a TTR of 50%. If the letter writer uses punctuation to establish rhythm and structure in her sentences, at a rate of one mark for every 5 words, the number of unique types could be as high as 700 (since *philosophy* and *philosophy,* would be treated as distinct strings of characters), while the length remains the same. Then the TTR would be 70%. If she has long sentences structured around connective words rather than punctuation, the number of types will only increase by a small percentage. Such measurements invite more opportunities to design pattern-based inquiry options.
<!-- #endregion -->

<!-- #region tags=["narrative", "hermeneutics"] -->
The function “choose_doc” also allows a user to see unique vocabulary and surprising omissions of words that are otherwise popular in the corpus. With Sarrocchi's letter, specialists will be interested in the output that reports in her apparently unique use of "achademici" and "matemateci", both of which are distinct spellings of the standard Italian terms academici (academicians) and matematici (mathematicians). Computational tools that rely on underlying use of dictionaries, language models, or lexica combine these variations into one result. In a corpus like the Galileo correspondence or his library, that would mean sifting through hundreds of results for "matematici" that might have instead used the variant.
<!-- #endregion -->

Importantly, the function identifies what writers were *not* talking about alongside what they were. From what conversations were they excluded? What topics did they avoid even though they could have addressed them? The function "TopWordsNotInText" (so-named for transparency to novice coders) allows the user to probe the output from "choose_doc" more deeply.

```R jdh={"object": {"source": ["What writers were not talking about", "No copyright restrictions"]}} tags=["hermeneutics", "table-1", "data-table"] vscode={"languageId": "r"}
ID <- "EdNaz574"
# Call the TopWordsNotInText function and store the result in a dataframe
result <- TopWordsNotInText(text_attributes, ID)

# Ensure the result is a dataframe
result_df <- as.data.frame(result)

# Add an index column
result_df$Index <- seq.int(nrow(result_df))

# Reorder columns to have the index first
result_df <- result_df[, c("Index", names(result_df)[names(result_df) != "Index"])]

# Set the maximum number of rows to display to a large number
options(repr.matrix.max.rows = nrow(result_df))

# Display the dataframe
display(result_df)
```

<!-- #region tags=["narrative"] vscode={"languageId": "plaintext"} -->
There are certainly more user-friendly ways to present this information, but specialists might be surprised to see the following: “galileo” (27); “mani” (hands; 36) and “galilei” (39); “bacio” (kiss, 70); “libro” (book; 86); “terra” (earth; 96); “opera” (work; 127); “cielo” (sky; 147); and “libri” (books; 184). Some of these omissions are simply the result of bad OCR (or OCR that is bad in ways different from errors found in other documents, also telling in and of itself) (<cite data-cite="1584927/7RXKTZ2Y"></cite>). Yet, they signal that Sarrocchi is expressing honour and flattery in different terms than her contemporaries. She is also spelling Galileo's name with 3 l's. She is not talking about one of his books (or her own), nor is she connecting the discoveries in the skies to the realities on the ground. Her letter also seems devoid of the most frequent modifiers used by other writers in the corpus. Curiosities piqued here can be addressed via further exploration using the word_info function described in [Pattern Tools in GaLiLeO](#anchor-pattern-tools-galileo). Because humanistic analysis, until recently, has prioritized the evidence that is most apparent, it is challenging to understand what is not there, but could have been (<cite data-cite="1584927/T3EV72WF"></cite>, 22). This function seeks to visualize these lacunae.
<!-- #endregion -->

<!-- #region tags=["narrative", "hermeneutics"] -->
The penultimate output from the choose_doc function reports on similarity of rates of use of the 100 most frequent words in the corpus. Users are offered analyses using both Euclidean and Cosine methods (since the lengths of the documents can vary considerably). This is similar to Voyant Tools, the ePistolarium, and other tools that highlight the quantitative distance between documents. The graph shows the 10 most similar documents and the 10 least similar documents (see figure below). Aside from OCR errors that could easily skew this result right now, prototype users speculated that this might show the effects of different epistolary best practices in the period. Since this is based on lower quality OCR than would be desirable for a corpus-wide study, the results are best used to point to letters that might be found to be similar after close reading.
<!-- #endregion -->

```R jdh={"object": {"source": ["Output from a tool in GaLiLeO created by the author.", "No copyright restrictions."]}} tags=["figure-edNaz574CosineComparison-*", "hermeneutics"] vscode={"languageId": "r"}
display_png(file="./media/EdNaz574CosineComparison.png")
```

<!-- #region tags=["narrative"] -->
Such results should prompt exploration of both the similarities and the differences. For example: Why is Sarrocchi's letter so similar to EdNaz3104, Niccolò Fabbri di Peiresc's 1635 letter to Galileo? His letter is nearly twice the length of hers. While not ground-breaking, the function read_doc (seen earlier) allows for immediate exploration of the potential stylistic or other similarities between these documents.
<!-- #endregion -->

```R tags=["hermeneutics"] vscode={"languageId": "r"}
read_doc(text_attributes, "EdNaz3104") # Replace XXXX with an ID, please keep the ""
```

<!-- #region tags=["narrative"] -->
A close reading reveals that both writers are establishing a similar rhythm of *captatio benevolentiae* (the rhetorical practice of establishing good will in the reader through obsequiousness and flattery). They are also following a well-established formula of pleasantries around replying to mail. The function breaks Sarrocchi from the post-hoc categories that have followed her frequently (but not always) in scholarship. Instead of grouping her with women to study gender differences in style, this approach uses the larger-scale quantitative information to suggest small-scale pathways of exploration. In some cases these results might encourage biographical research, in others rhetorical and literary study.
<!-- #endregion -->

<!-- #region tags=["narrative"] -->
Seen through this computational and quantitative lens, Sarrocchi's correspondence and literary works are not being considered from the typical scholarly contextualizations within works by other women writers, literary authors, and those outside learned academies. Yes, these are all categories to which she belonged, but they were not necessarily the definitive boundaries for the development or deployment of her writing style. This tool and the others that follow are meant to identify further potential communities and similarities. This is not meant to exclude or supersede the results of late-19th and 20th century humanistic epistemologies, but to admit space for permeability across these boundaries that reflects recent scholarship.
<!-- #endregion -->

<!-- #region tags=["narrative", "hermeneutics"] -->
The final contextual information in "choose_doc" reports results from topic modeling. GaLiLeO aspires to providing pathways of interest, not interpretations. Much like the ARTFL Encyclopédie (<cite data-cite="1584927/DMRYV5NK"></cite>), that uses multiple digital models for users to explore, a preliminary topic model was made from each corpus and subcorpus for proof-of-concept purposes. Like the stylometric output that is also included, the model was not optimized given the condition of the OCRed text, so after removing the stop words used for Italian in Voyant Tools, all remaining words (even those occurring in one document only) were considered to infer just 25 topics. The spirit of applying LDA to the corpus was similar to that of the ARTFL team with the Encyclopédie, in which topic modeling was used to explore the ways in which lexical choices of entries cut across the categorization imposed by the structure of the encyclopedia (<cite data-cite="1584927/DDL3LYTS"></cite>). Here, the categories are the ones imposed by the other quantitative methods, and LDA is one of the tools to explore their permeability. The model is created in advance to create run-time efficiencies for the demonstration (which itself was slow at times). Information about whether or not a term is a top word in a topic is preserved and reported by the word_info function (described in more detail below). At the document level, the output merely identifies the top 3 topics from a preliminary model of the subcorpus.
<!-- #endregion -->

<!-- #region tags=["narrative"] -->
The challenge of LDA as a navigational tool is that all of the terms that have a high likelihood of indicating a topic in a document are not necessarily present in the documents that have a likelihood of representing the topic. This last output of choose_doc reports word co-occurrence at a corpus level, not a document level, by indicating the topics likely present in the letter. For instance, if an author uses “sole” (sun) he or she is likely to use “terra” (earth), “parte” (part), or “sopra” (above) as seen in Topic 2 in the choose_doc output final lines, but those words are not all present in any given document, nor are other contextual words of interest. Lexical tools described below try to account for this gap between the probabilities of the models and the actualities of the documents.
<!-- #endregion -->

Despite the completely rudimentary nature of this proof-of-concept topic model, the results do point to aspects of the text and its context that were revealed by the other output from choose_doc. Sarrocchi may not use all of the words in a topic, but enough of them to be associated with the pleasantries of letter writing (most prominently), a discussion of natural philosophy, and networking within or by means of members of learned academies. (NB: The topic numbers listed are not the topic numbers in the model, but the ranking of the topics likely present in the document. Their order will rarely, if ever, match the order of the list provided in the lexical contextualization section below.)

<!-- #region tags=["narrative"] -->
A specialist can add dimensions of contextualization here, while a novice can use the output to continue to explore. With both this and the final output of choose_doc, the low quality of some of the OCR data undermines the strength of any emerging argument about this specific letter by Sarrocchi, but encourages a return to the materials, physical or their digital surrogates, to test new hypotheses. These kinds of questions could be expanded to other corpora because they are based on the kinds of patterns, differences, and absences that are common to intellectual pursuits in history and literature.
<!-- #endregion -->

## Lexical Tools in GaLiLeO

<!-- #region tags=["narrative"] -->
The second half of the GaLiLeO prototype notebook was dedicated to learning more about specific words of interest. To assist with usability, the function “word_info” outputs features of word types based on embedded functions. Users see the term contextualized chronologically, within author subsets (currently limited to Galileo and a group that includes all other authors), and within top words for the topic model (when applicable).
<!-- #endregion -->

<!-- #region tags=["narrative"] -->
To demonstrate and evaluate the methodological priorities that guided the development of these functions, the same letter will serve as the example. Sarrocchi's expressions of enthusiasm and engagement with natural philosophy might draw attention to her orthography and whether or not it was truly unusual. Upon close reading of the letter, the term *ochiale* would look unusual to even beginner students of Italian, since its root *occhio* (eye) is the now-standard spelling with the double-c. The term *ochiale* is an alternative spelling for the Italian word for spyglass or telescope *occhiale*. The GaLiLeO tools brought this unusual orthography to light, rather than obscuring it behind editorial practices and database elements of lemmatization and orthographical standardization. Lemmatization and certain editorial practices collapse these variants into one form for searching for all of the letters that talk about the telescope such that a search for *ochiale* produces no results in the Galileoteca.
<!-- #endregion -->

Instead, the function word_info retrieves chronological, authorial, and textual context. The chronological information, if it were based on more accurate OCR output, would prompt consideration of how long it took for one of Galileo's Italian terms for the telescope, occhiale, to become standardized. The preliminary numeric results in the top lines of the output suggest about 20 years. The accompanying bar chart (output last) presents more granular information. This year-by-year information points to a more rapid standardization, within three years. Calling the function for different variants used to describe the telescope would better test the theory.

```R jdh={"object": {"source": ["Chronological use of ochiale", "No copyright restrictions"]}} tags=["figure-wordinfo-occhiale-*", "hermeneutics"] vscode={"languageId": "r"}
word_info(type_attributes, "ochiale")
```

While the results have an immediate use for exploring other documents and terms, the underlying data about the use of *ochiale* (and all terms in the corpus) provide a foundation for pattern-based inquiry in which the specific word is unknown, but a user would like to search for words with known features. A series of logical tests could identify which words came into vogue in a certain period or with a specific relative frequency in the corpus. [Pattern Tools in GaLiLeO](#anchor-pattern-tools-galileo) will experiment more with terms that were or were not used by Galileo in high or low frequency compared to other authors in the collection.

<!-- #region tags=["hermeneutics"] -->
The second set of output from word_info relates the relationship of the searched term to the topic model of the corpus. For the prototype, the topic information stems from the same preliminary model of 25 topics that informed the choose_doc output. The numeric column indicates how many of the 16 total instances of ochiale are assigned to different topics. The most frequent designation is a topic that might be labelled "excessive noble forms of address." Since this model is not optimized for the corpus, the result points to further investigation. Were this a reliably descriptive model of the letters, a scholar could speculate about correspondents outside Galileo's immediate circle adopting a common style of communication for approaching a second-order (or higher) member of the larger social network. One might also investigate if and how Galileo's preferred variant, occhiale, appeared in topics. At this point the model *of* the documents becomes a model *for* an exploration of naming conventions.
<!-- #endregion -->

<!-- #region tags=["hermeneutics", "narrative"] -->
The related function “get_KWIC” is modified from Matthew Jockers’ code in *Text Analysis with R for Students of Literature* (<cite data-cite="1584927/HD8S7YPS"></cite>). While a platform like Voyant can also provide contextual information for term usage, often the title of the document is the only metadata available for sorting the results. The contextual tools in Voyant also draw attention to high-frequency terms moreso than unusual ones. The tools in GaLiLeO add year of publication (or date sent) and the simplistic label of whether or not the text in question was written by Galileo (GG) or someone else (NotGG), in keeping with the theme of the other functions. The context column contains a helpful artefact of the data's creation: an indication of the occurrence number.
<!-- #endregion -->

With a term like the related *telescopio*, which has several hundred results, even the list needs to be parsed to make sense of the kinds of use of the word. Computation can help. For example, in the output of the code cell below, 13 documents use ochiale a total of 16 times. The functions described above permit further exploration of the community of users with similar lexical habits. At the same time, the output indicates where *ochiale* occurs in each text. While it is visualized in a redundant fashion, in the second line of the output below, the artist Ludovico Cardi da Cigoli's letter to Galileo in March of 1610 used this variant spelling twice in a relatively short letter (322 words total): once as the 139th word and again as the 242nd word. This contextualizes the term in such a way as to see authors who make consistent use of a term and those who open a letter with it (the first line of the results, for instance), but never mention it again.

```R jdh={"object": {"source": ["Documents using ochiale", "No copyright restrictions"]}} tags=["hermeneutics", "table-2"] vscode={"languageId": "r"}
get_KWIC(type_attributes, "ochiale")
```

<!-- #region tags=["narrative", "hermeneutics"] -->
While 16 results are small enough to compare manually, more common terms create an organizational challenge for finding contextual patterns. For digital humanists, topic modeling, seeded by keywords, can alleviate this challenge, although with the same caveat that the terms that predict a topic do not all co-occur together in every document that has been inferred to represent the topic. For non-digital humanists, another tool was needed.
<!-- #endregion -->

The underlying function in GaLiLeO for this contextual lexical comparison is see_KWIC, which visualizes terms that co-occur with the keyword over time. This function allows for significant customization for users who do not mind typing up lists of words to exclude. The initial stop word list is quite restricted: definite and indefinite articles, Galileo's name, prepositions, some pronouns, and a handful of terms that are artefacts of the OCR process and data creation. This is intentional. Depending on the type of query, certain co-occurrences might be of tremendous interest. A scholar might be interested in modifiers (even otherwise banal terms such as *assai*/rather, *molto* /many or very, or *poco*/few). A different user might want to exclude verbs, while someone else might want to analyse them. With that in mind, users can currently modify the stop words list (similarly to Voyant). A future option would define only the words to count as context, establishing a white list, which could also be modified.

```R tags=["hermeneutics"] vscode={"languageId": "r"}
sort(stop_words, decreasing =F)
```

```R tags=["hermeneutics"] vscode={"languageId": "r"}
expanded_stop_words <- c("mi", "m", "me", "mio", "mia", "mie", "miei", "ti", "t", "te", "tuo", "tua", "tuoi", "tue",
                         "si", "s", "suo", "sua", "suoi", "sue", "nostro", "nostri", "nostre", "nostra",
                         "vostra", "vostro", "v", "vostri", "vostre", "loro", "lui",
                         "quali", "quale",
                         "ho", "hai", "ha", "hà", "abbiamo", "habbiamo", "avete", "havete", "hanno",
                         "è", "sono", "siete", "siamo", "sei",
                         "ill")
stop_words <- c(stop_words, expanded_stop_words)
```

<!-- #region tags=["narrative"] -->
For the case of Sarrocchi's alternate spelling of *ochiale* (and the restricted sample of texts used for this article), the graph helps to reveal that authors who use this variant are not consistent in their use of content-bearing contextual terms (at least with a context of 20 words). They use the formal term of address (*ella*) and the phrase or terms *assai bene* (rather well). In contrast, letter writers who use Galileo's preferred *occhiale* (not pictured) over time seem to consistently have done or made something (*fatto*), rationalize when they speak about it (*perchè* - because), and discuss a gain or excess (*molto* and *più*).
<!-- #endregion -->

```R jdh={"object": {"source": ["Chronological use of terms with ochiale", "No copyright restrictions."]}} tags=["figure-chronology-ochiale-*", "hermeneutics"] vscode={"languageId": "r"}
see_KWIC(type_attributes, "ochiale", stop_words)
```

<!-- #region tags=["narrative"] -->
The importance of a word is characterized by these functions as more than a highest frequency value or as a marker of distinction (such as tf-idf). By contextualizing the term within textual and metadata information, a user can ask questions about patterns without knowing the words that fit those patterns. The visual and quantitative display create a critical distance from the text that can provide an alternative perspective on the lexical relationships embedded in the text. This invites surprise, questions, and potentially evaluation of previous claims of importance in a collection. The final tools in GaLiLeO attempt to make this explicit, but are ultimately quite simplistic in the prototype.
<!-- #endregion -->

## Pattern Tools in GaLiLeO

<!-- #region tags=["narrative", "anchor-pattern-tools-galileo"] -->
Where the document and lexical tools can help to identify a potentially fruitful avenue of inquiry, they are aided significantly by some contextual knowledge on the part of the user. Alternatively, the more ambitious pattern-based tools attempt to foreground the kinds of questions and structures that can motivate historical and literary analyses. These final tools still need significant development and refinement.  
<!-- #endregion -->

<!-- #region tags=["narrative"] -->
One function allows direct comparison of authors' vocabulary. The eventual goal is to better understand lexical variety, breadth, and overlap. The first step, which was intended to provoke conversation at the prototype workshop, simply reports on the size of the vocabulary in the texts in the subcorpus by a given author. To be more helpful, it should also output the number of documents and the length of those documents. In the example below, the function is called three times to compare Galileo's lexicon to that of his daughter (Suor Maria Celeste) and Margherita Sarrocchi.
<!-- #endregion -->

```R tags=["hermeneutics"] vscode={"languageId": "r"}
compare_author_vocabulary("Galilei, Galileo", corpus, text_attributes, corpus_attributes)
```

```R tags=["hermeneutics"] vscode={"languageId": "r"}
compare_author_vocabulary("Galilei, Maria Celeste", corpus, text_attributes, corpus_attributes)
```

```R tags=["hermeneutics"] vscode={"languageId": "r"}
compare_author_vocabulary("Sarrocchi, Margherita", corpus, text_attributes, corpus_attributes)
#Replace the Xxxx with Last name, First name, please leave the ""
```

<!-- #region tags=["narrative"] -->
In this subcorpus Galileo has 5 times as many letters as his daughter; Maria Celeste's corpus of 64 letters is already 16 times greater than Sarrocchi's. Their associated vocabularies reflect slightly different proportions: Maria Celeste's is nearly one quarter of Galileo's; Sarrocchi's is one seventh of hers. As with nearly every other feature, the focus is on contextualizing Galileo against the backdrop of other authors in the corpus or subcorpus. A version of this function is already provided in the document-level information, which showed that Sarrocchi used an alternate orthography for the Italian terms for academics and mathematics in letter 574 in the National Edition of Galileo's work. This function expands those results to all documents by the author and, at least at this preliminary stage, allows for comparison by range of use, not simply single occurrences in a document.
<!-- #endregion -->

<!-- #region tags=["narrative", "hermeneutics"] -->
The final tool perhaps holds the most promise as a template for query building. The function “find_types_by_range” responds to questions of the type: What are the words that Galileo uses in high frequency that the other authors in the corpus do not use at all? Again, this is a proof of concept, which needs more customization. For now, high is considered to be the 75th percentile or higher in frequency of usage; low is the 25th percentile. Users can also input a simple yes or no to indicate words that Galileo or other authors use (yes) or not (no).
<!-- #endregion -->

```R tags=["hermeneutics"] vscode={"languageId": "r"}
#Takes a few seconds to run
find_types_by_range(corpus_attributes, GG="high", NotGG = "no", size =25)
```

<!-- #region tags=["narrative"] -->
For users of the prototype, this aspect of the tool simply provoked a sense of the magnitude of the unexplored. The results are cumbersome, given the state of the underlying textual data. Similarly, Patrick Juola and Ashley Bernola's Conjecturator (<cite data-cite="1584927/AJ5ZCGGE"></cite>) compares textual features such as the use of a word within two groups of texts that are differentiated by a structural aspect such as decade. With over 87,000 statistically significant observations, these results are "mind-numbing, even demoralizing" (<cite data-cite="1584927/PVFRKDSE"></cite>, 135). As instantiated, the find_types_by_range output still requires specialist knowledge to select a potentially useful path forward. Further interactivity and use of visual cues would help to address some of these concerns.
<!-- #endregion -->

<!-- #region tags=["narrative"] -->
With a tool such as this an author from the period would not need to fit or fight a corpus-scale model of a collection of texts; she would have her own. These permutations of terms provoke questions about individual models of language use rather than a best-fit model for all authors represented. Sarrocchi's document can be compared to the authors' corpus and the corpus at large. The topic model of the overall corpus would be deprioritized in order to see and compare individual authors and texts. In this way, GaLiLeO might capture some of Underwood's perspectival modeling (<cite data-cite="1584927/4HDB2DPJ"></cite>) without risking the bias identified by Katherine Bode (<cite data-cite="1584927/5RCFENA7"></cite>). Perpetual reference and comparison to a model that is heavily influenced by the prolific authors found within it continues to disenfranchise the already marginalized figures who were nevertheless writing and creating in the period. Continuing the example of Sarrocchi, a future instance of GaLiLeO would facilitate a comparison of her letters and the text of her epic poem (with which Galileo was familiar) to Galileo's corpus or to the library corpus overall. Her Latin geometrical and theological texts (should they be found) could be distinguished from her letters and text in Italian for a more nuanced comparison of stylistic, thematic, lexical, and contextual similarities or differences.
<!-- #endregion -->

## Implications and Next Steps

<!-- #region tags=["narrative"] -->
Current use of GaLiLeO is limited to the two principle investigators (and the exploration facilitated by mybinder functionality with a sample of the data for this article), it has always been intended for a broader audience of Galileo scholars, interested peers in history and literature, and students. Thanks to financial support from Harvard University's Dean's Competitive Fund for Promising Scholarship, Galileo scholars were able to convene to test this alpha prototype and brainstorm next steps. In spite of being able to publish new scholarship on Galileo as a result of these tools (<cite data-cite="1584927/TUDXHUQF"></cite>), this project is on hold since August 2022 due to two primary obstacles. First is the question of the corpus and whether or not to unedit Galileo and his colleagues to create new digital materials from manuscripts (<cite data-cite="1584927/QNKDRAV8"></cite>). Second, the developers are searching for an outlet to publish the metadata associated with the correspondence, the full texts of materials from the library, and the code for running analysis. At the time of the most intensive project development, the project leads' local institutions were not in a place to support long-term scalable hosting of the project. GaLiLeO is thus a project in search of scholarly and institutional collaborators for building a user-friendly interface, a robust underlying data set, and hosting.
<!-- #endregion -->

Despite these limitations, the preliminary tools in GaLiLeO do facilitate the kind of question making that has guided humanist investigation. Margherita Sarrocchi's letter has been uncovered for its unusual lexical choices and contextual variety. Her style, lexical richness, and document complexity were seen in comparison to contemporaries without the siloes of gender, genre, affiliations, or chronology that often shape corpus-scale document organization and analysis. The tools also documented the popular subjects not mentioned by Sarrocchi. The computational and quantitative results become a window onto the collection and indication of fruitful pathways, rather than a declaration of large-scale patterns that often obscure variations. By providing a way to enter the corpus without inherited interpretive lenses, GaLiLeO invites the continued work of discovery, uncovering, recreating, differentiating, evaluating, contextualizing, and documenting representations and expressions.

<!-- #region tags=["narrative"] -->
The day-long workshop also generated exciting ideas about what a project like this could be. The energy and interest were palpable. The diverse range of digital community needs that were discussed went far beyond the scope of GaLiLeO. The conversations also identified immediate and persistent obstacles. The project directors realized immediately at the workshop that the ability to see words contextualized at multiple levels of address both identified points where a collaboration was necessary and how the tools facilitated that collaboration. The literary scholar and digital humanist could see the poetic and dramatic points of contact with the texts and narratives that were most familiar to the historian of science collaborator for other attributes. With someone like Sarrocchi, this reveals that the historian might consult with an art historian to better understand the similarity with the painter Cigoli, a social historian or historian of science specializing in the creation and reception of institutions for validating knowledge in early modern Italy, and a literary scholar for the connections between her letters to Galileo and the types of expression found in her epic poem.
<!-- #endregion -->

<!-- #region tags=["narrative"] -->
The other general pieces of feedback included the following features, listed here to help with the planning of future DH projects:
- More tools would be welcome: an API, historical text reuse detection, reporting on avoided topics, named entities, and a “humanistic suggestion tool” that offers models for queries along with rationales.
- More documents would be welcome: marginalia, more library texts, better OCR, images, and machine readable text based on manuscripts instead of 19th century editorial versions of letters.
- Transmedia linguistic analysis would be a valuable further step.
- GaLiLeO represents an opportunity to bring new perspective on digital projects that are considered “complete” by linking from its terms, people, years, and texts to the lemmario, biographies, chronologies, and bibliographies that have been developed by colleagues in Italy and the U.S. These include the Galileo//thek@, The Galileo Project (<cite data-cite="1584927/JEPMCMF5"></cite>), and even the authority file of 8,000 names connected to Galilean materials created by the Museo Galileo (http://www.museogalileo.it/esplora/biblioteche/biblioteca/archivionomi.html){:target="_blank"}
- The project will benefit from phased roll-outs of the underlying data and metadata, particularly as more texts from the library are added and additional metadata tags are created.
- This is an opportunity to involve undergraduate and graduate students of Italian in an exploration of the history of Italy as well as the ways in which Italian content can influence the development of predominantly Anglophone technology. It could also be a platform to put specialist, informed readers in contact with novice, curious readers.
<!-- #endregion -->

<!-- #region tags=["narrative"] -->
The field of Galileo studies is moving in directions that still require the attentive philological study of what Galileo and his contemporaries wrote, but with the integration of other disciplinary perspectives. Some of the new scholarly work on Galileo focuses on visual culture, both in terms of diagrams and illustrations but also the arts. Renewed attention has been brought to Galileo's marginalia and reading practices. Researchers are also pushing back against claims of exceptionalism to highlight linguistic traditions in which Galileo participated and also the popular topics that he avoided. Ultimately, embedding the project within the digital Galileo ecosystem would benefit the field more than creating a new digital history tool with claims to being something definitive that incorporates all materials. Using this tool in conjunction with the lemmatized resources in the Galileo//thek@ or the names in The Galileo Project would still maintain the experimental, exploratory spirit of the GaLiLeO tools. The Archilet - Reti Epistolari project has already created a model for this with metadata related to literary correspondence in Italy 1600-1800 (<cite data-cite="1584927/EPV67BFC"></cite>). While GaLiLeO cannot yet address these aspects of embeddedness, the motivated user will be able to connect the output from these tools as search queries in this larger ecosystem.
<!-- #endregion -->

## Project Credits

<!-- #region tags=["narrative"] -->
It is important to note that the successful demonstration of the GaLiLeO prototype was also the result of several groups of collaborators. A special note of thanks is owed to Stephen Houser, Director of Academic Technology and Consulting at Bowdoin College, for his assistance with the preparation of this article. Other collaborators included:

<br>_Galileo’s Correspondence_
- Hannah Marcus and Paula Findlen: metadata and tagging schema of letters
- Data curators: Hannah Marcus, Daniele Macuglia, Rachel Midura, Mackenzie Cooley, Paolo Savoia, Demetrius Loufas, Brian Brege, Padraic Rohan, Chris Bacich, Julia Roever, Charlotte Thun-Hohenstein
- Undergraduate assistants: Kyle Lee-Crossett, Max Morales
- Morgan MacLeod: Python tools for tag analysis

<br> _Galileo’s Library_
- Crystal Hall: GaLiLeO infrastructure & tool development, corpus integration, library and correspondence document gathering, text cleaning, analysis, documentation, coordination with Harvard IT support for the workshop in September 2018.
- Aaron Gilbreath, Academic Technology & Consulting, Bowdoin College: experimental shiny app design for visualizing descriptions of the corpus (no longer supported)
- Additional transcribers and text cleaners: Gabriella Papper ’18, Dean Zucconi ’19, Ingrid Horton (MAI Services)

<br> _Workshop Support_
- William Barthelemy, Academic Technology, Harvard University Institutional Technology
<!-- #endregion -->

<!-- #region tags=["hidden"] -->
## Bibliography
<!-- #endregion -->

<!-- #region tags=["hidden"] -->
<div class="cite2c-biblio"></div>
<!-- #endregion -->


```R vscode={"languageId": "r"}
# Check R version
R.version
```

