# Smart-Contacts

*Important note: This code is intended to be deployed through REMIX*

`FomoTShirtToken` is an experimental Prof Of Concept contract created to test the idea of dynamic composable traits.

It's modified ERC1155 token that implements `IComposablePart` so it can be used for composing.

## Current contract

Currently contract support displaying two variations of one trait based on Nouns DAO auction status.

After deploying and initializing the contract you wil need to load the palette and traits. (more on how to obtain palette and traits in `/art/README`).

Both palette and traits are loaded in `0x...` bytes format.

## Possible Improvements

Contract can be improved to have dynamic traits structure, as currently it's hardcoded `fomoTimePart`, `auctionTimePart` variables.

Trait selection logic can also be extended to make it more flexible and possible to accommodate user selectable contracts/structures for tracking.
