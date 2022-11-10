-- 1. List all customers who live in Texas (use JOINs)
SELECT first_name, last_name, address, district
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';

-- 2. Get all payments above $6.99 with the Customer's Full Name
SELECT first_name, last_name, payment.amount
FROM customer
FULL JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99
ORDER BY amount;

-- 3. Show all customers names who have made total payments over $175(use subqueries)
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);

-- 4. List all customers that live in Nepal (use the city table)
SELECT first_name, last_name, city.city, country.country
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
FULL JOIN city
ON address.city_id = city.city_id
FULL JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal';

-- 5. Which staff member had the most transactions?
SELECT first_name, last_name, COUNT(payment.staff_id)
FROM staff
FULL JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY first_name, last_name
ORDER BY COUNT(payment.staff_id) DESC;

-- 6. How many movies of each rating are there?
SELECT rating, COUNT(film_id)
FROM film
GROUP BY rating
ORDER BY COUNT(film_id) DESC;

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	WHERE amount > 6.99
	GROUP BY customer_id
	HAVING COUNT(customer_id) = 1
);

-- 8. How many free rentals did our store give away?
SELECT amount, COUNT(payment.rental_id)
FROM payment
FULL JOIN rental
ON payment.rental_id = rental.rental_id
WHERE amount = 0.00
GROUP BY amount;