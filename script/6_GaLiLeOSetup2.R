

# Multiple plot function
# http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}


#Get index of files by ID
Full_IDs <- as.character()
for (i in 1:length(text_attributes)){
  Full_IDs[i] <- text_attributes[[i]]$FullID
}

IDs <- as.character()
for (i in 1:length(text_attributes)){
  IDs[i] <- text_attributes[[i]]$ID
}

stop_words <- scan("script/ItalianStopWordsTopicMod.txt", what = "character", sep = "\n")

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
earliest <- min(as.numeric(as.character(years_df$Year)))-5
latest <- max(as.numeric(as.character(years_df$Year)))+5

# Get the Lengths
lengths_df <- as.data.frame(table(corpus_attributes$Length), stringsAsFactors = F)
lengths_df$Var1 <- as.numeric(lengths_df$Var1)
lengths_df$Color <- "No"
colnames(lengths_df) <- c("Lengths", "NumberOfTexts", "Color")

# Present documents in corpus
# given metadata list
# output DocType, Sender/Author, TitlePageInfo
view_files <- function(metadata_list){
  cat("There are ", length(metadata_list), " files in the corpus:")
  for(i in 1:length(metadata_list)){
    DocType <- metadata_list[[i]]$Metadata$DocType
    if(DocType == "Letter1of1"){
        DocType <- "Letter"
    }
    cat("\nFile ", i, " : ID", metadata_list[[i]]$Metadata$ID, "\n", "Document Type:", DocType, " by ", metadata_list[[i]]$Metadata$Author, " in ", metadata_list[[i]]$Metadata$Title, ".")
  }
}

get_ID_from_index <- function(index_pos, metadata_list){
  cat("The following file(s) is/are associated with that year:\n")
  for(i in 1:length(index_pos)){
    cat("\nThis is File ", index_pos[i], " : ID ", metadata_list[[index_pos[i]]]$Metadata$ID, "\n", "Document Type:", metadata_list[[index_pos[i]]]$Metadata$DocType, " by ", metadata_list[[index_pos[i]]]$Metadata$Sender, " in ", metadata_list[[index_pos[i]]]$Metadata$Title, ".")
  }
}

# Get dates, given metadata list
# output earliest, latest, spread
date_range <- function(all_years){
  all_years <- sort(years, decreasing = F)
  earliest_year <- all_years[1]
  latest_year <- all_years[length(all_years)]
  cat("The earliest year is ", earliest_year, ".\nThe latest year is ", latest_year, ".\n")
  cat("Here is a numerical summary of the spread of dates covered:\n")
  print(summary(all_years))
}

# Author information
authors <- function(metadata_list){
  author_v <- as.character()
  for(i in 1:length(metadata_list)){
    author_v[i] <- metadata_list[[i]]$Metadata$Author
  }
  authors_table <- table(author_v)
  authors_sorted <- authors_table[order(names(authors_table))]
  authors_df <- as.data.frame(authors_sorted)
  colnames(authors_df) <- c("AuthorName", "NumberOfDocuments")
  print(authors_df)
}

author_v <- as.character()
for(i in 1:length(corpus)){
  author_v[i] <- corpus[[i]]$Metadata$Author
}

# Document information
# Given a list of texts, choose one
# Then, given the ID of one, output: x of y written by author in corpus
# date/how many before/how many after,
# Length, comparison to others
# Vocab types/tokens, comparison to others
# Euclidean similarity
# Cosine similiarity
# Top Three Topics - link/load images?
choose_doc <- function(text_list, corpus_metadata, full_ID){
  tl_index <- which(Full_IDs == full_ID)
  for (j in 1:length(tl_index)){
    cat("This is 1 of ", text_list[[tl_index[j]]]$AuthorDocs, " documents written by ", text_list[[tl_index[j]]]$Author, "in the corpus.\n")
    cat("The title is: ", corpus_metadata[[tl_index[j]]]$Metadata$Title, "\n")
    cat("\nIt was written or published ", text_list[[tl_index[j]]]$Year, ".\n")
    cat(text_list[[tl_index[j]]]$YearInfo$SameYear, "document(s) was (were) dated (or published) in the same year.\n")
    cat(text_list[[tl_index[j]]]$YearInfo$Before, "document(s) was (were) dated (or published) in the years before it.\n", 
        text_list[[tl_index[j]]]$YearInfo$After, "document(s) was (were) dated (or published) in years after it.\n")
    target_y <- text_list[[tl_index[j]]]$Year
    years_df$Color[which(years_df$Year == target_y)] <- "Yes"
    
   # y<-ggplot(years_df, aes(x=as.numeric(Year), y=Count, fill=factor(Color))) +
   #   geom_bar(stat="identity")+theme_minimal() +
   #   theme(axis.text.x= element_text(angle = 45)) +
   #   theme(legend.position = "none") +
   #   scale_x_continuous(name = "Year", breaks = seq(earliest,latest, by = 5)) +
   #   labs(title = "Comparison of Selected Text (in Blue) by Year")
    #out_dir <- "GaLiLeOResults/"
    #year_plot_name <- paste(out_dir, full_ID, "YearComparison.png", sep = "")
    #ggsave(filename = year_plot_name, plot = y, device = "png")
    #dev.off()
    cat("\nThe document has ", length(text_list[[tl_index[j]]]$TokensWOPunct), 
        "tokens (unique strings of characters), not treating punctuation as a word.\n",
            text_list[[tl_index[j]]]$Lengths$AreLonger, "document(s) is (are) longer.\n", 
            text_list[[tl_index[j]]]$Lengths$AreShorter, "document(s) is (are) shorter.\n")
    if(text_list[[tl_index[j]]]$Lengths$AreSame == 1){
      cat("It is the only document with this length.\n")
    }
    else{
      cat(text_list[[tl_index[j]]]$Lengths$AreSame, "document(s) is (are) the same length.\n")
    }
    target_l <- length(text_list[[tl_index[j]]]$TokensWOPunct)
    lengths_df$Color[which(lengths_df$Lengths == target_l)] <- "Yes"
    #l <- ggplot(lengths_df, aes(x=as.factor(NumberOfTexts), y = Lengths)) +
    #  geom_jitter(width = 0.25, aes(color = Color)) +
    #  theme(legend.position = "none") +
    #  scale_x_discrete(name = "Number of Texts")+#, limits = factor(lengths_df$NumberOfTexts))+#seq(0,16, by =2)) +
    #  scale_y_log10(labels = scales::comma) +
    #  labs(title = "Comparison of Selected Text (in Blue) by Length")
    #lengths_plot_name <- paste(out_dir, full_ID, "LengthComparison.png", sep = "")
    #ggsave(filename = lengths_plot_name, plot = l, device = "png")
    #dev.off()
    cat("\nHere is some information about the type/token ratio, often a measure of linguistic complexity. A value closer to 1 indicates the frequent introduction of new words with little repetition.\n",
        "The TTR (includes punctuation as a token) for the document is:", text_list[[tl_index[[j]]]]$TTR$TTR_P, ".\n",
        "Documents in the same percentile in the corpus are:", text_list[[tl_index[[j]]]]$TTRComparison$CorpusP$BinMates, "\n",
        
        "The TTR (not including punctuation as a token) for the document is:", text_list[[tl_index[[j]]]]$TTR$TTR_NOP, ".\n",
        "Documents in the same percentile in the corpus are:", text_list[[tl_index[[j]]]]$TTRComparison$CorpusNoP$BinMates, "\n")
        
    target <- text_list[[tl_index[j]]]$FullID
    
    corpus_TTR_df <- rbind(corpus_attributes$TTR$TTR_P$CorpusTTR_P$DF, corpus_attributes$TTR$TTR_NOP$CorpusTTR_NOP$DF)
    subset <- corpus_TTR_df[which(corpus_TTR_df$ID == target),]
    #ttr_c <- ggplot(corpus_TTR_df, aes(x=Punctuation, y = TTR)) +
    #  geom_jitter(width = 0.25, height = 0, alpha = 0.40, aes(col = Color)) +
    #  geom_point(data = subset, aes(x=Punctuation, y = TTR, col = "Blue")) +
    #  theme(legend.position = "none") +
    #  ylim(0,1) +
    #  labs(title = "Selected Text (in Blue) \nvs. TTR in Corpus")
    
    GG_TTR_df <- rbind(corpus_attributes$TTR$TTR_P$GGTTR_P$DF, corpus_attributes$TTR$TTR_NOP$GGTTR_NOP$DF)
    #ttr_gg <- ggplot(GG_TTR_df, aes(x=Punctuation, y = TTR)) +
    #  geom_jitter(width = 0.25, height = 0, alpha = 0.4, aes(color = Color)) +
    #  geom_point(data = subset, aes(x=Punctuation, y = TTR, col = "Blue")) +
    #  theme(legend.position = "none") +
    #  ylim(0,1) +
    #  labs(title = "\nTTR in Galileo's Documents")+
    #  theme(axis.title.y=element_blank(), axis.ticks.y=element_blank(), axis.text.y = element_blank())
    
    NotGG_TTR_df <- rbind(corpus_attributes$TTR$TTR_P$NotGGTTR_P$DF, corpus_attributes$TTR$TTR_NOP$NotGGTTR_NOP$DF)
    #ttr_notgg <- ggplot(NotGG_TTR_df, aes(x=Punctuation, y = TTR)) +
    #  geom_jitter(width = 0.25, height = 0, alpha = 0.4, aes(colour = Color)) +
    #  geom_point(data = subset, aes(x=Punctuation, y = TTR, col = "Blue")) +
    #  theme(legend.position = "none") +
    #  ylim(0,1) +
    #  labs(title = "\nTTR in Documents not by Galileo")+
    #  theme(axis.title.y=element_blank(), axis.ticks.y=element_blank(), axis.text.y = element_blank())
    
    cat("\nThe vocabulary in this document is notable for the following reasons:\n")
    hapax_string <- paste(text_list[[tl_index[[j]]]]$VocabDistinctions$HapaxInCorpus, sep = ", ")
    cat("This is the only document in the corpus that uses the following words: ", hapax_string, ".\n")
    not_top_one_length <- length(text_list[[tl_index[[j]]]]$VocabDistinctions$NotTheseTopOne)
    cat("This document does not include", not_top_one_length, "of the words that have the highest frequency (the words in the 99th percentile):\n")
    cat("To see these words (there may be hundreds of them), run the cell below.\n")
    closest_E <- text_list[[tl_index[[j]]]]$Euclidean$Closest
    furthest_E <- text_list[[tl_index[[j]]]]$Euclidean$Furthest
    closest_C <- text_list[[tl_index[[j]]]]$Cosine$Closest
    furthest_C <- text_list[[tl_index[[j]]]]$Cosine$Furthest
    cat("\nPatterns of use of high frequency words can identify similar styles using two measurements.\n\t",
        "One measurement, Euclidean distance, describes direct correspondence of word use frequency:\n",
        "The most similar document to", full_ID, "is", closest_E, ". The least similar is", furthest_E, ".\n")
    eucl_distances <- text_list[[tl_index[[j]]]]$Euclidean$All
    eucl_distances <- eucl_distances[order(eucl_distances$Distance),]
    e_rows <-nrow(eucl_distances)
    eucl_subset <- eucl_distances[c(1:10, (e_rows-10):e_rows),]
    eucl_subset$Index <- seq(1, nrow(eucl_subset))
   
    #e <- ggplot(eucl_subset) + geom_point(aes(x=Index,y=Distance)) +
    #  geom_text(aes(x=Index-.05, y=Distance+.01, label = Texts, angle = 75))+#,
                #fontface = "bold",position=position_jitter(width=.010,height=.010))+
      #geom_label_repel(aes(Index, Distance, label = Texts),
       #                box.padding = 0.35, point.padding = 0.5,
        #               segment.color = 'grey50') +
      #theme_classic(base_size = 12) +
      #theme(axis.title.x=element_blank(),
      #      axis.text.x=element_blank(),
      #      axis.ticks.x=element_blank())+
      #labs(title = "Euclidean Distance from 10 Closest and Furthest Texts in Corpus")
    #euclid_plot_name <- paste(out_dir, full_ID, "EuclidComparison.png", sep = "")
    #ggsave(filename = euclid_plot_name, plot = e, device = "png")
    #dev.off()
    
    cat("The second type of measurement is Cosine similarity, which describes proportional correspondence of word use frequency:\n",
        "The most similar document according to this measurement is", closest_C, ". The least similar is", furthest_C, ".\n")
    cos_distances <- text_list[[tl_index[[j]]]]$Cosine$All
    cos_distances <- cos_distances[order(cos_distances$Similarity),]
    c_rows <- nrow(cos_distances)
    cos_subset <- cos_distances[c(1:10, (e_rows-10):e_rows),]
    cos_subset$Index <- seq(1, nrow(cos_subset))
    #c <- ggplot(cos_subset) + geom_point(aes(x=Index,y=Similarity)) +
      #geom_text(aes(x=Index-0.05, y=Similarity+0.01, label = Texts, angle=75))+#,
                #fontface = "bold",position=position_jitter(width=1,height=1))+
      #geom_label_repel(aes(Index, Similarity, label = Texts),
       #                box.padding = 0.35, point.padding = 0.5,
        #               segment.color = 'grey50') +
      #theme_classic(base_size = 12)+
      #theme(axis.title.x=element_blank(),
      #      axis.text.x=element_blank(),
      #      axis.ticks.x=element_blank())+
      #labs(title = "Cosine Similarity to 10 Most and Least Similar Texts in Corpus")
    #cosine_plot_name <- paste(out_dir, full_ID, "CosineComparison.png", sep = "")
    #ggsave(filename = cosine_plot_name, plot = c, device = "png")
    #dev.off()
    cat("\nTopic modeling offers another way to see connections. This document is associated with the following topics in the corpus:\n")
    for(t in 1:nrow(text_list[[tl_index[[j]]]]$Top3Topics)){
      cat("Topic", t, 100*as.numeric(text_list[[tl_index[[j]]]]$Top3Topics[t,2]), "%:", as.character(text_list[[tl_index[[j]]]]$Top3Topics[t,1]), "\n")
    } 
    #multiplot(y, l)
    #ttr_plot_name <- paste(out_dir, full_ID, "TTRComparison.png", sep = "")
    #png(filename = ttr_plot_name, h = 500, w= 1000)
    #multiplot(ttr_c, ttr_gg, ttr_notgg, cols = 3)
    #dev.off()
    
    #multiplot(ttr_c, ttr_gg, ttr_notgg, cols = 3)
    #multiplot(e, c)
    #dev.off()
    # print(text_list[[tl_index[[j]]]]$Top3TopicsWCs[1])
    # x = display_jpeg(file = text_list[[tl_index[[j]]]]$Top3TopicsWCs[1])
    # y = display_jpeg(file = text_list[[tl_index[[j]]]]$Top3TopicsWCs[2])
    # z = display_jpeg(file = text_list[[tl_index[[j]]]]$Top3TopicsWCs[3])
    # multiplot(x, y, z, cols = 3)

  }
  
}

read_doc <- function(text_list, ID){
  #tl_index <- which(Full_IDs == ID)
  for (j in 1:length(ID)){
    text <- text_list[[ID]]$String
    cat(text)
  }
}

word_info <- function(type_list, type){
  cat("The earliest occurrence of this word is ", type_list[[type]]$EarliestAppearance, ".\n")
  cat("The latest occurrence of this word is ", type_list[[type]]$LatestAppearance, ".\n")
  #cat("It appears",type_list[[type]]$TitleLevel$RawFreq, "times in titles of books.\n") #Not implemented
  cat("It appears", sum(type_list[[type]]$CorpusLevel$AllRawFreq), "times in the corpus overall:\n")
  #print(summary(as.numeric(type_list[[type]]$CorpusLevel$AllRawFreq)))
  inGG <- type_list[[type]]$CorpusLevel$GGRawFreq
  if(class(inGG) == "character"){
    cat(inGG, "\n")
  }
  else{
    cat(type_list[[type]]$CorpusLevel$GGRawFreq, "time(s) in documents by Galileo,\n")
  }
  cat(type_list[[type]]$CorpusLevel$NotGGRawFreq, "time(s) in documents by others.\n")
  cat("The word appears in the following topics:\n")
  print(type_list[[type]]$TopicWeight)
  df <- type_list[[type]]$DocLevel
  type_plot <- ggplot(df, aes(x = as.numeric(Year), fill = factor(GG)))+
    geom_bar(stat = "count") +
    theme(axis.title.x=element_text("Year"))+
    labs(title = paste("Chronological Use of ", type, ".", sep = ""), x = "Year")+
    scale_fill_discrete(name ="Author", breaks = c("GG", "NotGG"), labels = c("Galileo", "Other Authors"))
  type_plot
}

get_KWIC <- function(type_list, type){
    df<- type_list[[type]]$DocLevel
    df[order(Year), ]
    # ID <- type_list[[type]]$DocLevel[[k]]$ID
    # Year <- type_list[[type]]$DocLevel[[k]]$Year
    # cat("Appears in document ", ID, "written or published ", Year, ":\n")
    # KWIC_l <- type_list[[type]]$DocLevel[[k]]$Data$KWIC[[1]]
    # KWIC_vectors <- list()
    # for (l in 1:length(KWIC_l)){
    #   KWIC_vectors[[l]] <- as.character(KWIC_l[[l]])
    # }
    # for(i in 1:length(KWIC_vectors)){
    #   string <- paste(KWIC_vectors[[i]][-c(1:2)], sep=" ")
    #   cat(string, "\n")
    # }
    # cat("\n")
}

see_KWIC <- function(type_list, type, stop_words){
  
  #if(expanded_stop_words == "Yes"){
  #  stop_words <- c(stop_words, expanded_stop_words)
  #}
  df<- type_list[[type]]$DocLevel
  ordered_df <- df[order(Year), ]
  wrappers <- ordered_df$Context
  wrappers <- gsub(type, "", wrappers)
  wrapper_list <- list()
  for (i in 1:length(wrappers)){
    wrapper_year <- ordered_df$Year[i]
    wrapper_mess <- unlist(strsplit(wrappers[i], " "))
    wrapper_clean <- wrapper_mess[which(wrapper_mess != "")]
    wrapper_trimmed <- wrapper_clean[-1] # vector
    wrapper_df <- as.data.frame(cbind(Year = wrapper_year, Term = wrapper_trimmed), stringsAsFactors = FALSE)
    wrapper_list[[i]] <- wrapper_df
  }
  wrappers_df <- do.call(rbind, wrapper_list)
  wrappers_df <- wrappers_df[-which(wrappers_df$Term %in% stop_words),]
  count <- sort(table(wrappers_df$Term), decreasing = T)
  wrappers_subset <- wrappers_df[which(wrappers_df$Term %in% names(count)[1:7]),]
  wrapper_plot <- ggplot(wrappers_subset, aes(x = as.numeric(Year)))+
    geom_bar(stat="count", aes(fill = as.factor(Term)), width = 1) +
    #theme(axis.title.x=element_text("Year"))+
    labs(title = paste("Chronological Use of Terms with ", type, ".", sep = ""), x = "Year") +
    #scale_x_discrete(breaks = seq((min(as.numeric(wrappers_subset$Year))-5), (max(as.numeric(wrappers_subset$Year))+5), by = 5)) +
    scale_fill_discrete(name ="Term")
  wrapper_plot
}

TopWordsNotInText <- function(text_list, ID){
  not_top_one_string <- paste(text_list[[ID]]$VocabDistinctions$NotTheseTopOne, sep = ", ")
  return(not_top_one_string)
}

find_types_by_range <- function(corpus_list, GG = c("yes", "no", "high", "low"), NotGG= c("yes", "no", "high", "low"), size){
  options(scipen = 999)
  #max_freq <- max(corpus_list$RelDocTermMatrix)
  #min_freq <- 
  cat("For context, here is the overall range of relative frequencies in the corpus:\nThe lowest frequency is 0. (No document uses all words in the corpus.)\nThe highest is:\n")
  print(max(corpus_list$RelDocTermMatrix[, -ncol(corpus_list$RelDocTermMatrix)]))
  
  cat("A numeric summary of the means for each frequency describes this context in more detail:\n")
  print(summary(colMeans(corpus_list$RelDocTermMatrix[,-ncol(corpus_list$RelDocTermMatrix)])))
  #GG_data <- corpus_list$RelDocTermMatrix[which(corpus_list$RelDocTermMatrix$Author == "GG"),-ncol(corpus_list$RelDocTermMatrix)]
  GG_data <- as.data.frame(corpus_list$GGRel, stringsAsFactors = FALSE)
  GG_vocab <- as.character(GG_data[,1])
  GG_summary <- summary(GG_data[,2])
 
  notGG_data <- as.data.frame(corpus_list$NotGGRel, stringsAsFactors = FALSE)
  notGG_vocab <- as.character(notGG_data[,1])
  notGG_summary <- summary(notGG_data[,2])
    
  GG_doesNotUse <- notGG_vocab[-which(notGG_vocab %in% GG_vocab)]
  
  notGG_doesNotUse <- GG_vocab[-which(GG_vocab %in% notGG_vocab)]
  if(GG == "yes"){
    cat("Galileo uses ", length(GG_vocab), " different words.")
    comp_vocab_1 <- GG_vocab
    comparison_df <- GG_data[which(GG_data[,1] %in% GG_vocab),]
  }
  if(GG == "no"){
    cat("Galileo does not use ", length(GG_doesNotUse), " words that are found elsewhere in the corpus.")
    comp_vocab_1 <- GG_doesNotUse
    comparison_df <- notGG_data[-which(notGG_data[,1] %in% GG_doesNotUse),]
  }
  if(GG == "high"){
    cat("The range of mean vocabulary frequencies in Galileo's documents is the following.\n High is considered higher than the third quartile (75th percentile).\n")
    print(GG_summary)
    comp_vocab_1 <- GG_data[which(GG_data[,2] > GG_summary[5]),1]
    comparison_df <- GG_data[which(GG_data[,2] > GG_summary[5]),]
  }
  if(GG == "low"){
    cat("The range of mean vocabulary frequencies in Galileo's documents is the following.\n Low is considered higher than the first quartile (25th percentile).\n")
    print(GG_summary)
    comp_vocab_1 <- GG_data[which(GG_data[,2] < GG_summary[2]), 1]
    comparison_df <- GG_data[which(GG_data[,2] < GG_summary[2]),]
  }
  if(NotGG == "yes"){
    cat("Other authors use ", length(notGG_vocab), " words in the corpus. ")
    comp_vocab_2 <- notGG_vocab
  }
  if(NotGG == "no"){
    cat("Other authors do not use ", length(notGG_doesNotUse), "words that Galileo does use. ")
    comp_vocab_2 <- notGG_doesNotUse
  }
  if(NotGG == "high"){
    cat("The range of mean vocabulary frequencies in other authors' documents is the following.\n High is considered higher than the third quartile (75th percentile).\n")
    print(notGG_summary)
    comp_vocab_2 <- notGG_data[which(notGG_data[,2] > notGG_summary[5]),1]
  }
  if(NotGG == "low"){
    cat("The range of mean vocabulary frequencies in other authors' documents is the following.\n Low is considered higher than the first quartile (25th percentile).\n")
    print(notGG_summary)
    comp_vocab_2 <- notGG_data[which(notGG_data[,2] < notGG_summary[2]), 1]
  }
  
  cat("Here are the words that match your query:\n")
  matches <- which(comp_vocab_1 %in% comp_vocab_2)
  print(paste(comp_vocab_1[matches], collapse = ", "))
  subset <- comparison_df[which(comparison_df[,1] %in% comp_vocab_1[matches]),]
  
  ranks <- rank(subset[,2], ties.method = "first")
  #print(length(ranks))
  #print(length(unique(ranks)))
  #print(summary(ranks))
  #print(summary(subset[,2]))
  highs <- which(ranks < (size+1))
  #print(which(ranks < 26))
  #print(highs)
  lows <- which(ranks > (length(ranks)-size))
  ordered_subset <- subset[c(highs, lows),]
  print(dim(ordered_subset))
  ordered_result <- ordered_subset[order(ordered_subset[,2]),]
  print(dim(ordered_result))
  print(ordered_result[1:size,])
  print(ordered_result[(size+1):nrow(ordered_result),])
  #results_filename <- paste("TypeResultsGG", GG, "NotGG", NotGG, "Comparison", sep = "")
  #write.csv(subset, results_filename, row.names = F)
}

compare_author_vocabulary <- function(author_name, metadata_list, text_list, corpus_list){
  author_rows <- which(author_v == author_name)
  author_docs <- as.character()
  for(i in 1:length(author_rows)){
    author_docs[i] <- corpus[[i]]$ID
  }
  author_types <- as.character()
  for(i in 1:length(author_docs)){
    doc_types <- text_list[[author_docs[i]]]$Types
    author_types <- c(author_types, doc_types)
  }
  cat(author_name, " uses ", length(unique(author_types)), " different words (not including punctuation).\n")
  cat("The overall corpus contains ", length(corpus_list$AllTypes), "different words (not including punctuation.\n")
}
