# Insights from failed orders
Taxi booking cancellations impact both customers and service providers, leading to inefficiencies, revenue loss, and poor user experience. Understanding the key factors behind order cancellations can help optimize driver allocation, improve customer retention, and reduce order failures. This project aims to analyze order failure patterns , focusing on understanding the reasons for order cancellations before and after driver assignment, and identifying any temporal trends in order failures.   

**Business Problem**
---
Gett, previously known as GetTaxi, is an Israeli-developed technology platform solely focused on corporate Ground Transportation Management (GTM). They have an application where clients can order taxis, and drivers can accept their rides (offers). At the moment, when the client clicks the Order button in the application, the matching system searches for the most relevant drivers and offers them the order. In this task, we would like to investigate some matching metrics for orders that did not completed successfully, i.e., the customer didn't end up getting a car.

**Dataset Link:** https://platform.stratascratch.com/data-projects/insights-failed-orders  

**Objectives**
---
* Build up distribution of orders according to reasons for failure: cancellations before and after driver assignment, and reasons for order rejection. Analyse the resulting plot. Which category has the highest number of orders?
* Plot the distribution of failed orders by hours. Is there a trend that certain hours have an abnormally high proportion of one category or another? What hours are the biggest fails? How can this be explained?
* Plot the average time to cancellation with and without driver, by the hour. If there are any outliers in the data, it would be better to remove them. Can we draw any conclusions from this plot?
* Plot the distribution of average ETA by hours. How can this plot be explained?

**Key Insights**
---
* 74% of order failures occur before driver assignment, primarily due to customer impatience.
* Post-assignment cancellations still occur (2,811 orders), likely due to high waiting times.
* Morning rush (7:00–9:00 AM) and late-night (9:00 PM–1:00 AM) see the highest cancellation rates.
* Morning: Driver shortages and high demand lead to delays.
* Night: Limited driver availability results in unassigned orders.
* ETA exceeds 8 minutes (80th percentile) during peak hours, reducing customer trust and leading to cancellations.

**My Presentation Link:** https://github.com/mi-jayesh/Insights_from_failed_orders/blob/main/ppt_Insights%20from%20Failed%20Orders.pdf   

**Tools & Technologies Used**
---
**SQL:** Data cleaning and exploratory analysis.  
**Tableau:** Data visualization 
