#include "postgres.h"

#include "libpq/pqformat.h"
#include "utils/builtins.h"

PG_MODULE_MAGIC;

PG_FUNCTION_INFO_V1(int4in);
PG_FUNCTION_INFO_V1(int4out);
PG_FUNCTION_INFO_V1(int4recv);
PG_FUNCTION_INFO_V1(int4send);

Datum
int4in(PG_FUNCTION_ARGS)
{
	char	   *num = PG_GETARG_CSTRING(0);

	PG_RETURN_INT32(pg_atoi(num, sizeof(int32), '\0'));
}

Datum
int4out(PG_FUNCTION_ARGS)
{
	int32		arg1 = PG_GETARG_INT32(0);
	char	   *result = (char *) palloc(12);	/* sign, 10 digits, '\0' */

	pg_ltoa(arg1, result);
	PG_RETURN_CSTRING(result);
}

Datum
int4recv(PG_FUNCTION_ARGS)
{
	StringInfo	buf = (StringInfo) PG_GETARG_POINTER(0);

	PG_RETURN_INT32((int32) pq_getmsgint(buf, sizeof(int32)));
}

Datum
int4send(PG_FUNCTION_ARGS)
{
	int32		arg1 = PG_GETARG_INT32(0);
	StringInfoData buf;

	pq_begintypsend(&buf);
	pq_sendint(&buf, arg1, sizeof(int32));
	PG_RETURN_BYTEA_P(pq_endtypsend(&buf));
}
