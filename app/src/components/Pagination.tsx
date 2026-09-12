type Props = {
  page: number;
  pageSize: number;
  total: number;
  onPage: (page: number) => void;
};

export function Pagination({ page, pageSize, total, onPage }: Props) {
  const pages = Math.max(1, Math.ceil(total / pageSize));
  return (
    <div className="edu-pager">
      <button type="button" className="ghost" disabled={page <= 1} onClick={() => onPage(page - 1)}>
        Anterior
      </button>
      <span>
        Página {page} de {pages} · {total} en total
      </span>
      <button type="button" className="ghost" disabled={page >= pages} onClick={() => onPage(page + 1)}>
        Siguiente
      </button>
    </div>
  );
}
