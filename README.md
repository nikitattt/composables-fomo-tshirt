# Dynamic Composable Accessory

## Dynamic accessory that visually changes when it’s time to play FOMO Nouns!

***23.11.2022 Update: Prop house prop included links to deployed contract that contained error that resulted in reversed colour show for the item. Instead of showing green color when auction ends it shows red and vise versa. Smart contract code was fixed as of today, but deployed contract haven't been updated yet.***

This is Prof Of Concept work to bring dynamic composable traits that change based on on-chain or irl events.

This contract display different trait look based on Nouns DAO auction state. When the auction is active, T-Shirt(accessory trait) is red coloured, but when auction ends and it's time to play FOMO, the t-shirt appearance will change to green colour, signalling that it's FOMO game time.

### Structure

Repo consists of two parts:

#### `/art`

It contains code for preparing(RLE encoding) art for storage in the contact.

#### `/contracts`

It contains modified ERC1155 token contract that implements `IComposablePart` so it can be used for composing.
