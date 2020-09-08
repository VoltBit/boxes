package client

type CassandraClient struct {
}

func NewCasssandraClient() *CassandraClient {
	return &CassandraClient{}
}

func (t *CassandraClient) Start() error {
	return nil
}
