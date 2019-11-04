import { gql } from 'apollo-boost';

export const QUERY_ALL_STORES = gql`
query AllStores {
  stores {
    address
    code
  }
}
`;