# R course for beginners
# Week 7
# assignment by Rotem Falach, id 204271258

# I wrote this code for homework in R course a week ago
# we learned about loops, and analyzed subjects data of stroop task 

# read data
files = dir(path="./RCourse/stroop_data", full.names = TRUE)
df = data.frame()

for (file in files) {
  temp = read.csv(file)
  df = rbind(df, temp)
}

# add columns
df = df |>
  mutate(congureancy = ifelse(df$correct_response == df$participant_response, "לא תואם", "תואם"),
         task = ifelse(grepl('word_reading_cong', df$condition), "שיום הדיו", "קריאה"))

precision = df$correct_response == df$participant_response
df = df |>
  mutate(precision = precision * 1)

# pick columns and check types  
selected_df = df |> select(subject, task, congureancy, block, trial, precision, rt)
sapply(selected_df, class)

selected_df$task <- as.factor(selected_df$task)
selected_df$congureancy <- as.factor(selected_df$congureancy) 
contrasts(selected_df$task)
contrasts(selected_df$congureancy)

save(selected_df, file='raw_data.R')
