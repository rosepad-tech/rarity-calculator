# Calculator Aggregator Script

Shell script to get the traits, aggregates and builds the data to formulate rarity

## Process
Each metadata is processed. We count all the traits and add them all together. The script creates a json file that can be used as an input to the rarity calculator.

## Formula for rarity frontend calculator
Rarity Score for a Trait Value = `1 / ([Number of Items with that Trait Value] / [Total Number of Items in Collection])`

- Given a TokenID, we get the metadata
- metadata gives trait values
- apply the formula for each trait. This will give us the rarity score per trait.
- the sum of the entire trait score will give us the total rarity score.
