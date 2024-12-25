# R course for beginners
# Week 7
# assignment by Rotem Falach, id 204271258

# number of subjects
raw = load("RCourse/raw_data.R")

# number of subjects
print(length(unique(selected_df$subject)))

# clean data
df_clean = na.omit(selected_df)

df_rt_filter = df_clean |>
  filter(rt / 1000 > 0.3) |>
  filter(rt / 1000 < 3)

# updated trial percentage
df_subject_after = df_rt_filter |>
  group_by(subject) |>
  summarise(
    count = n(),                         
    percent = (n() / nrow(df_rt_filter)) * 100
  )

# count the trials before cleaning
df_subject_before = selected_df |>
  group_by(subject) |>
  summarise(
    count = n(),                         
    percent = (n() / nrow(selected_df)) * 100
  )

# calculate the difference
diff = (df_subject_before$count - df_subject_after$count) * 100 / df_subject_before$count

# mean and std of the rejected trials
print(mean(diff))
print(sd(diff))
