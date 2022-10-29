library(sparklyr)
library(dplyr)
library(ggplot2)

# Connect to Spark
conf <- spark_config()
conf$`sparklyr.cores.local` <- 6
conf$spark.executor.cores <- 6
conf$spark.executor.memory <- "3G"
conf$`sparklyr.shell.driver-memory` <- "3G"
conf$spark.memory.fraction <- 0.9
conf$spark.dynamicAllocation.enabled <- TRUE
conf$spark.shuffle.service.enabled <- TRUE

sc<-spark_connect(
  master = "spark://spark-master:7077",
  spark_home="/home/rstudio/spark/spark-3.1.1-bin-hadoop3.2",
  app_name="RSpark",
  config=conf
)

spark_disconnect(sc)

# Load to Spark
flights_tbl <- copy_to(sc, nycflights13::flights, "flights")

# Operate on Spark
delay <- flights_tbl %>%
  group_by(tailnum) %>%
  summarise(count = n(), dist = mean(distance), delay = mean(arr_delay)) %>%
  filter(count > 20, dist < 2000, !is.na(delay)) %>%
  collect()

# Plot the results
ggplot(delay, aes(dist, delay)) +
  geom_point(aes(size = count), alpha = 1/2) +
  geom_smooth() +
  scale_size_area(max_size = 2)



