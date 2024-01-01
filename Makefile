install:
	make -C ./cmd/api install
	make -C ./cmd/batch_send install
	make -C ./cmd/batch_send_feedback install
	make -C ./pkg/email_distributor install

test:
	make -C ./cmd/api test
	make -C ./cmd/batch_send test
	make -C ./cmd/batch_send_feedback test
	make -C ./pkg/email_distributor test
