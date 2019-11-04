import { gql } from 'apollo-boost';

export const QUERY_DISCOUNTS_FOR_STORE = gql`
query DiscountsForStore($storeId: String!) {
  storeByCode(code: $storeId) {
    discounts {
      id
      code
      price
      name
    }
  }
}
`;