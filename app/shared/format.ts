import type { Category } from "#app/shared/services/listings";

export function formatSalary(min: number, max: number): string {
  let k = (n: number) => `$${Math.round(n / 1000)}k`;

  return min === max ? k(min) : `${k(min)} – ${k(max)}`;
}

export function formatCents(cents: number): string {
  let digits = cents % 100 === 0 ? 0 : 2;

  return "$" + (cents / 100).toLocaleString("en-US", { minimumFractionDigits: digits, maximumFractionDigits: digits });
}

export function timeAgo(date: Date, now: Date = new Date()): string {
  let minutes = Math.max(0, Math.round((+now - +date) / 60000));

  if (minutes < 1) {
    return "just now";
  }

  if (minutes < 60) {
    return `${minutes}m ago`;
  }

  let hours = Math.round(minutes / 60);
  if (hours < 24) {
    return `${hours}h ago`;
  }

  let days = Math.round(hours / 24);

  return days === 1 ? "yesterday" : `${days}d ago`;
}

export function formatDate(date: Date): string {
  return date.toLocaleDateString("en-US", { month: "short", day: "numeric", year: "numeric" });
}

export function categoryClass(category: Category): string {
  return `is-${category}`;
}
